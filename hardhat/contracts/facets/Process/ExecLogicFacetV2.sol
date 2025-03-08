// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import { LibAppV2 } from "../../libraries/LibAppV2.sol";

contract ExecLogicFacetV2 {

    event TaskExecuted(address indexed from, string id, string data, string timestamp);
    event TaskExecutionError(address indexed from, string id, string timestamp);

    // Execute task for a given model and instance
    function executeTask(string memory _modelName, uint256 _instanceId, uint256 _activityId, string memory _data) public {
        LibAppV2.AppStorage storage _as = LibAppV2.appStorage();
        LibAppV2.Model storage model = _as.models[_modelName];

        // Ensure the model exists
        if (!model.isSet) {
            revert("Model does not exist");
        }

        // Ensure the activity exists within the model
        LibAppV2.Activity storage activity = model.activities[_activityId];

        // Execute the task based on the activity type
        if (activity.nodeType == LibAppV2.NodeType.START) {
            _as.models[_modelName].instances[_instanceId].markingsExecuted.push(_activityId);
            emit TaskExecuted(msg.sender, activity.name, _data, "timestamp");
        } else {
            // If the task cannot be executed, revert with an error message
            emit TaskExecutionError(msg.sender, activity.name, "timestamp");
            revert("Activity cannot be executed");
        }
    }

    // Execute all tasks for a specific instance
    function executeAllTasks(string memory _modelName, uint256 _instanceId) public {
        LibAppV2.AppStorage storage _as = LibAppV2.appStorage();
        LibAppV2.Model storage model = _as.models[_modelName];

        // Ensure the model exists
        if (!model.isSet) {
            revert("Model does not exist");
        }

        uint256 nbActivities = model.nbActivity;
        bool taskExecuted = false;

        for (uint256 i = 0; i < nbActivities; i++) {
            LibAppV2.Activity storage activity = model.activities[i];

            // Execute the task only if the activity node type is START
            if (activity.nodeType == LibAppV2.NodeType.START) {
                _as.models[_modelName].instances[_instanceId].markingsExecuted.push(i);
                emit TaskExecuted(msg.sender, activity.name, "Task executed", "timestamp");
                taskExecuted = true;
            }
        }

        if (!taskExecuted) {
            revert("No valid tasks found to execute");
        }
    }

    // Update activity field (e.g., metadata)
    function updateActivityMetadata(string memory _modelName, uint256 _activityId, string memory _metadata) public {
        LibAppV2.AppStorage storage _as = LibAppV2.appStorage();
        LibAppV2.Model storage model = _as.models[_modelName];

        // Ensure the model exists
        if (!model.isSet) {
            revert("Model does not exist");
        }

        // Ensure the activity exists within the model
        if (_activityId >= model.nbActivity) {
            revert("Activity does not exist");
        }

        // Update the metadata for the given activity
        _as.models[_modelName].activityMetadata[_activityId] = _metadata;
    }

    // Add an instance marking for a given activity in a model
    function addInstanceMarking(string memory _modelName, uint256 _instanceId, uint256 _activityId) public {
        LibAppV2.AppStorage storage _as = LibAppV2.appStorage();
        LibAppV2.Model storage model = _as.models[_modelName];

        // Ensure the model exists
        if (!model.isSet) {
            revert("Model does not exist");
        }

        // Ensure the instance exists within the model
        if (_instanceId >= model.nbInstance) {
            revert("Instance does not exist");
        }

        // Ensure the activity exists
        if (_activityId >= model.nbActivity) {
            revert("Activity does not exist");
        }

        // Add the activity marking to the instance
        _as.models[_modelName].instances[_instanceId].markingsExecuted.push(_activityId);
        emit TaskExecuted(msg.sender, model.activities[_activityId].name, "Marking added to instance", "timestamp");
    }
}
