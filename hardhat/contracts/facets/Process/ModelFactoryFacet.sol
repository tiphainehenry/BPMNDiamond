// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import { LibApp } from "../../libraries/LibApp.sol";

contract ModelFactoryFacet{
    event instanceId(string pName, uint _id);
    event newModelFactory(string pName);

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
        ) public{
        
        LibApp.AppStorage storage _as = LibApp.appStorage();
        //verification de l'existence du model
        if(_as.models[_name].isSet){
            revert("Name is already taken");
        }
        //Creation du model
        _as.models[_name].isSet =true;
        _as.models[_name].nbActivity = _activities.length;
        for( uint i=0;i<_as.models[_name].nbActivity;i++){
            _as.models[_name].activities[i]=_activities[i];
            _as.models[_name].childrenOptim[i] = _tabChildrenOptim[i];
            _as.models[_name].parentsOptim[i] = _tabParentsOptim[i];
            _as.models[_name].msgInOptim[i] = _msgInOptim[i];
            _as.models[_name].msgOutOptim[i] = _msgOutOptim[i];
        }
        for(uint i =0; i<_keyReplay.length;i++){
            _as.models[_name].replaySegments[_keyReplay[i]] = _valueReplay[i];
        }

        emit newModelFactory(_name);

    }

    //################################### Instance ###################################// 
    function newInstance(string memory _name) public returns(uint){
                LibApp.AppStorage storage _as = LibApp.appStorage();

        if(!_as.models[_name].isSet){
            revert("This Model does not exist");
        }
        for(uint i =0;i<_as.models[_name].nbActivity;i++){
            _as.models[_name].instances[_as.models[_name].nbInstance].markingsIncluded.push(0);
            _as.models[_name].instances[_as.models[_name].nbInstance].markingsPending.push(0);
            _as.models[_name].instances[_as.models[_name].nbInstance].markingsExecuted.push(0);
            if(_as.models[_name].activities[i].nodeType==LibApp.NodeType.START){
                _as.models[_name].instances[_as.models[_name].nbInstance].markingsIncluded[i]=1;
            }
        }
        emit instanceId(_name, _as.models[_name].nbInstance);
        _as.models[_name].nbInstance++;
        return _as.models[_name].nbInstance-1;
    }
}