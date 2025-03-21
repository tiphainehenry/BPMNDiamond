// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import { LibApp } from "../../libraries/LibApp.sol";

contract ModelFactoryFacet{
    event instanceId(string pName, uint _id);
    event newModelFactory(string pName);
    event modelUpdated(string pName);

    //################################### Model ###################################// 
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
        
        // Check if model already exists
        if(_as.models[_name].isSet){
            revert("Name is already taken");
        }

        // Create new model
        _as.models[_name].isSet = true;
        _as.models[_name].nbActivity = _activities.length;
        for(uint i = 0; i < _as.models[_name].nbActivity; i++) {
            _as.models[_name].activities[i] = _activities[i];
            _as.models[_name].childrenOptim[i] = _tabChildrenOptim[i];
            _as.models[_name].parentsOptim[i] = _tabParentsOptim[i];
            _as.models[_name].msgInOptim[i] = _msgInOptim[i];
            _as.models[_name].msgOutOptim[i] = _msgOutOptim[i];
        }

        // Adding replay segments
        for(uint i = 0; i < _keyReplay.length; i++) {
            _as.models[_name].replaySegments[_keyReplay[i]] = _valueReplay[i];
        }

        emit newModelFactory(_name);
    }

    //################################### Instance ###################################// 
    function newInstance(string memory _name) public returns(uint) {
        LibApp.AppStorage storage _as = LibApp.appStorage();

        if(!_as.models[_name].isSet) {
            revert("This Model does not exist");
        }

        // Initialize markings for a new instance
        for(uint i = 0; i < _as.models[_name].nbActivity; i++) {
            _as.models[_name].instances[_as.models[_name].nbInstance].markingsIncluded.push(0);
            _as.models[_name].instances[_as.models[_name].nbInstance].markingsPending.push(0);
            _as.models[_name].instances[_as.models[_name].nbInstance].markingsExecuted.push(0);
            if(_as.models[_name].activities[i].nodeType == LibApp.NodeType.START) {
                _as.models[_name].instances[_as.models[_name].nbInstance].markingsIncluded[i] = 1;
            }
        }

        emit instanceId(_name, _as.models[_name].nbInstance);
        _as.models[_name].nbInstance++;
        return _as.models[_name].nbInstance - 1;
    }

    //################################### Update Model ###################################//
function updateModel(
        string memory _name,
        string memory _operation,  // Add, Remove, Replace
        uint256 _index,           // Index of the activity to update (for Replace or Remove)
        LibApp.Activity[] memory _newActivities, // For Add/Replace
        string[][] memory _newChildrenOptim, // For Add/Replace
        string[][] memory _newParentsOptim, // For Add/Replace
        string[][] memory _newMsgInOptim, // For Add/Replace
        string[][] memory _newMsgOutOptim // For Add/Replace
    ) public {
        LibApp.AppStorage storage _as = LibApp.appStorage();

        // Verify if the model exists
        if (!_as.models[_name].isSet) {
            revert("This Model does not exist");
        }

        // Handle Add operation
        if (keccak256(bytes(_operation)) == keccak256(bytes("add"))) {
            uint256 oldNbActivity = _as.models[_name].nbActivity;
            _as.models[_name].nbActivity += _newActivities.length;

            for (uint i = 0; i < _newActivities.length; i++) {
                _as.models[_name].activities[oldNbActivity + i] = _newActivities[i];
                _as.models[_name].childrenOptim[oldNbActivity + i] = _newChildrenOptim[i];
                _as.models[_name].parentsOptim[oldNbActivity + i] = _newParentsOptim[i];
                _as.models[_name].msgInOptim[oldNbActivity + i] = _newMsgInOptim[i];
                _as.models[_name].msgOutOptim[oldNbActivity + i] = _newMsgOutOptim[i];
            }
            emit modelUpdated(_name);
        }

        // Handle Remove operation (deactivation)
        else if (keccak256(bytes(_operation)) == keccak256(bytes("remove"))) {
            // Ensure index is valid
            require(_index < _as.models[_name].nbActivity, "Invalid index");

            // Deactivate the activity by clearing its dependencies and data
            _as.models ;  // Remove all child dependencies
            _as.models ;   // Remove all parent dependencies
            _as.models ;     // Remove all incoming messages
            _as.models ;    // Remove all outgoing messages

            emit modelUpdated(_name);
        }

        // Handle Replace operation
        else if (keccak256(bytes(_operation)) == keccak256(bytes("replace"))) {
            // Ensure index is valid
            require(_index < _as.models[_name].nbActivity, "Invalid index");

            // Replace the activity and associated data
            _as.models[_name].activities[_index] = _newActivities[0]; // Only one replacement
            _as.models[_name].childrenOptim[_index] = _newChildrenOptim[0];
            _as.models[_name].parentsOptim[_index] = _newParentsOptim[0];
            _as.models[_name].msgInOptim[_index] = _newMsgInOptim[0];
            _as.models[_name].msgOutOptim[_index] = _newMsgOutOptim[0];

            emit modelUpdated(_name);
        } else {
            revert("Invalid operation type");
        }
    }
}
