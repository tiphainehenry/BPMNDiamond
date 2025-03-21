pragma solidity >=0.4.22 <0.9.0;

import "contracts/caterPillar/AbstractFactory.sol";

contract ProcessRegistry {

    mapping (bytes32 => mapping (uint => bytes32)) private parent2ChildrenBundleId;
    mapping (bytes32 => address) private factories;

    mapping (address => bytes32) private instance2Bundle;
    address[] private instances;

    mapping (address => bytes32) private worklist2Bundle;
    address[] private worklists;

    event NewInstanceCreatedFor(address parent, address processAddress);

    function registerFactory(bytes32 bundleId, address factory) public {
        require(factories[bundleId] == address(0));
        factories[bundleId] = factory;
    }

    function registerWorklist(bytes32 bundleId, address worklist) public {
        worklist2Bundle[worklist] = bundleId;
        worklists.push(worklist);
    }

    function addChildBundleId(bytes32 parentBundleId, bytes32 processBundleId, uint nodeIndex) public {
        parent2ChildrenBundleId[parentBundleId][nodeIndex] = processBundleId;
    }

    function allInstances() public view returns(address[] memory) {
        return instances;
    }

    function newInstanceFor(uint nodeIndex, address parent) public returns(address) {
        bytes32 parentBundleId = instance2Bundle[parent];
        bytes32 bundleId = parent2ChildrenBundleId[parentBundleId][nodeIndex];
        return newBundleInstanceFor(bundleId, parent);
    }

    function newBundleInstanceFor(bytes32 bundleId, address parent) public returns(address) {
        require(factories[bundleId] != address(0));
        address processAddress = AbstractFactory(factories[bundleId]).newInstance(parent, address(this));
        instance2Bundle[processAddress] = bundleId;
        instances.push(processAddress);
        AbstractFactory(factories[bundleId]).startInstanceExecution(processAddress);
        emit NewInstanceCreatedFor(parent, processAddress);
        return processAddress;
    }

    function childrenFor(bytes32 parent, uint nodeInd) external view returns(bytes32) {
        return parent2ChildrenBundleId[parent][nodeInd];
    }

    function bundleFor(address processInstance) public view returns(bytes32) {
        return instance2Bundle[processInstance];
    }

    function worklistBundleFor(address worklist) public view returns(bytes32) {
        return worklist2Bundle[worklist];
    }

    function getInstance() public view returns(address[] memory){
        return instances;
    }
}
