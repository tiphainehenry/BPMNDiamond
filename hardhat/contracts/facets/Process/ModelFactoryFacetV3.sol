// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import { LibAppV2 } from "../../libraries/LibAppV2.sol";

contract ModelFactoryFacetV3 {

    event newModelFactory(string pName);

    // Add a new model
    function addModel(
        string memory _name,
        LibAppV2.Activity[] memory _activities,
        string[][] memory _tabChildrenOptim,
        string[][] memory _tabParentsOptim,
        string[][] memory _msgInOptim,
        string[][] memory _msgOutOptim,
        string[] memory _keyReplay,
        string[][] memory _valueReplay
    ) public {

        LibAppV2.AppStorage storage _as = LibAppV2.appStorage();
        // Verification if the model already exists
        if (_as.models[_name].isSet) {
            revert("Model name already taken");
        }

        // Create the new model
        _as.models[_name].isSet = true;
        _as.models[_name].nbActivity = _activities.length;

        // Assign the activities and related data
        for (uint256 i = 0; i < _activities.length; i++) {
            _as.models[_name].activities[i] = _activities[i];
            _as.models[_name].childrenOptim[i] = _tabChildrenOptim[i];
            _as.models[_name].parentsOptim[i] = _tabParentsOptim[i];
            _as.models[_name].msgInOptim[i] = _msgInOptim[i];
            _as.models[_name].msgOutOptim[i] = _msgOutOptim[i];
        }

        // Assign replay segments
        for (uint256 i = 0; i < _keyReplay.length; i++) {
            _as.models[_name].replaySegments[_keyReplay[i]] = _valueReplay[i];
        }

        // Add activity metadata
        for (uint256 i = 0; i < _activities.length; i++) {
            string memory metadata = string(abi.encodePacked("Activity: ", _activities[i].name));
            _as.models[_name].activityMetadata[i] = metadata;
        }

        emit newModelFactory(_name);
    }

    // Create a new instance of the model
    function newInstance(string memory _name) public returns (uint256) {
        LibAppV2.AppStorage storage _as = LibAppV2.appStorage();

        if (!_as.models[_name].isSet) {
            revert("Model does not exist");
        }

        uint256 instanceId = _as.models[_name].nbInstance;

        for (uint256 i = 0; i < _as.models[_name].nbActivity; i++) {
            _as.models[_name].instances[instanceId].markingsIncluded.push(0);
            _as.models[_name].instances[instanceId].markingsPending.push(0);
            _as.models[_name].instances[instanceId].markingsExecuted.push(0);
            if (_as.models[_name].activities[i].nodeType == LibAppV2.NodeType.START) {
                _as.models[_name].instances[instanceId].markingsIncluded[i] = 1;
            }
        }

        _as.models[_name].nbInstance++;
        return instanceId;
    }
}
