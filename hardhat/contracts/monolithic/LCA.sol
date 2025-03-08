// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;
contract LCA{
    struct WorkflowInstance {
        uint id;
        string name;
        uint[] activityIds;
    }
    struct Activity {
        uint id;
        NodeType nodeType;
        string xmlID;
        string name;
        string lane;
        string dataIn;
        string dataOut;
        string timestamp;
    }
    mapping(uint => WorkflowInstance) instances;
    mapping(address => string) public addresses2lanes; // list of authorized users
    mapping(uint => Activity) public activities; // sequential index
    mapping(uint => string[]) public ChildrenOptim;
    mapping(uint => string[]) public ParentsOptim;
    mapping(uint => string[]) public MsgInOptim;
    mapping(uint => string[]) public MsgOutOptim;
    mapping(string => string[]) ReplaySegments;
    uint numWorkflows = 0;
    uint numActivities = 0;
    enum NodeType {
        START,
        END,
        MSG_START,
        EVENT,
        TASK,
        XOR,
        AND, 
        OTHER
    }
    uint[] markings_included; // sequential index (included/pending/done)
    uint[] markings_pending;  // sequential index (included/pending/done)
    uint[] markings_executed; // sequential index (included/pending/done)
    uint[] XORIds;
    event taskExecuted(
        address indexed _from,
        string _id,
        string _data,
        string _timestamp
    );
    event taskExecutionError(
        address indexed _from,
        string _id,
        string _timestamp
    );
  constructor() {
    //__________________________________ create instance _____________________________________// 
    addWorkflowInstance("myContract",20);
    markings_included = [0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0]; // flow arcs assigned with a sequential index (included/pending/done)
    markings_executed = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    markings_pending = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    //________________________________________ Populate activities ___________________________//    
    ///////////////////////////////      
    //====> Populate activity 0     
    ///////////////////////////////      
    ChildrenOptim[0] = ["Event_0aonam9"];
    ParentsOptim[0] = ["Event_07pjzzj"];
    MsgInOptim[0]= ["Event_126f47n"];
    addActivity(
        0,  //activity id
        NodeType.TASK, // activity type 
        "Activity_1srhafj", // XML ID 
        "Formalize_diagram_based_on_KO_meeting", // activity name 
        "LCA expert", //lane
        "",
        "{diagram:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 1     
    ///////////////////////////////      
    ChildrenOptim[1] = ["Event_1xren83"];
    ParentsOptim[1] = ["Event_0tiesg4"];
    MsgOutOptim[1]= ["Activity_18zqq4j"];
    addActivity(
        1,  //activity id
        NodeType.TASK, // activity type 
        "Activity_1u8dcz3", // XML ID 
        "Setup_LCI", // activity name 
        "LCA expert", //lane
        "",
        "{dataForm:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 2     
    ///////////////////////////////      
    ChildrenOptim[2] = ["Activity_094illf"];
    ParentsOptim[2] = ["Gateway_0cxdlki"];
    addActivity(
        2,  //activity id
        NodeType.TASK, // activity type 
        "Activity_1gktsop", // XML ID 
        "Model_LCA_process", // activity name 
        "LCA expert", //lane
        "{dataFormFilledReceived:xxxx,diagramFinalized:xxxx}",
        "{model:xxxx,hypotheses:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 3     
    ///////////////////////////////      
    ChildrenOptim[3] = ["Activity_1g0jyhn"];
    ParentsOptim[3] = ["Activity_1gktsop"];
    addActivity(
        3,  //activity id
        NodeType.TASK, // activity type 
        "Activity_094illf", // XML ID 
        "Perform_simulations", // activity name 
        "LCA expert", //lane
        "{SoftwareName:xxxx,model:xxxx,hypotheses:xxxx,SoftwareVersion:xxxx}",
        "{rawResults:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 4     
    ///////////////////////////////      
    ChildrenOptim[4] = ["Activity_1689lou"];
    ParentsOptim[4] = ["Activity_094illf"];
    addActivity(
        4,  //activity id
        NodeType.TASK, // activity type 
        "Activity_1g0jyhn", // XML ID 
        "PostTreatment", // activity name 
        "LCA expert", //lane
        "{rawResults:xxxx}",
        "{finalResults:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 5     
    ///////////////////////////////      
    ChildrenOptim[5] = ["Event_05mhssw"];
    ParentsOptim[5] = ["Activity_1g0jyhn"];
    MsgOutOptim[5]= ["Event_1vci38q"];
    addActivity(
        5,  //activity id
        NodeType.TASK, // activity type 
        "Activity_1689lou", // XML ID 
        "WriteReport", // activity name 
        "LCA expert", //lane
        "{finalResults:xxxx}",
        "{report:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 6     
    ///////////////////////////////      
    ChildrenOptim[6] = ["Event_0afzwvl"];
    ParentsOptim[6] = ["Event_1l9b7n8"];
    MsgInOptim[6]= ["Activity_1u8dcz3", "Event_0gtubjz"];
    addActivity(
        6,  //activity id
        NodeType.TASK, // activity type 
        "Activity_18zqq4j", // XML ID 
        "Fill_LCI_info", // activity name 
        "Client", //lane
        "",
        "{dataFormFilled:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 7     
    ///////////////////////////////      
    ChildrenOptim[7] = ["Activity_1srhafj"];
    addActivity(
        7,  //activity id
        NodeType.START, // activity type 
        "Event_07pjzzj", // XML ID 
        "", // activity name 
        "LCA expert", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 8     
    ///////////////////////////////      
    ChildrenOptim[8] = ["Gateway_0jau4ji"];
    MsgInOptim[8]= ["Event_0aonam9"];
    addActivity(
        8,  //activity id
        NodeType.START, // activity type 
        "Event_1ailhr5", // XML ID 
        "receive_proposal", // activity name 
        "Client", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 9     
    ///////////////////////////////      
    ChildrenOptim[9] = ["Event_0tiesg4"];
    ParentsOptim[9] = ["Activity_1srhafj"];
    MsgOutOptim[9]= ["Event_1ailhr5"];
    addActivity(
        9,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0aonam9", // XML ID 
        "send_proposal", // activity name 
        "LCA expert", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 10     
    ///////////////////////////////      
    ParentsOptim[10] = ["Gateway_0cxdlki"];
    MsgOutOptim[10]= ["Activity_18zqq4j"];
    addActivity(
        10,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0gtubjz", // XML ID 
        "req_precisions", // activity name 
        "LCA expert", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 11     
    ///////////////////////////////      
    ParentsOptim[11] = ["Gateway_0jau4ji"];
    MsgOutOptim[11]= ["Activity_1srhafj"];
    addActivity(
        11,  //activity id
        NodeType.EVENT, // activity type 
        "Event_126f47n", // XML ID 
        "req_corrections", // activity name 
        "Client", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 12     
    ///////////////////////////////      
    ChildrenOptim[12] = ["Activity_18zqq4j"];
    ParentsOptim[12] = ["Gateway_0jau4ji"];
    MsgOutOptim[12]= ["Event_0tiesg4"];
    addActivity(
        12,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1l9b7n8", // XML ID 
        "approve_proposal", // activity name 
        "Client", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 13     
    ///////////////////////////////      
    ChildrenOptim[13] = ["Event_1vci38q"];
    ParentsOptim[13] = ["Activity_18zqq4j"];
    MsgOutOptim[13]= ["Event_1xren83"];
    addActivity(
        13,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0afzwvl", // XML ID 
        "send_form", // activity name 
        "Client", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 14     
    ///////////////////////////////      
    ChildrenOptim[14] = ["Activity_1u8dcz3"];
    ParentsOptim[14] = ["Event_0aonam9"];
    MsgInOptim[14]= ["Event_1l9b7n8"];
    addActivity(
        14,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0tiesg4", // XML ID 
        "proposal_approved", // activity name 
        "LCA expert", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 15     
    ///////////////////////////////      
    ChildrenOptim[15] = ["Gateway_0cxdlki"];
    ParentsOptim[15] = ["Activity_1u8dcz3"];
    MsgInOptim[15]= ["Event_0afzwvl"];
    addActivity(
        15,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1xren83", // XML ID 
        "process_form", // activity name 
        "LCA expert", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 16     
    ///////////////////////////////      
    ParentsOptim[16] = ["Event_0afzwvl"];
    MsgInOptim[16]= ["Activity_1689lou"];
    addActivity(
        16,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1vci38q", // XML ID 
        "done", // activity name 
        "Client", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 17     
    ///////////////////////////////      
    ParentsOptim[17] = ["Activity_1689lou"];
    addActivity(
        17,  //activity id
        NodeType.END, // activity type 
        "Event_05mhssw", // XML ID 
        "", // activity name 
        "LCA expert", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 18     
    ///////////////////////////////      
    ChildrenOptim[18] = ["Activity_1gktsop", "Event_0gtubjz"];
    ParentsOptim[18] = ["Event_1xren83"];
    addActivity(
        18,  //activity id
        NodeType.XOR, // activity type 
        "Gateway_0cxdlki", // XML ID 
        "", // activity name 
        "LCA expert", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 19     
    ///////////////////////////////      
    ChildrenOptim[19] = ["Event_126f47n", "Event_1l9b7n8"];
    ParentsOptim[19] = ["Event_1ailhr5"];
    addActivity(
        19,  //activity id
        NodeType.XOR, // activity type 
        "Gateway_0jau4ji", // XML ID 
        "examine_proposal", // activity name 
        "Client", //lane
        "",
        "",
        "12/31/2022");      
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
    /////////////////////////////////////////////////////////////////////////// 
    //////////////////////////////// getters ////////////////////////////////// 
    /////////////////////////////////////////////////////////////////////////// 
    function getIncluded() public view returns (uint[] memory) {
        return markings_included;
    }
    function getPending() public view returns (uint[] memory) {
        return markings_pending;
    }
    function getExecuted() public view returns (uint[] memory) {
        return markings_executed;
    }
    function getActivityIdsFromWorkflow(
        uint _id
    ) public view returns (uint[] memory) {
        return instances[_id].activityIds;
    }
    function getActivityDataFromActivityId(
        uint _id
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
            string memory _lane
            //, string memory _timestamp
            )
    {
        return (
            activities[_id].id,
            uint(activities[_id].nodeType),
            activities[_id].xmlID,
            activities[_id].name,
            activities[_id].dataIn,
            activities[_id].dataOut,
            activities[_id].lane
            //        activities[_id].timestamp
        );
    }
    /////////////////////////////////////////////////////////////////////////// 
    /////////////////////////// workflow creation ///////////////////////////// 
    /////////////////////////////////////////////////////////////////////////// 
    function addWorkflowInstance(
        string memory _name,
        uint256 _activityIdsLength
    ) public {
        uint256[] memory _activityIds = new uint256[](_activityIdsLength);
        for (uint256 i = 0; i < _activityIdsLength; i++) {
            _activityIds[i] = i;
        }
        instances[numWorkflows] = WorkflowInstance(
            numWorkflows,
            _name,
            _activityIds
        );
        numWorkflows = numWorkflows + 1;
    }
    function addActivity(
        uint _id,
        NodeType _type,
        string memory _xmlID,
        string memory _name,
        string memory _lane,
        string memory _data_in,
        string memory _data_out,
        string memory _timestamp
    ) public {
        activities[_id] = Activity(
            _id,
            _type,
            _xmlID,
            _name,
            _lane,
            _data_in,
            _data_out,
            _timestamp
        );
    }
    /////////////////////////////////////////////////////////////////////////// 
    /////////////////////////// workflow execution  /////////////////////////// 
    /////////////////////////////////////////////////////////////////////////// 
    //______________________________ Main ___________________________________// 
    function Invoke(
        uint _actId,
        string memory _lane,
        string memory _upd,
        string memory _timestamp
    ) public payable {
        require(compareStrings(_lane, activities[_actId].lane)); // TODO: call check access: (msg sender ID + other policies)
        require(isValidNodeType(activities[_actId].nodeType));
        bool isIncluded = (markings_included[_actId] == 1);
        bool isPending = (markings_pending[_actId] == 1);
        if ((isIncluded || isPending)) {
            if (activities[_actId].nodeType == NodeType.XOR) {
                executeXORGate(_actId);
            } else if (activities[_actId].nodeType == NodeType.AND) {
                executeANDGate(_actId);
            } else {
                executeTask(_actId, _upd, _timestamp);
            }
            emit taskExecuted(
                msg.sender,
                activities[_actId].xmlID,
                _upd,
                _timestamp
            );
        }
    }
    //______________________________ Task ___________________________________// 
    //---------------------------- [Task] Main ------------------------------// 
    function executeTask(
        uint _actId,
        string memory _upd,
        string memory _timestamp
    ) private {
        stdTaskUpd(_actId, _upd, _timestamp);
        if (exists1(_actId, XORIds)) {
            disableConcurrentActivities();
        }
    }
    //---------------------------- [Task] Assess ---------------------------// 
    function assessTaskExec(
        uint _actId,
        uint[] memory act_ids
    ) internal view returns (bool) {
        bool isExec = false;
        for (uint j = 0; j < act_ids.length; j++) {
            if (isMsgInOptimNotEmpty(_actId)) {
                if (
                    compareStrings(
                        MsgInOptim[_actId][0],
                        activities[act_ids[j]].xmlID
                    )
                ) {
                    if (markings_executed[act_ids[j]] == 1) {
                        isExec = true;
                        break;
                    }
                }
            }
        }
        return isExec;
    }
    //----------------------------- [Task] Utils ---------------------------// 
    function isMsgOutOptimNotEmpty(uint key) public view returns (bool) {
        return MsgOutOptim[key].length > 0;
    }
    function isMsgInOptimNotEmpty(uint key) public view returns (bool) {
        return MsgInOptim[key].length > 0;
    }
    function isChildrenOptimNotEmpty(uint key) public view returns (bool) {
        return ChildrenOptim[key].length > 0;
    }
    function isParentOptimNotEmpty(uint key) public view returns (bool) {
        return ParentsOptim[key].length > 0;
    }
    function getPosFromXML(string memory _xmlID) public view returns (uint) {
        uint[] memory act_ids = getActivityIdsFromWorkflow(0);
        for (uint j = 0; j < act_ids.length; j++) {
            if (compareStrings(_xmlID, activities[act_ids[j]].xmlID)) {
                return j;
            }
        }
        return 404; // error
    }
    function isValidNodeType(NodeType _nodeType) private pure returns (bool) {
        return
            _nodeType == NodeType.START ||
            _nodeType == NodeType.MSG_START ||
            _nodeType == NodeType.EVENT ||
            _nodeType == NodeType.TASK ||
            _nodeType == NodeType.END ||
            _nodeType == NodeType.XOR ||
            _nodeType == NodeType.AND;
    }
    function checkIncomingMsgExecuted(
        uint _actId,
        uint[] memory act_ids
    ) private view returns (bool) {
        for (uint j = 0; j < act_ids.length; j++) {
            if (
                compareStrings(
                    MsgInOptim[_actId][0],
                    activities[act_ids[j]].xmlID
                ) &&
                ((markings_pending[act_ids[j]] > 0) ||
                    (markings_executed[act_ids[j]] > 0))
            ) {
                return true;
            }
        }
        return false;
    }
    //----------------------------- [Task] Exec ------------------------------// 
    function execTask(uint _actId) internal {
        //UPDATE ACTIVITY MARKINGS STATUS
        markings_pending[_actId] = 0; //waiting for output notarization trigger
        markings_included[_actId] = 0;
        markings_executed[_actId] = 1;
        // UPDATE CHILDREN
        if (ChildrenOptim[_actId].length > 0) {
            updateChildren(_actId); // ENABLE CHILDREN (not applicable for END activity)
        }
    }
    //---------------------------- [Task] Replay ----------------------------// 
    function setActivitiesSegment(
        string memory startXML,
        string memory triggerXML
    ) public {
        //1. set start segment to included
        uint posStart = getPosFromXML(startXML);
        markings_included[posStart] = 1;
        markings_executed[posStart] = 0;
        markings_pending[posStart] = 0;
        //2. set segment set to init (not included / not pending / not executed)
        for (uint k = 0; k < ReplaySegments[triggerXML].length; k++) {
            uint pos = getPosFromXML(ReplaySegments[triggerXML][k]);
            markings_included[pos] = 0;
            markings_executed[pos] = 0;
            markings_pending[pos] = 0;
        }
        //3. set end segment to init too
        uint posEnd = getPosFromXML(triggerXML);
        markings_included[posEnd] = 0;
        markings_executed[posEnd] = 0;
        markings_pending[posEnd] = 0;
    }
    //____________________________ Gates _____________________________________// 
    function executeXORGate(uint _actId) internal {
        // if xor child: put token to child and disable other children from xor
        markings_included[_actId] = 0;
        markings_executed[_actId] = 1;
        uint[] memory act_ids = getActivityIdsFromWorkflow(0);
        for (uint i = 0; i < ChildrenOptim[_actId].length; i++) {
            string memory c_name = ChildrenOptim[_actId][i];
            // fetch child id
            for (uint j = 0; j < act_ids.length; j++) {
                if (compareStrings(c_name, activities[act_ids[j]].xmlID)) {
                    // update child id marking
                    markings_included[act_ids[j]] = 1;
                    XORIds.push(act_ids[j]);
                    break;
                }
            }
        }
    }
    function executeANDGate(uint _actId) internal {
        // look which parents of the AND gateway are executed
        uint numParentsExec = 0;
        uint[] memory act_ids = getActivityIdsFromWorkflow(0);
        for (uint i = 0; i < ParentsOptim[_actId].length; i++) {
            string memory p_name = ParentsOptim[_actId][i];
            // fetch child id
            for (uint j = 0; j < act_ids.length; j++) {
                if (compareStrings(p_name, activities[act_ids[j]].xmlID)) {
                    // update child id marking
                    if (markings_executed[act_ids[j]] == 1) {
                        numParentsExec = numParentsExec + 1;
                    }
                    break;
                }
            }
        }
        if (numParentsExec == ParentsOptim[_actId].length) {
            // require all parents are executed
            // update marking
            markings_included[_actId] = 0;
            markings_executed[_actId] = 1;
            // set all children to one
            for (uint i = 0; i < ChildrenOptim[_actId].length; i++) {
                string memory c_name = ChildrenOptim[_actId][i];
                // fetch child id
                for (uint j = 0; j < act_ids.length; j++) {
                    if (compareStrings(c_name, activities[act_ids[j]].xmlID)) {
                        // update child id marking
                        markings_included[act_ids[j]] = 1;
                        break;
                    }
                }
            }
        }
    }
    //______________________ workflow execution update ______________________// 
    //---------------------------- [upd] Utils ------------------------------// 
    function disableConcurrentActivities() private {
        for (uint j = 0; j < XORIds.length; j++) {
            markings_included[XORIds[j]] = 0;
        }
        delete XORIds;
    }
    //------------------------ [upd] children substrategies -------------------// 
    function updateChildMarking(
        uint[] memory act_ids,
        string memory childName
    ) private {
        for (uint j = 0; j < act_ids.length; j++) {
            if (
                compareStrings(childName, activities[act_ids[j]].xmlID) &&
                (markings_executed[act_ids[j]] < 1)
            ) {
                markings_included[act_ids[j]] = 1;
                break;
            }
        }
    }
    function updateInternalChildren(
        uint _actId,
        uint[] memory act_ids
    ) private {
        for (uint i = 0; i < ChildrenOptim[_actId].length; i++) {
            updateChildMarking(act_ids, ChildrenOptim[_actId][i]);
        }
    }
    function updateExternalChildren(
        uint _actId,
        uint[] memory act_ids
    ) private {
        for (uint i = 0; i < MsgOutOptim[_actId].length; i++) {
            updateChildMarking(act_ids, MsgOutOptim[_actId][i]);
        }
    }
    function updateChildren(uint _actId) public payable {
        uint[] memory act_ids = getActivityIdsFromWorkflow(0);
        bool hasMsgIn = isMsgInOptimNotEmpty(_actId);
        bool isMsgStart = (activities[_actId].nodeType == NodeType.MSG_START);
        if (!hasMsgIn) {
            updateInternalChildren(_actId, act_ids);
        } else if (hasMsgIn && isMsgStart) {
            handleIncomingMsgStart(_actId, act_ids);
        } else if (!isMsgStart) {
            updateInternalChildren(_actId, act_ids);
        }
        // update EXTERNAL (collabs) children markings
        updateExternalChildren(_actId, act_ids);
    }
    //---------------------- [upd] upd logic substrategies ------------------// 
    function handleIncomingMsgStart(
        uint _actId,
        uint[] memory act_ids
    ) private {
        bool incomingMsgIsExecuted = checkIncomingMsgExecuted(_actId, act_ids);
        if (incomingMsgIsExecuted) {
            updateInternalChildren(_actId, act_ids);
        }
    }
    function handleChildMarkings(
        uint _actId,
        uint[] memory act_ids,
        string memory msgOut
    ) private {
        for (uint i = 0; i < MsgOutOptim[_actId].length; i++) {
            // fetch child id
            for (uint j = 0; j < act_ids.length; j++) {
                if (
                    compareStrings(msgOut, activities[act_ids[j]].xmlID) &&
                    (markings_executed[act_ids[j]] < 1)
                ) {
                    markings_executed[act_ids[j]] = 1;
                    updateChildren(act_ids[j]);
                    break;
                }
            }
        }
    }
    function pendingNotarizationStart(
        uint _actId,
        bool hasDataIn,
        string memory _upd
    ) private {
        if (hasDataIn) {
            activities[_actId].dataIn = _upd; // notarize input
        }
        markings_pending[_actId] = 1; //waiting for output notarization trigger
    }
    function pendingNotarizationEnd(
        uint _actId,
        string memory _upd,
        string memory _timestamp
    ) private {
        activities[_actId].dataOut = _upd; // update dataOut
        uint[] memory act_ids = getActivityIdsFromWorkflow(0);
        bool hasMsgOut = isMsgOutOptimNotEmpty(_actId);
        bool msgInOk = assessTaskExec(_actId, act_ids);
        bool msgOutOk = assessTaskExec(_actId, act_ids);
        if ((!hasMsgOut) || (msgInOk && msgOutOk)) {
            execTask(_actId);
        } else if (!msgInOk) {
            // OUTGOING AND INCOMING EVENT
            markings_pending[_actId] = 1; //waiting for output notarization trigger
            markings_included[_actId] = 0;
            // CALL NOTARIZE OUTPUT
            // update EXTERNAL (collabs) children markings
            handleChildMarkings(_actId, act_ids, MsgOutOptim[_actId][0]);
        } else {
            emit taskExecutionError(
                msg.sender,
                activities[_actId].xmlID,
                _timestamp
            );
        }
    }
    //--------------------------------- [upd]  Main --------------------------------// 
    function stdTaskUpd(
        uint _actId,
        string memory _upd,
        string memory _timestamp
    ) internal {
        bool hasDataOut = !compareStrings(activities[_actId].dataOut, "");
        bool hasDataIn = !compareStrings(activities[_actId].dataIn, "");
        if (!hasDataOut) {
            // NO OUTPUT DATA TO NOTARIZE
            handleNoDataOut(_actId, _upd, _timestamp, hasDataIn);
        } else {
            handleDataOut(_actId, _upd, _timestamp, hasDataIn);
        }
    }
    function handleNoDataOut(
        uint _actId,
        string memory _upd,
        string memory _timestamp,
        bool hasDataIn
    ) private {
        if (hasDataIn) {
            activities[_actId].dataIn = _upd; // Anchoring notarization task (if output required, set to pending while waiting for notarization output!)
        }
        uint[] memory act_ids = getActivityIdsFromWorkflow(0);
        bool hasMsgOut = isMsgOutOptimNotEmpty(_actId);
        bool msgInOk = assessTaskExec(_actId, act_ids);
        bool msgOutOk = assessTaskExec(_actId, act_ids);
        bool isReplayTask = ReplaySegments[activities[_actId].xmlID].length != 0;
        if (hasMsgOut && isReplayTask) {
            setActivitiesSegment(
                MsgOutOptim[_actId][0],
                activities[_actId].xmlID
            );
        } else if ((!hasMsgOut) || (msgInOk && msgOutOk)) {
            execTask(_actId);
        } else if (!msgInOk) {
            // OUTGOING AND INCOMING EVENT
            markings_executed[_actId] = 1;
            markings_included[_actId] = 0;
            // CALL NOTARIZE OUTPUT
            // update EXTERNAL (collabs) children markings
            handleChildMarkings(_actId, act_ids, MsgOutOptim[_actId][0]);
        } else {
            emit taskExecutionError(
                msg.sender,
                activities[_actId].xmlID,
                _timestamp
            );
        }
    }
    function handleDataOut(
        uint _actId,
        string memory _upd,
        string memory _timestamp,
        bool hasDataIn
    ) private {
        //HAS Data OUTPUT
        if (markings_pending[_actId] == 0) {
            pendingNotarizationStart(_actId, hasDataIn, _upd);
        } else {
            pendingNotarizationEnd(_actId, _upd, _timestamp);
        }
    }
    /////////////////////////////////////////////////////////////////////////// 
    ////////////////////////////////// other ////////////////////////////////// 
    /////////////////////////////////////////////////////////////////////////// 
    function killProcess() public payable returns (uint) {
        delete markings_included;
        return 0;
    }
}
