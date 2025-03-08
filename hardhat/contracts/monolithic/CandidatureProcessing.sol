// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;
contract CandidatureProcessing{
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
    addWorkflowInstance("myContract",56);
    markings_included = [0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]; // flow arcs assigned with a sequential index (included/pending/done)
    markings_executed = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    markings_pending = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    //________________________________________ Populate activities ___________________________//    
    ///////////////////////////////      
    //====> Populate activity 0     
    ///////////////////////////////      
    ChildrenOptim[0] = ["sid-5DBD21C6-AD44-46ED-B9D1-D83A53C4D762"];
    ParentsOptim[0] = ["Event_0wwdqz8", "Event_0aaiu74"];
    addActivity(
        0,  //activity id
        NodeType.TASK, // activity type 
        "sid-F6EEA97C-9C7B-4B03-A9EE-F4A43625ED58", // XML ID 
        "Check_completeness", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 1     
    ///////////////////////////////      
    ChildrenOptim[1] = ["sid-1505619A-71B5-4CD4-B43B-8A7B3C5FB2A3"];
    ParentsOptim[1] = ["Condition_E3FED00-6198-442D-AD1F-13F5F4AC2702"];
    MsgOutOptim[1]= ["Event_0ihqmnf"];
    addActivity(
        1,  //activity id
        NodeType.TASK, // activity type 
        "sid-C5140E69-9941-4FDD-9B72-C09B8FA9AC63", // XML ID 
        "Send_letter", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 2     
    ///////////////////////////////      
    ChildrenOptim[2] = ["sid-D9F157BC-3503-4256-95FF-D4CEC06E60EC"];
    ParentsOptim[2] = ["Condition_9199FE7-A7C9-4067-A6F5-2A96C7CA44EA"];
    addActivity(
        2,  //activity id
        NodeType.TASK, // activity type 
        "sid-FAF4FBFF-9326-4934-927E-95332452175B", // XML ID 
        "Check_EN_results", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 3     
    ///////////////////////////////      
    ChildrenOptim[3] = ["Event_17pqln8"];
    ParentsOptim[3] = ["sid-0F539557-E946-4D07-A053-624FE0F7A9C5"];
    addActivity(
        3,  //activity id
        NodeType.TASK, // activity type 
        "sid-F010C42E-D874-4695-8D91-A414436F1A40", // XML ID 
        "Assess_degree", // activity name 
        "Academic recognition agency", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 4     
    ///////////////////////////////      
    ChildrenOptim[4] = ["sid-8BB0A901-F371-49BC-9A28-E444E639F6B1"];
    ParentsOptim[4] = ["sid-D933CBFE-6E5F-4856-B556-CBC39F5901E9"];
    addActivity(
        4,  //activity id
        NodeType.TASK, // activity type 
        "sid-A03A9E69-F212-4F45-BA65-993CE9B11FD8", // XML ID 
        "Examine_application", // activity name 
        "Academic committee", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 5     
    ///////////////////////////////      
    ChildrenOptim[5] = ["Event_1xf6yr3"];
    ParentsOptim[5] = ["sid-A03A9E69-F212-4F45-BA65-993CE9B11FD8"];
    addActivity(
        5,  //activity id
        NodeType.TASK, // activity type 
        "sid-8BB0A901-F371-49BC-9A28-E444E639F6B1", // XML ID 
        "Record_outcome", // activity name 
        "Academic committee", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 6     
    ///////////////////////////////      
    ChildrenOptim[6] = ["Gateway_0bnfuj2"];
    ParentsOptim[6] = ["Gateway_1318jda"];
    addActivity(
        6,  //activity id
        NodeType.TASK, // activity type 
        "Activity_0cpaql2", // XML ID 
        "Waiting_time", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 7     
    ///////////////////////////////      
    ChildrenOptim[7] = ["Gateway_1318jda"];
    ParentsOptim[7] = ["Gateway_0tdxbg3"];
    addActivity(
        7,  //activity id
        NodeType.TASK, // activity type 
        "Activity_0aqy0se", // XML ID 
        "RAS", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 8     
    ///////////////////////////////      
    ChildrenOptim[8] = ["Event_03wddcr"];
    MsgInOptim[8]= ["Event_1ui4i16"];
    addActivity(
        8,  //activity id
        NodeType.MSG_START, // activity type 
        "sid-F3F51C0A-A26D-4A56-A911-ADE749A03597", // XML ID 
        "", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 9     
    ///////////////////////////////      
    ChildrenOptim[9] = ["sid-F010C42E-D874-4695-8D91-A414436F1A40"];
    MsgInOptim[9]= ["Event_04hbmfi"];
    addActivity(
        9,  //activity id
        NodeType.MSG_START, // activity type 
        "sid-0F539557-E946-4D07-A053-624FE0F7A9C5", // XML ID 
        "", // activity name 
        "Academic recognition agency", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 10     
    ///////////////////////////////      
    ChildrenOptim[10] = ["sid-A03A9E69-F212-4F45-BA65-993CE9B11FD8"];
    MsgInOptim[10]= ["Event_1u0p6vg"];
    addActivity(
        10,  //activity id
        NodeType.MSG_START, // activity type 
        "sid-D933CBFE-6E5F-4856-B556-CBC39F5901E9", // XML ID 
        "", // activity name 
        "Academic committee", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 11     
    ///////////////////////////////      
    ChildrenOptim[11] = ["Event_1ui4i16"];
    addActivity(
        11,  //activity id
        NodeType.START, // activity type 
        "Event_0zrj276", // XML ID 
        "", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 12     
    ///////////////////////////////      
    ChildrenOptim[12] = ["Event_0wwdqz8"];
    ParentsOptim[12] = ["sid-F3F51C0A-A26D-4A56-A911-ADE749A03597"];
    MsgOutOptim[12]= ["Event_04xo1k6"];
    addActivity(
        12,  //activity id
        NodeType.EVENT, // activity type 
        "Event_03wddcr", // XML ID 
        "Send PDF", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 13     
    ///////////////////////////////      
    ChildrenOptim[13] = ["Event_1ggxe1u"];
    ParentsOptim[13] = ["Condition_E2F08D2-D8B4-4624-9D6D-F7FDB5C57607"];
    MsgOutOptim[13]= ["sid-D933CBFE-6E5F-4856-B556-CBC39F5901E9"];
    addActivity(
        13,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1u0p6vg", // XML ID 
        "Send documents", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 14     
    ///////////////////////////////      
    ParentsOptim[14] = ["Condition_195BFBF-17B4-44F3-8447-6225079296D9"];
    MsgOutOptim[14]= ["Event_0v5b2cd"];
    addActivity(
        14,  //activity id
        NodeType.EVENT, // activity type 
        "Event_11baz0c", // XML ID 
        "Request documents", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 15     
    ///////////////////////////////      
    ChildrenOptim[15] = ["sid-F4293FE0-FD92-438F-8F32-9C6E7340237A"];
    ParentsOptim[15] = ["Condition_AAD65A5-6FB9-41E9-971C-76416F06B577"];
    MsgOutOptim[15]= ["Event_0tpl3cz"];
    addActivity(
        15,  //activity id
        NodeType.EVENT, // activity type 
        "Event_19cdlk5", // XML ID 
        "Send rejection email 1", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 16     
    ///////////////////////////////      
    ChildrenOptim[16] = ["sid-F0F0BF89-BB6E-48E2-8554-6C161A792B91"];
    ParentsOptim[16] = ["Condition_AE2A25E-3BE4-481A-A2A8-D79A3143BC61"];
    MsgOutOptim[16]= ["Event_0tpl3cz"];
    addActivity(
        16,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1hhyzwx", // XML ID 
        "Send rejection email 2", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 17     
    ///////////////////////////////      
    ChildrenOptim[17] = ["Event_1wl91q4"];
    ParentsOptim[17] = ["Condition_E16D4C1-4FFD-4FFE-9638-7419B9F50D65"];
    MsgOutOptim[17]= ["sid-0F539557-E946-4D07-A053-624FE0F7A9C5"];
    addActivity(
        17,  //activity id
        NodeType.EVENT, // activity type 
        "Event_04hbmfi", // XML ID 
        "Send copy degrees", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 18     
    ///////////////////////////////      
    ChildrenOptim[18] = ["sid-7FFDE347-5B92-41DD-B050-71385C21D46B"];
    ParentsOptim[18] = ["Event_1ggxe1u"];
    MsgOutOptim[18]= ["Event_0364blm"];
    addActivity(
        18,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1oq4h3s", // XML ID 
        "Send selection outcome", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 19     
    ///////////////////////////////      
    ChildrenOptim[19] = ["sid-5958B3F4-808E-45CC-B274-D851FE52AC05"];
    ParentsOptim[19] = ["sid-F010C42E-D874-4695-8D91-A414436F1A40"];
    MsgOutOptim[19]= ["Event_1wl91q4"];
    addActivity(
        19,  //activity id
        NodeType.EVENT, // activity type 
        "Event_17pqln8", // XML ID 
        "Send outcome", // activity name 
        "Academic recognition agency", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 20     
    ///////////////////////////////      
    ChildrenOptim[20] = ["sid-85B4C9C1-9333-459C-BA58-16C5C0941D3C"];
    ParentsOptim[20] = ["sid-8BB0A901-F371-49BC-9A28-E444E639F6B1"];
    MsgOutOptim[20]= ["Event_1ggxe1u"];
    addActivity(
        20,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1xf6yr3", // XML ID 
        "automatic notification", // activity name 
        "Academic committee", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 21     
    ///////////////////////////////      
    ChildrenOptim[21] = ["Event_04xo1k6"];
    ParentsOptim[21] = ["Event_0zrj276"];
    MsgOutOptim[21]= ["sid-F3F51C0A-A26D-4A56-A911-ADE749A03597"];
    addActivity(
        21,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1ui4i16", // XML ID 
        "start registration", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 22     
    ///////////////////////////////      
    ChildrenOptim[22] = ["Gateway_0tdxbg3"];
    ParentsOptim[22] = ["Event_04xo1k6"];
    MsgOutOptim[22]= ["Event_0wwdqz8"];
    addActivity(
        22,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0z6wzdo", // XML ID 
        "Send candidature", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 23     
    ///////////////////////////////      
    ChildrenOptim[23] = ["Gateway_1318jda"];
    ParentsOptim[23] = ["Event_0v5b2cd"];
    MsgOutOptim[23]= ["Event_0aaiu74"];
    addActivity(
        23,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0kb0mgy", // XML ID 
        "Send complementary documents", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 24     
    ///////////////////////////////      
    ChildrenOptim[24] = ["sid-F6EEA97C-9C7B-4B03-A9EE-F4A43625ED58"];
    ParentsOptim[24] = ["Event_03wddcr"];
    MsgInOptim[24]= ["Event_0z6wzdo"];
    addActivity(
        24,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0wwdqz8", // XML ID 
        "get candidature", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 25     
    ///////////////////////////////      
    ChildrenOptim[25] = ["sid-F6EEA97C-9C7B-4B03-A9EE-F4A43625ED58"];
    MsgInOptim[25]= ["Event_0kb0mgy"];
    addActivity(
        25,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0aaiu74", // XML ID 
        "", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 26     
    ///////////////////////////////      
    ChildrenOptim[26] = ["sid-EEB6AF56-D570-4A90-9D6F-3DD4C1F7C2CD"];
    ParentsOptim[26] = ["Event_04hbmfi"];
    MsgInOptim[26]= ["Event_17pqln8"];
    addActivity(
        26,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1wl91q4", // XML ID 
        "Process outcome", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 27     
    ///////////////////////////////      
    ChildrenOptim[27] = ["Event_1oq4h3s"];
    ParentsOptim[27] = ["Event_1u0p6vg"];
    MsgInOptim[27]= ["Event_1xf6yr3"];
    addActivity(
        27,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1ggxe1u", // XML ID 
        "get email", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 28     
    ///////////////////////////////      
    ChildrenOptim[28] = ["Event_0z6wzdo"];
    ParentsOptim[28] = ["Event_1ui4i16"];
    MsgInOptim[28]= ["Event_03wddcr"];
    addActivity(
        28,  //activity id
        NodeType.EVENT, // activity type 
        "Event_04xo1k6", // XML ID 
        "receive pdf", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 29     
    ///////////////////////////////      
    ChildrenOptim[29] = ["Event_0kb0mgy"];
    ParentsOptim[29] = ["Gateway_0tdxbg3"];
    MsgInOptim[29]= ["Event_11baz0c"];
    addActivity(
        29,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0v5b2cd", // XML ID 
        "receive req", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 30     
    ///////////////////////////////      
    ChildrenOptim[30] = ["Event_0cg2tgf"];
    ParentsOptim[30] = ["Gateway_0bnfuj2"];
    MsgInOptim[30]= ["Event_19cdlk5", "Event_1hhyzwx"];
    addActivity(
        30,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0tpl3cz", // XML ID 
        "reject notif", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 31     
    ///////////////////////////////      
    ChildrenOptim[31] = ["Event_0ihqmnf"];
    ParentsOptim[31] = ["Gateway_0bnfuj2"];
    MsgInOptim[31]= ["Event_1oq4h3s"];
    addActivity(
        31,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0364blm", // XML ID 
        "accept notif", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 32     
    ///////////////////////////////      
    ChildrenOptim[32] = ["Event_0xvdj50"];
    ParentsOptim[32] = ["Event_0364blm"];
    MsgInOptim[32]= ["sid-C5140E69-9941-4FDD-9B72-C09B8FA9AC63"];
    addActivity(
        32,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0ihqmnf", // XML ID 
        "get admission letter", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 33     
    ///////////////////////////////      
    ParentsOptim[33] = ["sid-C5140E69-9941-4FDD-9B72-C09B8FA9AC63"];
    addActivity(
        33,  //activity id
        NodeType.END, // activity type 
        "sid-1505619A-71B5-4CD4-B43B-8A7B3C5FB2A3", // XML ID 
        "", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 34     
    ///////////////////////////////      
    ParentsOptim[34] = ["Event_19cdlk5"];
    addActivity(
        34,  //activity id
        NodeType.END, // activity type 
        "sid-F4293FE0-FD92-438F-8F32-9C6E7340237A", // XML ID 
        "", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 35     
    ///////////////////////////////      
    ParentsOptim[35] = ["Event_1hhyzwx"];
    addActivity(
        35,  //activity id
        NodeType.END, // activity type 
        "sid-F0F0BF89-BB6E-48E2-8554-6C161A792B91", // XML ID 
        "", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 36     
    ///////////////////////////////      
    ParentsOptim[36] = ["Condition_A03919B-2C62-4AB6-8497-3A48255014C2"];
    addActivity(
        36,  //activity id
        NodeType.END, // activity type 
        "sid-E903D92E-EC93-4CEC-A1E4-57D8157DCB65", // XML ID 
        "", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 37     
    ///////////////////////////////      
    ParentsOptim[37] = ["Event_17pqln8"];
    addActivity(
        37,  //activity id
        NodeType.END, // activity type 
        "sid-5958B3F4-808E-45CC-B274-D851FE52AC05", // XML ID 
        "", // activity name 
        "Academic recognition agency", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 38     
    ///////////////////////////////      
    ParentsOptim[38] = ["Event_1xf6yr3"];
    addActivity(
        38,  //activity id
        NodeType.END, // activity type 
        "sid-85B4C9C1-9333-459C-BA58-16C5C0941D3C", // XML ID 
        "", // activity name 
        "Academic committee", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 39     
    ///////////////////////////////      
    ParentsOptim[39] = ["Event_0tpl3cz"];
    addActivity(
        39,  //activity id
        NodeType.END, // activity type 
        "Event_0cg2tgf", // XML ID 
        "", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 40     
    ///////////////////////////////      
    ParentsOptim[40] = ["Event_0ihqmnf"];
    addActivity(
        40,  //activity id
        NodeType.END, // activity type 
        "Event_0xvdj50", // XML ID 
        "", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 41     
    ///////////////////////////////      
    ChildrenOptim[41] = ["Condition_195BFBF-17B4-44F3-8447-6225079296D9", "Condition_E16D4C1-4FFD-4FFE-9638-7419B9F50D65"];
    ParentsOptim[41] = ["sid-F6EEA97C-9C7B-4B03-A9EE-F4A43625ED58"];
    addActivity(
        41,  //activity id
        NodeType.XOR, // activity type 
        "sid-5DBD21C6-AD44-46ED-B9D1-D83A53C4D762", // XML ID 
        "", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 42     
    ///////////////////////////////      
    ChildrenOptim[42] = ["Condition_AE2A25E-3BE4-481A-A2A8-D79A3143BC61", "Condition_E2F08D2-D8B4-4624-9D6D-F7FDB5C57607"];
    ParentsOptim[42] = ["sid-FAF4FBFF-9326-4934-927E-95332452175B"];
    addActivity(
        42,  //activity id
        NodeType.XOR, // activity type 
        "sid-D9F157BC-3503-4256-95FF-D4CEC06E60EC", // XML ID 
        "", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 43     
    ///////////////////////////////      
    ChildrenOptim[43] = ["Condition_E3FED00-6198-442D-AD1F-13F5F4AC2702", "Condition_A03919B-2C62-4AB6-8497-3A48255014C2"];
    ParentsOptim[43] = ["Event_1oq4h3s"];
    addActivity(
        43,  //activity id
        NodeType.XOR, // activity type 
        "sid-7FFDE347-5B92-41DD-B050-71385C21D46B", // XML ID 
        "", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 44     
    ///////////////////////////////      
    ChildrenOptim[44] = ["Condition_9199FE7-A7C9-4067-A6F5-2A96C7CA44EA", "Condition_AAD65A5-6FB9-41E9-971C-76416F06B577"];
    ParentsOptim[44] = ["Event_1wl91q4"];
    addActivity(
        44,  //activity id
        NodeType.XOR, // activity type 
        "sid-EEB6AF56-D570-4A90-9D6F-3DD4C1F7C2CD", // XML ID 
        "", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 45     
    ///////////////////////////////      
    ChildrenOptim[45] = ["Event_0v5b2cd", "Activity_0aqy0se"];
    ParentsOptim[45] = ["Event_0z6wzdo"];
    addActivity(
        45,  //activity id
        NodeType.XOR, // activity type 
        "Gateway_0tdxbg3", // XML ID 
        "", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 46     
    ///////////////////////////////      
    ChildrenOptim[46] = ["Activity_0cpaql2"];
    ParentsOptim[46] = ["Activity_0aqy0se", "Event_0kb0mgy"];
    addActivity(
        46,  //activity id
        NodeType.XOR, // activity type 
        "Gateway_1318jda", // XML ID 
        "", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 47     
    ///////////////////////////////      
    ChildrenOptim[47] = ["Event_0tpl3cz", "Event_0364blm"];
    ParentsOptim[47] = ["Activity_0cpaql2"];
    addActivity(
        47,  //activity id
        NodeType.XOR, // activity type 
        "Gateway_0bnfuj2", // XML ID 
        "", // activity name 
        "Student", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 48     
    ///////////////////////////////      
    ChildrenOptim[48] = ["Event_11baz0c"];
    ParentsOptim[48] = ["sid-5DBD21C6-AD44-46ED-B9D1-D83A53C4D762"];
    addActivity(
        48,  //activity id
        NodeType.TASK, // activity type 
        "Condition_195BFBF-17B4-44F3-8447-6225079296D9", // XML ID 
        "Incomplete", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 49     
    ///////////////////////////////      
    ChildrenOptim[49] = ["Event_04hbmfi"];
    ParentsOptim[49] = ["sid-5DBD21C6-AD44-46ED-B9D1-D83A53C4D762"];
    addActivity(
        49,  //activity id
        NodeType.TASK, // activity type 
        "Condition_E16D4C1-4FFD-4FFE-9638-7419B9F50D65", // XML ID 
        "Complete", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 50     
    ///////////////////////////////      
    ChildrenOptim[50] = ["sid-FAF4FBFF-9326-4934-927E-95332452175B"];
    ParentsOptim[50] = ["sid-EEB6AF56-D570-4A90-9D6F-3DD4C1F7C2CD"];
    addActivity(
        50,  //activity id
        NodeType.TASK, // activity type 
        "Condition_9199FE7-A7C9-4067-A6F5-2A96C7CA44EA", // XML ID 
        "Pass", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 51     
    ///////////////////////////////      
    ChildrenOptim[51] = ["Event_19cdlk5"];
    ParentsOptim[51] = ["sid-EEB6AF56-D570-4A90-9D6F-3DD4C1F7C2CD"];
    addActivity(
        51,  //activity id
        NodeType.TASK, // activity type 
        "Condition_AAD65A5-6FB9-41E9-971C-76416F06B577", // XML ID 
        "Fail", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 52     
    ///////////////////////////////      
    ChildrenOptim[52] = ["Event_1hhyzwx"];
    ParentsOptim[52] = ["sid-D9F157BC-3503-4256-95FF-D4CEC06E60EC"];
    addActivity(
        52,  //activity id
        NodeType.TASK, // activity type 
        "Condition_AE2A25E-3BE4-481A-A2A8-D79A3143BC61", // XML ID 
        "Fail", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 53     
    ///////////////////////////////      
    ChildrenOptim[53] = ["Event_1u0p6vg"];
    ParentsOptim[53] = ["sid-D9F157BC-3503-4256-95FF-D4CEC06E60EC"];
    addActivity(
        53,  //activity id
        NodeType.TASK, // activity type 
        "Condition_E2F08D2-D8B4-4624-9D6D-F7FDB5C57607", // XML ID 
        "Pass", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 54     
    ///////////////////////////////      
    ChildrenOptim[54] = ["sid-C5140E69-9941-4FDD-9B72-C09B8FA9AC63"];
    ParentsOptim[54] = ["sid-7FFDE347-5B92-41DD-B050-71385C21D46B"];
    addActivity(
        54,  //activity id
        NodeType.TASK, // activity type 
        "Condition_E3FED00-6198-442D-AD1F-13F5F4AC2702", // XML ID 
        "Admitted", // activity name 
        "Admission office", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 55     
    ///////////////////////////////      
    ChildrenOptim[55] = ["sid-E903D92E-EC93-4CEC-A1E4-57D8157DCB65"];
    ParentsOptim[55] = ["sid-7FFDE347-5B92-41DD-B050-71385C21D46B"];
    addActivity(
        55,  //activity id
        NodeType.TASK, // activity type 
        "Condition_A03919B-2C62-4AB6-8497-3A48255014C2", // XML ID 
        "Rejected", // activity name 
        "Admission office", //lane
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