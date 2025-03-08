// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;
contract Circee{
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
    addWorkflowInstance("myContract",39);
    markings_included = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]; // flow arcs assigned with a sequential index (included/pending/done)
    markings_executed = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    markings_pending = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    //________________________________________ Populate activities ___________________________//    
    ///////////////////////////////      
    //====> Populate activity 0     
    ///////////////////////////////      
    ChildrenOptim[0] = ["Event_1bzza4i"];
    ParentsOptim[0] = ["Event_0ingiww"];
    addActivity(
        0,  //activity id
        NodeType.TASK, // activity type 
        "Activity_1w37624", // XML ID 
        "Acquisition_scans_avec_trepied", // activity name 
        "Presta_Lasers_type1", //lane
        "{relevesLaserT1:xxxx}",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 1     
    ///////////////////////////////      
    ChildrenOptim[1] = ["Activity_04bqzb6"];
    ParentsOptim[1] = ["Gateway_1f36shi"];
    addActivity(
        1,  //activity id
        NodeType.TASK, // activity type 
        "Activity_1phykio", // XML ID 
        "Segmentation_Nuage_Points", // activity name 
        "EDF", //lane
        "",
        "{tuyauterie_nuage_points:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 2     
    ///////////////////////////////      
    ChildrenOptim[2] = ["Gateway_0azmwqm"];
    ParentsOptim[2] = ["Gateway_14bqcdn"];
    addActivity(
        2,  //activity id
        NodeType.TASK, // activity type 
        "Activity_0q0i9ua", // XML ID 
        "Spec_geom_chargement_maquette_num_software_jarod", // activity name 
        "EDF", //lane
        "",
        "{MerkleTreeAnchoringInputs:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 3     
    ///////////////////////////////      
    ChildrenOptim[3] = ["Gateway_0azmwqm"];
    ParentsOptim[3] = ["Gateway_14bqcdn"];
    addActivity(
        3,  //activity id
        NodeType.TASK, // activity type 
        "Activity_0yy5yxi", // XML ID 
        "Spec_chargements", // activity name 
        "EDF", //lane
        "",
        "{chargements_storage_EDFSP:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 4     
    ///////////////////////////////      
    ChildrenOptim[4] = ["Gateway_0azmwqm"];
    ParentsOptim[4] = ["Activity_1phykio"];
    addActivity(
        4,  //activity id
        NodeType.TASK, // activity type 
        "Activity_04bqzb6", // XML ID 
        "Reconstruction_tuyauterie", // activity name 
        "EDF", //lane
        "{tuyauterie_nuage_points:xxxx}",
        "{Fichier_commande_piping_master:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 5     
    ///////////////////////////////      
    ChildrenOptim[5] = ["Gateway_1f36shi"];
    ParentsOptim[5] = ["Event_1dc7pwe"];
    addActivity(
        5,  //activity id
        NodeType.TASK, // activity type 
        "Activity_1r4z8q0", // XML ID 
        "Reception_scan_s1_enregistrement_maquette_hybride", // activity name 
        "EDF", //lane
        "{relevesLaserT1:xxxx,infosCentraleT1:xxxx}",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 6     
    ///////////////////////////////      
    ChildrenOptim[6] = ["Gateway_1f36shi"];
    ParentsOptim[6] = ["Event_1yw4jv6"];
    addActivity(
        6,  //activity id
        NodeType.TASK, // activity type 
        "Activity_0n6ybe3", // XML ID 
        "Reception_scan_s2_enregistrement_maquette_hybride", // activity name 
        "EDF", //lane
        "{relevesLaserT2:xxxx,infosCentraleT2:xxxx}",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 7     
    ///////////////////////////////      
    ChildrenOptim[7] = ["Activity_14i49l1"];
    ParentsOptim[7] = ["Gateway_0azmwqm"];
    addActivity(
        7,  //activity id
        NodeType.TASK, // activity type 
        "Activity_0qxkr87", // XML ID 
        "Synthese_spec", // activity name 
        "EDF", //lane
        "{chargements_storage_EDFSP:xxxx,MerkleTreeAnchoringInputs:xxxx,Fichier_commande_piping_master:xxxx}",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 8     
    ///////////////////////////////      
    ChildrenOptim[8] = ["Event_1wkuekg"];
    ParentsOptim[8] = ["Activity_0qxkr87", "Gateway_0emtvpg"];
    addActivity(
        8,  //activity id
        NodeType.TASK, // activity type 
        "Activity_14i49l1", // XML ID 
        "Generation_fichier_commande_partiel", // activity name 
        "EDF", //lane
        "{Fichier_commande_piping_master:xxxx}",
        "{Fichier_commande_partiel:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 9     
    ///////////////////////////////      
    ChildrenOptim[9] = ["Event_0g3nqpl"];
    ParentsOptim[9] = ["Event_1wkuekg"];
    addActivity(
        9,  //activity id
        NodeType.TASK, // activity type 
        "Activity_0wegxvj", // XML ID 
        "Reception_validation_etude", // activity name 
        "EDF", //lane
        "{ResultatsCalculFlex:xxxx,NoteCalcul:xxxx}",
        "{ResultatsCalculFlexArchive_storage_GED:xxxx,NoteCalculArchivee_storage_dossierEtude:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 10     
    ///////////////////////////////      
    ChildrenOptim[10] = ["Event_0fnhvh2"];
    ParentsOptim[10] = ["Event_1m8nrx4"];
    addActivity(
        10,  //activity id
        NodeType.TASK, // activity type 
        "Activity_0bqjss0", // XML ID 
        "Acquisition_rapide", // activity name 
        "Presta_Lasers_2", //lane
        "{relevesLaserT2:xxxx}",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 11     
    ///////////////////////////////      
    ChildrenOptim[11] = ["Event_1b8l7ac"];
    ParentsOptim[11] = ["Event_03x3hs9"];
    addActivity(
        11,  //activity id
        NodeType.TASK, // activity type 
        "Activity_0b1xao9", // XML ID 
        "calculs_flex", // activity name 
        "BEP", //lane
        "{optionsCalcul:xxxx,Fichier_commande_partiel:xxxx}",
        "{ResultatsCalculFlex:xxxx,NoteCalcul:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 12     
    ///////////////////////////////      
    ChildrenOptim[12] = ["Gateway_0dfbndb"];
    ParentsOptim[12] = ["Event_1l1eu2i"];
    addActivity(
        12,  //activity id
        NodeType.TASK, // activity type 
        "Activity_1qd5ddw", // XML ID 
        "audit_notes_calcul", // activity name 
        "ASN_ou_Organisme_Surete", //lane
        "{NoteCalculArchivee_storage_dossierEtude:xxxx,ResultatsCalculFlexArchive_storage_GED:xxxx}",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 13     
    ///////////////////////////////      
    ChildrenOptim[13] = ["Event_1a716b4"];
    ParentsOptim[13] = ["Gateway_0dfbndb"];
    addActivity(
        13,  //activity id
        NodeType.TASK, // activity type 
        "Activity_0u6d2a9", // XML ID 
        "EmissionCertificat", // activity name 
        "ASN_ou_Organisme_Surete", //lane
        "",
        "{CertificatEtude:xxxx}",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 14     
    ///////////////////////////////      
    ChildrenOptim[14] = ["Event_0mvm5x8"];
    ParentsOptim[14] = ["Gateway_0qdpemg"];
    MsgInOptim[14]= ["Event_1a716b4"];
    addActivity(
        14,  //activity id
        NodeType.TASK, // activity type 
        "Activity_1btjbfw", // XML ID 
        "Deverouillage_Etude_dans_GED_pour_reutilisation", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 15     
    ///////////////////////////////      
    ChildrenOptim[15] = ["Activity_1w37624"];
    MsgInOptim[15]= ["Event_10iqpl6"];
    addActivity(
        15,  //activity id
        NodeType.START, // activity type 
        "Event_0ingiww", // XML ID 
        "", // activity name 
        "Presta_Lasers_type1", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 16     
    ///////////////////////////////      
    ChildrenOptim[16] = ["Gateway_14bqcdn"];
    addActivity(
        16,  //activity id
        NodeType.START, // activity type 
        "Event_0t2k2yb", // XML ID 
        "", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 17     
    ///////////////////////////////      
    ChildrenOptim[17] = ["Activity_0bqjss0"];
    MsgInOptim[17]= ["Event_129q8un"];
    addActivity(
        17,  //activity id
        NodeType.START, // activity type 
        "Event_1m8nrx4", // XML ID 
        "", // activity name 
        "Presta_Lasers_2", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 18     
    ///////////////////////////////      
    ChildrenOptim[18] = ["Activity_0b1xao9"];
    MsgInOptim[18]= ["Event_1wkuekg"];
    addActivity(
        18,  //activity id
        NodeType.START, // activity type 
        "Event_03x3hs9", // XML ID 
        "", // activity name 
        "BEP", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 19     
    ///////////////////////////////      
    ChildrenOptim[19] = ["Activity_1qd5ddw"];
    MsgInOptim[19]= ["Event_0g3nqpl"];
    addActivity(
        19,  //activity id
        NodeType.START, // activity type 
        "Event_1l1eu2i", // XML ID 
        "", // activity name 
        "ASN_ou_Organisme_Surete", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 20     
    ///////////////////////////////      
    ChildrenOptim[20] = ["Event_1yw4jv6"];
    ParentsOptim[20] = ["Gateway_0duxwpz"];
    MsgOutOptim[20]= ["Event_1m8nrx4"];
    addActivity(
        20,  //activity id
        NodeType.EVENT, // activity type 
        "Event_129q8un", // XML ID 
        "demandeEnqueteType2", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 21     
    ///////////////////////////////      
    ChildrenOptim[21] = ["Event_1dc7pwe"];
    ParentsOptim[21] = ["Gateway_0duxwpz"];
    MsgOutOptim[21]= ["Event_0ingiww"];
    addActivity(
        21,  //activity id
        NodeType.EVENT, // activity type 
        "Event_10iqpl6", // XML ID 
        "demandeEnqueteType1", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 22     
    ///////////////////////////////      
    ChildrenOptim[22] = ["Activity_0wegxvj"];
    ParentsOptim[22] = ["Activity_14i49l1", "Gateway_0emtvpg"];
    MsgOutOptim[22]= ["Event_03x3hs9"];
    addActivity(
        22,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1wkuekg", // XML ID 
        "demandeSousTraitanceCalculsFlex", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 23     
    ///////////////////////////////      
    ChildrenOptim[23] = ["Gateway_0qdpemg"];
    ParentsOptim[23] = ["Activity_0wegxvj"];
    MsgOutOptim[23]= ["Event_1l1eu2i"];
    addActivity(
        23,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0g3nqpl", // XML ID 
        "demandeCertificationEtude", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 24     
    ///////////////////////////////      
    ChildrenOptim[24] = ["Activity_0n6ybe3"];
    ParentsOptim[24] = ["Event_129q8un"];
    MsgInOptim[24]= ["Event_0fnhvh2"];
    addActivity(
        24,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1yw4jv6", // XML ID 
        "", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 25     
    ///////////////////////////////      
    ChildrenOptim[25] = ["Activity_1r4z8q0"];
    ParentsOptim[25] = ["Event_10iqpl6"];
    MsgInOptim[25]= ["Event_1bzza4i"];
    addActivity(
        25,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1dc7pwe", // XML ID 
        "", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 26     
    ///////////////////////////////      
    ChildrenOptim[26] = ["Gateway_0emtvpg"];
    ParentsOptim[26] = ["Gateway_0qdpemg"];
    MsgInOptim[26]= ["Event_1oshbnx"];
    addActivity(
        26,  //activity id
        NodeType.EVENT, // activity type 
        "Event_095bjm0", // XML ID 
        "RejectEtude", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 27     
    ///////////////////////////////      
    ParentsOptim[27] = ["Activity_1w37624"];
    MsgOutOptim[27]= ["Event_1dc7pwe"];
    addActivity(
        27,  //activity id
        NodeType.END, // activity type 
        "Event_1bzza4i", // XML ID 
        "", // activity name 
        "Presta_Lasers_type1", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 28     
    ///////////////////////////////      
    ParentsOptim[28] = ["Activity_1btjbfw"];
    addActivity(
        28,  //activity id
        NodeType.END, // activity type 
        "Event_0mvm5x8", // XML ID 
        "", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 29     
    ///////////////////////////////      
    ParentsOptim[29] = ["Activity_0bqjss0"];
    MsgOutOptim[29]= ["Event_1yw4jv6"];
    addActivity(
        29,  //activity id
        NodeType.END, // activity type 
        "Event_0fnhvh2", // XML ID 
        "", // activity name 
        "Presta_Lasers_2", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 30     
    ///////////////////////////////      
    ParentsOptim[30] = ["Activity_0b1xao9"];
    addActivity(
        30,  //activity id
        NodeType.END, // activity type 
        "Event_1b8l7ac", // XML ID 
        "", // activity name 
        "BEP", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 31     
    ///////////////////////////////      
    ParentsOptim[31] = ["Activity_0u6d2a9"];
    MsgOutOptim[31]= ["Activity_1btjbfw"];
    addActivity(
        31,  //activity id
        NodeType.END, // activity type 
        "Event_1a716b4", // XML ID 
        "", // activity name 
        "ASN_ou_Organisme_Surete", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 32     
    ///////////////////////////////      
    ParentsOptim[32] = ["Gateway_0dfbndb"];
    MsgOutOptim[32]= ["Event_095bjm0"];
    addActivity(
        32,  //activity id
        NodeType.END, // activity type 
        "Event_1oshbnx", // XML ID 
        "", // activity name 
        "ASN_ou_Organisme_Surete", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 33     
    ///////////////////////////////      
    ChildrenOptim[33] = ["Activity_14i49l1", "Event_1wkuekg"];
    ParentsOptim[33] = ["Event_095bjm0"];
    addActivity(
        33,  //activity id
        NodeType.XOR, // activity type 
        "Gateway_0emtvpg", // XML ID 
        "", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 34     
    ///////////////////////////////      
    ChildrenOptim[34] = ["Event_1oshbnx", "Activity_0u6d2a9"];
    ParentsOptim[34] = ["Activity_1qd5ddw"];
    addActivity(
        34,  //activity id
        NodeType.XOR, // activity type 
        "Gateway_0dfbndb", // XML ID 
        "", // activity name 
        "ASN_ou_Organisme_Surete", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 35     
    ///////////////////////////////      
    ChildrenOptim[35] = ["Gateway_0duxwpz", "Activity_0yy5yxi", "Activity_0q0i9ua"];
    ParentsOptim[35] = ["Event_0t2k2yb"];
    addActivity(
        35,  //activity id
        NodeType.AND, // activity type 
        "Gateway_14bqcdn", // XML ID 
        "", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 36     
    ///////////////////////////////      
    ChildrenOptim[36] = ["Activity_0qxkr87"];
    ParentsOptim[36] = ["Activity_04bqzb6", "Activity_0q0i9ua", "Activity_0yy5yxi"];
    addActivity(
        36,  //activity id
        NodeType.AND, // activity type 
        "Gateway_0azmwqm", // XML ID 
        "", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 37     
    ///////////////////////////////      
    ChildrenOptim[37] = ["Event_10iqpl6", "Event_129q8un"];
    ParentsOptim[37] = ["Gateway_14bqcdn"];
    addActivity(
        37,  //activity id
        NodeType.AND, // activity type 
        "Gateway_0duxwpz", // XML ID 
        "", // activity name 
        "EDF", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 38     
    ///////////////////////////////      
    ChildrenOptim[38] = ["Activity_1phykio"];
    ParentsOptim[38] = ["Activity_1r4z8q0", "Activity_0n6ybe3"];
    addActivity(
        38,  //activity id
        NodeType.AND, // activity type 
        "Gateway_1f36shi", // XML ID 
        "", // activity name 
        "EDF", //lane
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