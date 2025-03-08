// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { LibApp } from "../../libraries/LibApp.sol";

contract ExecLogicFacet{
        event taskExecutedDiamond(
        address indexed _from,
        string _id,
        string _data,
        string _timestamp, 
        string _model,
        uint _instance
    );
    event taskExecutionError(
        address indexed _from,
        string _id,
        string _timestamp
    );
    /////////////////////////////////////////////////////////////////////////// 
    /////////////////////////// workflow execution  /////////////////////////// 
    /////////////////////////////////////////////////////////////////////////// 
    //______________________________ Main ___________________________________// 
    function Invoke(
        uint _actId,
        string memory _model,
        uint _instanceId,
        string memory _lane,
        string memory _upd,
        string memory _timestamp
    ) public payable {
        LibApp.AppStorage storage _as = LibApp.appStorage();

        require(compareStrings(_lane, _as.models[_model].activities[_actId].lane)); // TODO: call check access: (msg sender ID + other policies)
        require(isValidNodeType(_as.models[_model].activities[_actId].nodeType));
        bool isIncluded = (_as.models[_model].instances[_instanceId].markingsIncluded[_actId] == 1);
        bool isPending = (_as.models[_model].instances[_instanceId].markingsPending[_actId] == 1);
        if ((isIncluded || isPending)) {
            if (_as.models[_model].activities[_actId].nodeType == LibApp.NodeType.XOR) {
                executeXORGate(_actId, _model, _instanceId);
            } else if (_as.models[_model].activities[_actId].nodeType == LibApp.NodeType.AND) {
                executeANDGate(_actId, _model, _instanceId);
            } else {
                executeTask(_actId, _model, _instanceId, _upd, _timestamp);
            }
            emit taskExecutedDiamond(
                msg.sender,
                _as.models[_model].activities[_actId].xmlID,
                _upd,
                _timestamp, 
                _model,
                _instanceId
            );
        }
    }
    //______________________________ Task ___________________________________// 
    //---------------------------- [Task] Main ------------------------------// 
    function executeTask(
        uint _actId,
        string memory _model,
        uint _instanceId,
        string memory _upd,
        string memory _timestamp
    ) private {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        stdTaskUpd(_actId, _model, _instanceId, _upd, _timestamp);
        if (exists1(_actId, _as.models[_model].instances[_instanceId].xorIds)) {
            disableConcurrentActivities(_model, _instanceId);
        }
    }
    //---------------------------- [Task] Assess ---------------------------// 
    function assessTaskExec(
        uint _actId,
        string memory _model,
        uint _instanceId
    ) internal view returns (bool) {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        bool isExec = false;
        for (uint j = 0; j < _as.models[_model].nbActivity; j++) {
            if (ismsgInOptimNotEmpty(_model, _actId)) {
                if (
                    compareStrings(
                        _as.models[_model].msgInOptim[_actId][0],
                        _as.models[_model].activities[j].xmlID
                    )
                ) {
                    if (_as.models[_model].instances[_instanceId].markingsExecuted[j] == 1) {
                        isExec = true;
                        break;
                    }
                }
            }
        }
        return isExec;
    }
    //----------------------------- [Task] Utils ---------------------------// 
    function ismsgOutOptimNotEmpty(string memory _model, uint key) public view returns (bool) {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        return _as.models[_model].msgOutOptim[key].length > 0;
    }
    function ismsgInOptimNotEmpty(string memory _model, uint key) public view returns (bool) {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        return _as.models[_model].msgInOptim[key].length > 0;
    }
    function ischildrenOptimNotEmpty(string memory _model, uint key) public view returns (bool) {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        return _as.models[_model].childrenOptim[key].length > 0;
    }
    function isParentOptimNotEmpty(string memory _model, uint key) public view returns (bool) {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        return _as.models[_model].parentsOptim[key].length > 0;
    }
    function getPosFromXML(string memory _model, string memory _xmlID) public view returns (uint) {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        for (uint j = 0; j < _as.models[_model].nbActivity; j++) {
            if (compareStrings(_xmlID, _as.models[_model].activities[j].xmlID)) {
                return j;
            }
        }
        return 404; // error
    }
    function isValidNodeType(LibApp.NodeType _NodeType) private pure returns (bool) {
        return
            _NodeType == LibApp.NodeType.START ||
            _NodeType == LibApp.NodeType.MSG_START ||
            _NodeType == LibApp.NodeType.EVENT ||
            _NodeType == LibApp.NodeType.TASK ||
            _NodeType == LibApp.NodeType.END ||
            _NodeType == LibApp.NodeType.XOR ||
            _NodeType == LibApp.NodeType.AND;
    }
    function checkIncomingMsgExecuted(
        uint _actId,
        string memory _model,
        uint _instanceId
    ) public view returns (bool) {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        for (uint j = 0; j < _as.models[_model].nbActivity; j++) {
            if (
                compareStrings(
                    _as.models[_model].msgInOptim[_actId][0],
                    _as.models[_model].activities[j].xmlID
                ) &&
                ((_as.models[_model].instances[_instanceId].markingsPending[j] > 0) ||
                    (_as.models[_model].instances[_instanceId].markingsExecuted[j] > 0))
            ) {
                return true;
            }
        }
        return false;
    }
    //----------------------------- [Task] Exec ------------------------------// 
    function execTask(
        uint _actId,
        string memory _model,
        uint _instanceId
        ) public {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        //UPDATE ACTIVITY MARKINGS STATUS
        _as.models[_model].instances[_instanceId].markingsPending[_actId] = 0; //waiting for output notarization trigger
        _as.models[_model].instances[_instanceId].markingsIncluded[_actId] = 0;
        _as.models[_model].instances[_instanceId].markingsExecuted[_actId] = 1;
        // UPDATE CHILDREN
        if (_as.models[_model].childrenOptim[_actId].length > 0) {
            updateChildren(_actId, _model, _instanceId); // ENABLE CHILDREN (not applicable for END activity)
        }
    }
    //---------------------------- [Task] Replay ----------------------------// 
    function setActivitiesSegment(
        string memory startXML,
        string memory triggerXML,
        string memory _model,
        uint _instanceId
    ) public {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        //1. set start segment to included
        uint posStart = getPosFromXML(_model, startXML);
        _as.models[_model].instances[_instanceId].markingsIncluded[posStart] = 1;
        _as.models[_model].instances[_instanceId].markingsExecuted[posStart] = 0;
        _as.models[_model].instances[_instanceId].markingsPending[posStart] = 0;
        //2. set segment set to init (not included / not pending / not executed)
        for (uint k = 0; k < _as.models[_model].replaySegments[triggerXML].length; k++) {
            uint pos = getPosFromXML(_model, _as.models[_model].replaySegments[triggerXML][k]);
            _as.models[_model].instances[_instanceId].markingsIncluded[pos] = 0;
            _as.models[_model].instances[_instanceId].markingsExecuted[pos] = 0;
            _as.models[_model].instances[_instanceId].markingsPending[pos] = 0;
        }
        //3. set end segment to init too
        uint posEnd = getPosFromXML(_model, triggerXML);
        _as.models[_model].instances[_instanceId].markingsIncluded[posEnd] = 0;
        _as.models[_model].instances[_instanceId].markingsExecuted[posEnd] = 0;
        _as.models[_model].instances[_instanceId].markingsPending[posEnd] = 0;
    }
    //____________________________ Gates _____________________________________// 
    function executeXORGate(
        uint _actId,
        string memory _model,
        uint _instanceId
        ) public {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        // if xor child: put token to child and disable other children from xor
        _as.models[_model].instances[_instanceId].markingsIncluded[_actId] = 0;
        _as.models[_model].instances[_instanceId].markingsExecuted[_actId] = 1;
        for (uint i = 0; i < _as.models[_model].childrenOptim[_actId].length; i++) {
            string memory c_name = _as.models[_model].childrenOptim[_actId][i];
            // fetch child id
            for (uint j = 0; j < _as.models[_model].nbActivity; j++) {
                if (compareStrings(c_name, _as.models[_model].activities[j].xmlID)) {
                    // update child id marking
                    _as.models[_model].instances[_instanceId].markingsIncluded[j] = 1;
                    _as.models[_model].instances[_instanceId].xorIds.push(j);
                    break;
                }
            }
        }
    }
    function executeANDGate(
        uint _actId,
        string memory _model,
        uint _instanceId
        ) public {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        // look which parents of the AND gateway are executed
        uint numParentsExec = 0;
        for (uint i = 0; i < _as.models[_model].parentsOptim[_actId].length; i++) {
            string memory p_name = _as.models[_model].parentsOptim[_actId][i];
            // fetch child id
            for (uint j = 0; j < _as.models[_model].nbActivity; j++) {
                if (compareStrings(p_name, _as.models[_model].activities[j].xmlID)) {
                    // update child id marking
                    if (_as.models[_model].instances[_instanceId].markingsExecuted[j] == 1) {
                        numParentsExec = numParentsExec + 1;
                    }
                    break;
                }
            }
        }
        if (numParentsExec == _as.models[_model].parentsOptim[_actId].length) {
            // require all parents are executed
            // update marking
            _as.models[_model].instances[_instanceId].markingsIncluded[_actId] = 0;
            _as.models[_model].instances[_instanceId].markingsExecuted[_actId] = 1;
            // set all children to one
            for (uint i = 0; i < _as.models[_model].childrenOptim[_actId].length; i++) {
                string memory c_name = _as.models[_model].childrenOptim[_actId][i];
                // fetch child id
                for (uint j = 0; j < _as.models[_model].nbActivity; j++) {
                    if (compareStrings(c_name, _as.models[_model].activities[j].xmlID)) {
                        // update child id marking
                        _as.models[_model].instances[_instanceId].markingsIncluded[j] = 1;
                        break;
                    }
                }
            }
        }
    }
    //______________________ workflow execution update ______________________// 
    //---------------------------- [upd] Utils ------------------------------// 
    function disableConcurrentActivities(
        string memory _model,
        uint _instanceId
    ) public {
                LibApp.AppStorage storage _as = LibApp.appStorage();
        for (uint j = 0; j < _as.models[_model].instances[_instanceId].xorIds.length; j++) {
            _as.models[_model].instances[_instanceId].markingsIncluded[_as.models[_model].instances[_instanceId].xorIds[j]] = 0;
        }
        delete _as.models[_model].instances[_instanceId].xorIds;
    }
    //------------------------ [upd] children substrategies -------------------// 
    function updateChildMarking(
        string memory _model,
        uint _instanceId,
        string memory childName
    ) public {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        for (uint j = 0; j < _as.models[_model].nbActivity; j++) {
            if (
                compareStrings(childName, _as.models[_model].activities[j].xmlID) &&
                (_as.models[_model].instances[_instanceId].markingsExecuted[j] < 1)
            ) {
                _as.models[_model].instances[_instanceId].markingsIncluded[j] = 1;
                break;
            }
        }
    }
    function updateInternalChildren(
        uint _actId,
        string memory _model,
        uint _instanceId
    ) public {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        for (uint i = 0; i < _as.models[_model].childrenOptim[_actId].length; i++) {
            updateChildMarking(_model, _instanceId, _as.models[_model].childrenOptim[_actId][i]);
        }
    }
    function updateExternalChildren(
        uint _actId,
        string memory _model,
        uint _instanceId
    ) public {
                LibApp.AppStorage storage _as = LibApp.appStorage();
        for (uint i = 0; i < _as.models[_model].msgOutOptim[_actId].length; i++) {
            updateChildMarking(_model, _instanceId, _as.models[_model].msgOutOptim[_actId][i]);
        }
    }
    function updateChildren(
        uint _actId,
        string memory _model,
        uint _instanceId
        ) public payable {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        bool hasMsgIn = ismsgInOptimNotEmpty(_model, _actId);
        bool isMsgStart = (_as.models[_model].activities[_actId].nodeType == LibApp.NodeType.MSG_START);
        if (!hasMsgIn) {
            updateInternalChildren(_actId, _model, _instanceId);
        } else if (hasMsgIn && isMsgStart) {
            handleIncomingMsgStart(_actId, _model, _instanceId);
        } else if (!isMsgStart) {
            updateInternalChildren(_actId, _model, _instanceId);
        }
        // update EXTERNAL (collabs) children markings
        updateExternalChildren(_actId, _model, _instanceId);
    }
    //---------------------- [upd] upd logic substrategies ------------------// 
    function handleIncomingMsgStart(
        uint _actId,
        string memory _model,
        uint _instanceId
    ) public {
        bool incomingMsgIsExecuted = checkIncomingMsgExecuted(_actId, _model, _instanceId);
        if (incomingMsgIsExecuted) {
            updateInternalChildren(_actId, _model, _instanceId);
        }
    }
    function handleChildMarkings(
        uint _actId,
        string memory _model,
        uint _instanceId,
        string memory msgOut
    ) public {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        for (uint i = 0; i < _as.models[_model].msgOutOptim[_actId].length; i++) {
            // fetch child id
            for (uint j = 0; j < _as.models[_model].nbActivity; j++) {
                if (
                    compareStrings(msgOut, _as.models[_model].activities[j].xmlID) &&
                    (_as.models[_model].instances[_instanceId].markingsExecuted[j] < 1)
                ) {
                    _as.models[_model].instances[_instanceId].markingsExecuted[j] = 1;
                    updateChildren(j, _model, _instanceId);
                    break;
                }
            }
        }
    }
    function pendingNotarizationStart(
        uint _actId,
        string memory _model,
        uint _instanceId,
        bool hasDataIn,
        string memory _upd
    ) public{
        LibApp.AppStorage storage _as = LibApp.appStorage();
        if (hasDataIn) {
            _as.models[_model].activities[_actId].dataIn = _upd; // notarize input A modifier pour donner une addresse de stockage
        }
        _as.models[_model].instances[_instanceId].markingsPending[_actId] = 1; //waiting for output notarization trigger
    }
    function pendingNotarizationEnd(
        uint _actId,
        string memory _model,
        uint _instanceId,
        string memory _upd,
        string memory _timestamp
    ) public {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        _as.models[_model].activities[_actId].dataOut = _upd; // update dataOut
        bool hasMsgOut = ismsgOutOptimNotEmpty(_model, _actId);
        bool msgInOk = assessTaskExec(_actId, _model, _instanceId);
        bool msgOutOk = assessTaskExec(_actId, _model, _instanceId);//PRobeleme y a 2 fois le mm retour
        if ((!hasMsgOut) || (msgInOk && msgOutOk)) {
            execTask(_actId, _model, _instanceId);
        } else if (!msgInOk) {
            // OUTGOING AND INCOMING EVENT
            _as.models[_model].instances[_instanceId].markingsPending[_actId] = 1; //waiting for output notarization trigger
            _as.models[_model].instances[_instanceId].markingsIncluded[_actId] = 0;
            // CALL NOTARIZE OUTPUT
            // update EXTERNAL (collabs) children markings
            handleChildMarkings(_actId, _model, _instanceId, _as.models[_model].msgOutOptim[_actId][0]);
        } else {
            emit taskExecutionError(
                msg.sender,
                _as.models[_model].activities[_actId].xmlID,
                _timestamp
            );
        }
    }
    //--------------------------------- [upd]  Main --------------------------------// 
    function stdTaskUpd(
        uint _actId,
        string memory _model,
        uint _instanceId,
        string memory _upd,
        string memory _timestamp
    ) internal {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        bool hasDataOut = !compareStrings(_as.models[_model].activities[_actId].dataOut, "");
        bool hasDataIn = !compareStrings(_as.models[_model].activities[_actId].dataIn, "");
        if (!hasDataOut) {
            // NO OUTPUT DATA TO NOTARIZE
            handleNoDataOut(_actId, _model, _instanceId, _upd, _timestamp, hasDataIn);
        } else {
            handleDataOut(_actId, _model, _instanceId, _upd, _timestamp, hasDataIn);
        }
    }
    function handleNoDataOut(
        uint _actId,
        string memory _model,
        uint _instanceId,
        string memory _upd,
        string memory _timestamp,
        bool hasDataIn
    ) public {
                LibApp.AppStorage storage _as = LibApp.appStorage();
        if (hasDataIn) {
            _as.models[_model].activities[_actId].dataIn = _upd; // Anchoring notarization task (if output required, set to pending while waiting for notarization output!)
        }
        bool hasMsgOut = ismsgOutOptimNotEmpty(_model, _actId);
        bool msgInOk = assessTaskExec(_actId, _model, _instanceId);
        bool msgOutOk = assessTaskExec(_actId, _model, _instanceId);
        bool isReplayTask = _as.models[_model].replaySegments[_as.models[_model].activities[_actId].xmlID].length != 0;
        if (hasMsgOut && isReplayTask) {
            setActivitiesSegment(
                _as.models[_model].msgOutOptim[_actId][0],
                _as.models[_model].activities[_actId].xmlID,
                _model,
                 _instanceId
            );
        } else if ((!hasMsgOut) || (msgInOk && msgOutOk)) {
            execTask(_actId, _model, _instanceId);
        } else if (!msgInOk) {
            // OUTGOING AND INCOMING EVENT
            _as.models[_model].instances[_instanceId].markingsExecuted[_actId] = 1;
            _as.models[_model].instances[_instanceId].markingsIncluded[_actId] = 0;
            // CALL NOTARIZE OUTPUT
            // update EXTERNAL (collabs) children markings
            string memory tpr = _as.models[_model].msgOutOptim[_actId][0];
            handleChildMarkings(_actId, _model, _instanceId, tpr);
        } else {
            emit taskExecutionError(
                msg.sender,
                _as.models[_model].activities[_actId].xmlID,
                _timestamp
            );
        }
    }
    function handleDataOut(
        uint _actId,
        string memory _model,
        uint _instanceId,
        string memory _upd,
        string memory _timestamp,
        bool hasDataIn
    ) public {
        //HAS Data OUTPUT
                LibApp.AppStorage storage _as = LibApp.appStorage();
        if (_as.models[_model].instances[_instanceId].markingsPending[_actId] == 0) {
            pendingNotarizationStart(_actId,_model, _instanceId, hasDataIn, _upd);
        } else {
            pendingNotarizationEnd(_actId,_model, _instanceId, _upd, _timestamp);
        }
    }
    /////////////////////////////////////////////////////////////////////////// 
    ////////////////////////////////// other ////////////////////////////////// 
    /////////////////////////////////////////////////////////////////////////// 
    function killProcess(
        string memory _model,
        uint _instanceId
    ) public payable returns (uint) {
        LibApp.AppStorage storage _as = LibApp.appStorage();
        delete _as.models[_model].instances[_instanceId].markingsIncluded;
        return 0;
    }
    /////////////////////////////////////////////////////////////////////////// 
    ///////////////////////////////// utils /////////////////////////////////// 
    /////////////////////////////////////////////////////////////////////////// 
    function compareStrings(
        string memory a,
        string memory b
    ) public pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) ==
            keccak256(abi.encodePacked((b))));
    }
    function exists1(
        uint num,
        uint[] memory numbers1
    ) public pure returns (bool) {
        for (uint i = 0; i < numbers1.length; i++) {
            if (numbers1[i] == num) {
                return true;
            }
        }
        return false;
    }

}