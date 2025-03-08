// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { LibApp } from "../../libraries/LibApp.sol";

contract GettersFacet{
    function getIncluded(
        string memory _model,
        uint _instanceId
        ) public view returns (uint[] memory) {
                LibApp.AppStorage storage _as = LibApp.appStorage();


        return _as.models[_model].instances[_instanceId].markingsIncluded;
    }
    function getPending(
        string memory _model,
        uint _instanceId
        ) public view returns (uint[] memory) {
                LibApp.AppStorage storage _as = LibApp.appStorage();


        return _as.models[_model].instances[_instanceId].markingsPending;
    }
    function getExecuted(
        string memory _model,
        uint _instanceId
        ) public view returns (uint[] memory) {
                LibApp.AppStorage storage _as = LibApp.appStorage();


        return _as.models[_model].instances[_instanceId].markingsExecuted;
    }
    
    function getActivityDataFromActivityId(
        uint _id,
        string memory _model
    )
        public
        view
        returns (
            uint _actId,
            uint _type,
            string memory _xmlID,
            string memory _name,
            string memory _dataIn,
            string memory _dataOut,
            string memory _lane,
            string memory _timestamp
            )
    {
                LibApp.AppStorage storage _as = LibApp.appStorage();

        LibApp.Activity memory resultat;
        resultat.id =_as.models[_model].activities[_id].id;
        resultat.nodeType=_as.models[_model].activities[_id].nodeType;
        resultat.xmlID=_as.models[_model].activities[_id].xmlID;
        resultat.name=_as.models[_model].activities[_id].name;
        resultat.dataIn=_as.models[_model].activities[_id].dataIn;
        resultat.dataOut=_as.models[_model].activities[_id].dataOut;
        resultat.lane=_as.models[_model].activities[_id].lane;
        resultat.timestamp=_as.models[_model].activities[_id].timestamp;
        return (
            resultat.id,
            uint(resultat.nodeType),
            resultat.xmlID,
            resultat.name,
            resultat.dataIn,
            resultat.dataOut,
            resultat.lane,
            resultat.timestamp
        );
    }
    function getReplaySegment(string memory _keyReplaySegment,string memory _model) public view returns(string[]memory){
                LibApp.AppStorage storage _as = LibApp.appStorage();

        return _as.models[_model].replaySegments[_keyReplaySegment];
    }
    function getNbInstance(string memory _model) public view returns(uint){
                LibApp.AppStorage storage _as = LibApp.appStorage();

        return _as.models[_model].nbInstance;
    }
}