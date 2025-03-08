// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import { LibAppV2 } from "../../libraries/LibAppV2.sol";

contract GettersFacetV2 {

    // Get Model Details
    function getModel(string memory _name) public view returns (
        bool isSet,
        address owner,
        uint256 nbActivity,
        uint256 nbInstance
    ) {
        LibAppV2.AppStorage storage _as = LibAppV2.appStorage();
        LibAppV2.Model storage model = _as.models[_name];
        return (model.isSet, model.owner, model.nbActivity, model.nbInstance);
    }

    // Get Activity Metadata
    function getActivityMetadata(string memory _modelName, uint256 _activityId) public view returns (string memory) {
        LibAppV2.AppStorage storage _as = LibAppV2.appStorage();
        return _as.models[_modelName].activityMetadata[_activityId];
    }

    // Get Activity Details
    function getActivity(string memory _modelName, uint256 _activityId) public view returns (
        uint id,
        LibAppV2.NodeType nodeType,
        string memory xmlID,
        string memory name,
        string memory lane,
        string memory dataIn,
        string memory dataOut,
        string memory timestamp
    ) {
        LibAppV2.AppStorage storage _as = LibAppV2.appStorage();
        LibAppV2.Activity storage activity = _as.models[_modelName].activities[_activityId];
        return (activity.id, activity.nodeType, activity.xmlID, activity.name, activity.lane, activity.dataIn, activity.dataOut, activity.timestamp);
    }


}
