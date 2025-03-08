// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IDiamondCut } from "../interfaces/IDiamondCut.sol";
import { IERC173 } from "../interfaces/IERC173.sol";

error InitializationFunctionReverted(address _initializationContractAddress, bytes _calldata);

library LibDiamond {
    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("diamond.standard.diamond.storage");
    bytes32 constant CLEAR_ADDRESS_MASK = bytes32(uint256(0xffffffffffffffffffffffff));
    bytes32 constant CLEAR_SELECTOR_MASK = bytes32(uint256(0xffffffff << 224));

    struct DiamondStorage {
        mapping(bytes4 => bytes32) facets; // Maps function selectors to facets and positions in the selectorSlots array
        mapping(uint256 => bytes32) selectorSlots; // Each slot holds 8 function selectors
        uint16 selectorCount; // Number of function selectors in selectorSlots
        mapping(bytes4 => bool) supportedInterfaces; // ERC-165 supported interfaces
        address contractOwner;
        address dialga;

    }

    event DiamondCut(IDiamondCut.FacetCut[] _diamondCut, address _init, bytes _calldata);

    function diamondStorage() internal pure returns (DiamondStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }

    function setContractOwner(address _newOwner) internal {
        DiamondStorage storage ds = diamondStorage();
        address previousOwner = ds.contractOwner;
        ds.contractOwner = _newOwner;
        emit IERC173.OwnershipTransferred(previousOwner, _newOwner);
    }

    function contractOwner() internal view returns (address) {
        return diamondStorage().contractOwner;
    }

    function enforceIsContractOwner() internal view {
        require(msg.sender == diamondStorage().contractOwner, "LibDiamond: Must be contract owner");
    }

    function diamondCut(
        IDiamondCut.FacetCut[] memory _diamondCut,
        address _init,
        bytes memory _calldata
    ) internal {
        DiamondStorage storage ds = diamondStorage();
        uint256 selectorCount = ds.selectorCount;
        bytes32 selectorSlot;

        if (selectorCount & 7 > 0) {
            selectorSlot = ds.selectorSlots[selectorCount >> 3];
        }

        for (uint256 facetIndex; facetIndex < _diamondCut.length;) {
            (selectorCount, selectorSlot) = addReplaceRemoveFacetSelectors(
                selectorCount,
                selectorSlot,
                _diamondCut[facetIndex].facetAddress,
                _diamondCut[facetIndex].action,
                _diamondCut[facetIndex].functionSelectors
            );
            unchecked {
                facetIndex++;
            }
        }

        if (selectorCount != ds.selectorCount) {
            ds.selectorCount = uint16(selectorCount);
        }

        if (selectorCount & 7 > 0) {
            ds.selectorSlots[selectorCount >> 3] = selectorSlot;
        }

        emit DiamondCut(_diamondCut, _init, _calldata);
        initializeDiamondCut(_init, _calldata);
    }

    function addReplaceRemoveFacetSelectors(
        uint256 selectorCount,
        bytes32 selectorSlot,
        address newFacetAddress,
        IDiamondCut.FacetCutAction action,
        bytes4[] memory selectors
    ) internal returns (uint256, bytes32) {
        DiamondStorage storage ds = diamondStorage();

        if (action == IDiamondCut.FacetCutAction.Add) {
            enforceHasContractCode(newFacetAddress, "LibDiamond: Add facet has no code");
            for (uint256 i; i < selectors.length;) {
                bytes4 selector = selectors[i];
                require(ds.facets[selector] == bytes32(0), "LibDiamond: Function already exists");
                ds.facets[selector] = bytes20(newFacetAddress) | bytes32(selectorCount);
                selectorSlot = addSelectorToSlot(selectorSlot, selectorCount, selector);
                selectorCount++;
                unchecked { i++; }
            }
        } else if (action == IDiamondCut.FacetCutAction.Replace) {
            enforceHasContractCode(newFacetAddress, "LibDiamond: Replace facet has no code");
            for (uint256 i; i < selectors.length;) {
                bytes4 selector = selectors[i];
                address oldFacetAddress = address(bytes20(ds.facets[selector]));
                require(oldFacetAddress != newFacetAddress && oldFacetAddress != address(0), "LibDiamond: Invalid replace");
                ds.facets[selector] = (ds.facets[selector] & CLEAR_ADDRESS_MASK) | bytes20(newFacetAddress);
                unchecked { i++; }
            }
        } else if (action == IDiamondCut.FacetCutAction.Remove) {
            for (uint256 i; i < selectors.length;) {
                bytes4 selector = selectors[i];
                require(ds.facets[selector] != bytes32(0), "LibDiamond: Function does not exist");
                selectorCount--;
                selectorSlot = removeSelectorFromSlot(selectorSlot, selectorCount, selector);
                delete ds.facets[selector];
                unchecked { i++; }
            }
        } else {
            revert("LibDiamondCut: Incorrect FacetCutAction");
        }

        return (selectorCount, selectorSlot);
    }

    function addSelectorToSlot(bytes32 selectorSlot, uint256 selectorCount, bytes4 selector) internal pure returns (bytes32) {
        uint256 position = (selectorCount & 7) << 5;
        return (selectorSlot & ~(CLEAR_SELECTOR_MASK >> position)) | (bytes32(selector) >> position);
    }

    function removeSelectorFromSlot(bytes32 selectorSlot, uint256 selectorCount, bytes4 selector) internal pure returns (bytes32) {
        uint256 position = (selectorCount & 7) << 5;
        return selectorSlot & ~(CLEAR_SELECTOR_MASK >> position);
    }

    function initializeDiamondCut(address _init, bytes memory _calldata) internal {
        if (_init == address(0)) return;
        enforceHasContractCode(_init, "LibDiamondCut: Init address has no code");
        (bool success, bytes memory error) = _init.delegatecall(_calldata);
        if (!success) {
            if (error.length > 0) {
                assembly {
                    let returndata_size := mload(error)
                    revert(add(32, error), returndata_size)
                }
            } else {
                revert InitializationFunctionReverted(_init, _calldata);
            }
        }
    }

    function enforceHasContractCode(address _contract, string memory _errorMessage) internal view {
        uint256 contractSize;
        assembly {
            contractSize := extcodesize(_contract)
        }
        require(contractSize > 0, _errorMessage);
    }
}
