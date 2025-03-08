// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;
contract Certification{
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
        addWorkflowInstance("myContract",30);
        markings_included = [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]; // flow arcs assigned with a sequential index (included/pending/done)
        markings_executed = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
        markings_pending = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
        //__________________________________ replay handle  _____________________________________// 
        ReplaySegments["Event_1stmo6n"] = ["Gateway_05dmrm9","Activity_15n2fuv","Event_1jryq1w","Event_1kvcbpv","Gateway_08bwshd","Activity_0fhjnyv","Activity_03et48t","Gateway_1xsibkd","Event_0oqnp2p","Event_0uel3fu","Activity_0qmqgly","Activity_03e8d70","Activity_0p7tzld","Gateway_0nb1emw","Event_1stmo6n","Event_0k95nad","Event_02ej7g0","Activity_0pylq6o","Gateway_0f0o07g","Event_17cg1yq","Activity_1l5e770","Event_0wwd4it","Event_07w16d4","Event_0aeztkj","Event_1xb2qil","Activity_0jptkb4","Gateway_05dmrm9","Gateway_05dmrm9"];
        ReplaySegments["Event_17cg1yq"] = ["Gateway_05dmrm9","Activity_15n2fuv","Event_1jryq1w","Event_1kvcbpv","Gateway_08bwshd","Activity_0fhjnyv","Activity_03et48t","Gateway_1xsibkd","Event_0oqnp2p","Event_0uel3fu","Activity_0qmqgly","Activity_03e8d70","Activity_0p7tzld","Gateway_0nb1emw","Event_1stmo6n","Event_0k95nad","Event_02ej7g0","Activity_0pylq6o","Gateway_0f0o07g","Event_17cg1yq","Activity_1l5e770","Event_0wwd4it","Event_07w16d4","Event_0aeztkj","Event_1xb2qil","Activity_0jptkb4","Gateway_05dmrm9","Gateway_05dmrm9"];
        ReplaySegments["Event_07w16d4"] = ["Gateway_05dmrm9","Activity_15n2fuv","Event_1jryq1w","Event_1kvcbpv","Gateway_08bwshd","Activity_0fhjnyv","Activity_03et48t","Gateway_1xsibkd","Event_0oqnp2p","Event_0uel3fu","Activity_0qmqgly","Activity_03e8d70","Activity_0p7tzld","Gateway_0nb1emw","Event_1stmo6n","Event_0k95nad","Event_02ej7g0","Activity_0pylq6o","Gateway_0f0o07g","Event_17cg1yq","Activity_1l5e770","Event_0wwd4it","Event_07w16d4","Event_0aeztkj","Event_1xb2qil","Activity_0jptkb4","Gateway_05dmrm9","Gateway_05dmrm9"];
        //________________________________________ Populate activities ___________________________//    
        ///////////////////////////////      
        //====> Populate activity 0     
        ///////////////////////////////      
        ChildrenOptim[0] = ["Event_0f6zvuq"];
        ParentsOptim[0] = ["StartEvent_1y45yut"];
        addActivity(
            0,  //activity id
            NodeType.TASK, // activity type 
            "Task_1hcentk", // XML ID 
            "LancementProjet", // activity name 
            "ChefAffaire", //lane
            "{CahierDesCharges:xxxx,MetadonneesProjet:xxxx}",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 1     
        ///////////////////////////////      
        ChildrenOptim[1] = ["Event_1jryq1w"];
        ParentsOptim[1] = ["Gateway_05dmrm9"];
        addActivity(
            1,  //activity id
            NodeType.TASK, // activity type 
            "Activity_15n2fuv", // XML ID 
            "RealisationProjet", // activity name 
            "BureauEtude", //lane
            "{ResultatsTest:xxxx,DonneesEntree:xxxx,RapportEtude:xxxx}",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 2     
        ///////////////////////////////      
        ChildrenOptim[2] = ["Activity_03e8d70"];
        ParentsOptim[2] = ["Event_0uel3fu"];
        addActivity(
            2,  //activity id
            NodeType.TASK, // activity type 
            "Activity_0qmqgly", // XML ID 
            "VerificationsN2", // activity name 
            "VerificateurN2", //lane
            "{ElementsVerificationN2:xxxx}",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 3     
        ///////////////////////////////      
        ChildrenOptim[3] = ["Activity_0p7tzld"];
        ParentsOptim[3] = ["Activity_0qmqgly"];
        addActivity(
            3,  //activity id
            NodeType.TASK, // activity type 
            "Activity_03e8d70", // XML ID 
            "CommentairesN2", // activity name 
            "VerificateurN2", //lane
            "{NotesN2:xxxx}",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 4     
        ///////////////////////////////      
        ChildrenOptim[4] = ["Gateway_0nb1emw"];
        ParentsOptim[4] = ["Activity_03e8d70"];
        addActivity(
            4,  //activity id
            NodeType.TASK, // activity type 
            "Activity_0p7tzld", // XML ID 
            "VisaN2", // activity name 
            "VerificateurN2", //lane
            "{VisaDecisionN2:xxxx,RapportN2:xxxx}",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 5     
        ///////////////////////////////      
        ChildrenOptim[5] = ["Event_0wwd4it"];
        ParentsOptim[5] = ["Gateway_0f0o07g"];
        addActivity(
            5,  //activity id
            NodeType.TASK, // activity type 
            "Activity_1l5e770", // XML ID 
            "Diffusion", // activity name 
            "Approbateur", //lane
            "{Purpose:xxxx}",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 6     
        ///////////////////////////////      
        ChildrenOptim[6] = ["Gateway_0f0o07g"];
        ParentsOptim[6] = ["Event_02ej7g0"];
        addActivity(
            6,  //activity id
            NodeType.TASK, // activity type 
            "Activity_0pylq6o", // XML ID 
            "VisaApprobation", // activity name 
            "Approbateur", //lane
            "{RapportApprouve:xxxx,VisaApprobation:xxxx}",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 7     
        ///////////////////////////////      
        ChildrenOptim[7] = ["Gateway_1xsibkd"];
        ParentsOptim[7] = ["Activity_0fhjnyv"];
        addActivity(
            7,  //activity id
            NodeType.TASK, // activity type 
            "Activity_03et48t", // XML ID 
            "VisaN1", // activity name 
            "VerificateurN1", //lane
            "{RapportN1:xxxx,VisaDecisionN1:xxxx}",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 8     
        ///////////////////////////////      
        ChildrenOptim[8] = ["Activity_03et48t"];
        ParentsOptim[8] = ["Gateway_08bwshd"];
        addActivity(
            8,  //activity id
            NodeType.TASK, // activity type 
            "Activity_0fhjnyv", // XML ID 
            "CommentairesN1", // activity name 
            "VerificateurN1", //lane
            "{NotesN1:xxxx}",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 9     
        ///////////////////////////////      
        ChildrenOptim[9] = ["Gateway_08bwshd"];
        ParentsOptim[9] = ["Event_1xb2qil"];
        addActivity(
            9,  //activity id
            NodeType.TASK, // activity type 
            "Activity_0jptkb4", // XML ID 
            "VerificationsN1", // activity name 
            "VerificateurN1", //lane
            "{ElementsVerificationN1:xxxx}",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 10     
        ///////////////////////////////      
        ChildrenOptim[10] = ["Task_1hcentk"];
        addActivity(
            10,  //activity id
            NodeType.START, // activity type 
            "StartEvent_1y45yut", // XML ID 
            "startProject", // activity name 
            "ChefAffaire", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 11     
        ///////////////////////////////      
        ChildrenOptim[11] = ["Gateway_05dmrm9"];
        MsgInOptim[11]= ["Event_0f6zvuq", "Event_1stmo6n", "Event_17cg1yq", "Event_07w16d4"];
        addActivity(
            11,  //activity id
            NodeType.MSG_START, // activity type 
            "Event_0rc5ucp", // XML ID 
            "startBureau", // activity name 
            "BureauEtude", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 12     
        ///////////////////////////////      
        ChildrenOptim[12] = ["Activity_0qmqgly"];
        MsgInOptim[12]= ["Event_0oqnp2p"];
        addActivity(
            12,  //activity id
            NodeType.MSG_START, // activity type 
            "Event_0uel3fu", // XML ID 
            "startN2", // activity name 
            "VerificateurN2", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 13     
        ///////////////////////////////      
        ChildrenOptim[13] = ["Activity_0pylq6o"];
        MsgInOptim[13]= ["Event_0k95nad"];
        addActivity(
            13,  //activity id
            NodeType.MSG_START, // activity type 
            "Event_02ej7g0", // XML ID 
            "startApproval", // activity name 
            "Approbateur", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 14     
        ///////////////////////////////      
        ChildrenOptim[14] = ["Activity_0jptkb4"];
        MsgInOptim[14]= ["Event_0aeztkj"];
        addActivity(
            14,  //activity id
            NodeType.MSG_START, // activity type 
            "Event_1xb2qil", // XML ID 
            "startN1", // activity name 
            "VerificateurN1", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 15     
        ///////////////////////////////      
        ParentsOptim[15] = ["Gateway_05dmrm9"];
        MsgOutOptim[15]= ["Event_1xb2qil"];
        addActivity(
            15,  //activity id
            NodeType.EVENT, // activity type 
            "Event_0aeztkj", // XML ID 
            "intermediateNotify2N1", // activity name 
            "BureauEtude", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 16     
        ///////////////////////////////      
        ChildrenOptim[16] = ["Gateway_08bwshd"];
        MsgInOptim[16]= ["Event_1jryq1w"];
        addActivity(
            16,  //activity id
            NodeType.EVENT, // activity type 
            "Event_1kvcbpv", // XML ID 
            "intermediateCatchfromN1", // activity name 
            "VerificateurN1", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 17     
        ///////////////////////////////      
        ParentsOptim[17] = ["Task_1hcentk"];
        MsgOutOptim[17]= ["Event_0rc5ucp"];
        addActivity(
            17,  //activity id
            NodeType.END, // activity type 
            "Event_0f6zvuq", // XML ID 
            "notifyBureau", // activity name 
            "ChefAffaire", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 18     
        ///////////////////////////////      
        ParentsOptim[18] = ["Activity_15n2fuv"];
        MsgOutOptim[18]= ["Event_1kvcbpv"];
        addActivity(
            18,  //activity id
            NodeType.END, // activity type 
            "Event_1jryq1w", // XML ID 
            "send2N1", // activity name 
            "BureauEtude", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 19     
        ///////////////////////////////      
        ParentsOptim[19] = ["Gateway_0nb1emw"];
        MsgOutOptim[19]= ["Event_0rc5ucp"];
        addActivity(
            19,  //activity id
            NodeType.END, // activity type 
            "Event_1stmo6n", // XML ID 
            "rejectFromN2", // activity name 
            "VerificateurN2", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 20     
        ///////////////////////////////      
        ParentsOptim[20] = ["Gateway_0nb1emw"];
        MsgOutOptim[20]= ["Event_02ej7g0"];
        addActivity(
            20,  //activity id
            NodeType.END, // activity type 
            "Event_0k95nad", // XML ID 
            "send2Approb", // activity name 
            "VerificateurN2", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 21     
        ///////////////////////////////      
        ParentsOptim[21] = ["Gateway_0f0o07g"];
        MsgOutOptim[21]= ["Event_0rc5ucp"];
        addActivity(
            21,  //activity id
            NodeType.END, // activity type 
            "Event_17cg1yq", // XML ID 
            "rejectFromApprob", // activity name 
            "Approbateur", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 22     
        ///////////////////////////////      
        ParentsOptim[22] = ["Activity_1l5e770"];
        addActivity(
            22,  //activity id
            NodeType.END, // activity type 
            "Event_0wwd4it", // XML ID 
            "projectClosing", // activity name 
            "Approbateur", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 23     
        ///////////////////////////////      
        ParentsOptim[23] = ["Gateway_1xsibkd"];
        MsgOutOptim[23]= ["Event_0uel3fu"];
        addActivity(
            23,  //activity id
            NodeType.END, // activity type 
            "Event_0oqnp2p", // XML ID 
            "send2N2", // activity name 
            "VerificateurN1", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 24     
        ///////////////////////////////      
        ParentsOptim[24] = ["Gateway_1xsibkd"];
        MsgOutOptim[24]= ["Event_0rc5ucp"];
        addActivity(
            24,  //activity id
            NodeType.END, // activity type 
            "Event_07w16d4", // XML ID 
            "rejectFromN1", // activity name 
            "VerificateurN1", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 25     
        ///////////////////////////////      
        ChildrenOptim[25] = ["Event_1stmo6n", "Event_0k95nad"];
        ParentsOptim[25] = ["Activity_0p7tzld"];
        addActivity(
            25,  //activity id
            NodeType.XOR, // activity type 
            "Gateway_0nb1emw", // XML ID 
            "ChooseN2", // activity name 
            "VerificateurN2", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 26     
        ///////////////////////////////      
        ChildrenOptim[26] = ["Event_17cg1yq", "Activity_1l5e770"];
        ParentsOptim[26] = ["Activity_0pylq6o"];
        addActivity(
            26,  //activity id
            NodeType.XOR, // activity type 
            "Gateway_0f0o07g", // XML ID 
            "ChooseApprob", // activity name 
            "Approbateur", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 27     
        ///////////////////////////////      
        ChildrenOptim[27] = ["Event_0oqnp2p", "Event_07w16d4"];
        ParentsOptim[27] = ["Activity_03et48t"];
        addActivity(
            27,  //activity id
            NodeType.XOR, // activity type 
            "Gateway_1xsibkd", // XML ID 
            "ChooseN1", // activity name 
            "VerificateurN1", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 28     
        ///////////////////////////////      
        ChildrenOptim[28] = ["Activity_15n2fuv", "Event_0aeztkj"];
        ParentsOptim[28] = ["Event_0rc5ucp"];
        addActivity(
            28,  //activity id
            NodeType.AND, // activity type 
            "Gateway_05dmrm9", // XML ID 
            "startGateway", // activity name 
            "BureauEtude", //lane
            "",
            "",
            "12/31/2022");
        ///////////////////////////////      
        //====> Populate activity 29     
        ///////////////////////////////      
        ChildrenOptim[29] = ["Activity_0fhjnyv"];
        ParentsOptim[29] = ["Event_1kvcbpv", "Activity_0jptkb4"];
        addActivity(
            29,  //activity id
            NodeType.AND, // activity type 
            "Gateway_08bwshd", // XML ID 
            "", // activity name 
            "VerificateurN1", //lane
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