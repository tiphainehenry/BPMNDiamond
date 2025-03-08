// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import { LibApp } from "../../libraries/LibApp.sol";

contract ModelFactoryFacetV2{
    event newModelFactory(string pName);
function addModel(
    string memory _name,
    LibApp.Activity[] memory _activities,
    string[][] memory _tabChildrenOptim,
    string[][] memory _tabParentsOptim,
    string[][] memory _msgInOptim,
    string[][] memory _msgOutOptim,
    string[] memory _keyReplay,
    string[][] memory _valueReplay
) public {
    LibApp.AppStorage storage _as = LibApp.appStorage();

    // Ensure model name starts with a specific prefix (e.g., "Model_")
    bytes memory nameBytes = bytes(_name);
    bytes memory prefix = bytes("Model_");

    // Explicitly copy `nameBytes` into memory to enable slicing
    bool hasCorrectPrefix = true;
    for (uint256 i = 0; i < prefix.length; i++) {
        if (i >= nameBytes.length || nameBytes[i] != prefix[i]) {
            hasCorrectPrefix = false;
            break;
        }
    }
    require(hasCorrectPrefix, "Model name must start with 'Model_'");

    // Check if the model already exists
    if (_as.models[_name].isSet) {
        revert("Name is already taken");
    }

    // Create the model
    _as.models[_name].isSet = true;
    _as.models[_name].nbActivity = _activities.length;

    for (uint256 i = 0; i < _as.models[_name].nbActivity; i++) {
        _as.models[_name].activities[i] = _activities[i];
        _as.models[_name].childrenOptim[i] = _tabChildrenOptim[i];
        _as.models[_name].parentsOptim[i] = _tabParentsOptim[i];
        _as.models[_name].msgInOptim[i] = _msgInOptim[i];
        _as.models[_name].msgOutOptim[i] = _msgOutOptim[i];
    }

    for (uint256 i = 0; i < _keyReplay.length; i++) {
        _as.models[_name].replaySegments[_keyReplay[i]] = _valueReplay[i];
    }

    emit newModelFactory(_name);
}
}
