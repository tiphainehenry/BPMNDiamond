// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;
contract SPARKLogistics{
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
    addWorkflowInstance("myContract",68);
    markings_included = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]; // flow arcs assigned with a sequential index (included/pending/done)
    markings_executed = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    markings_pending = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    //________________________________________ Populate activities ___________________________//    
    ///////////////////////////////      
    //====> Populate activity 0     
    ///////////////////////////////      
    ChildrenOptim[0] = ["sid-AA3FD24D-6A11-48C3-AA58-8ED61F07FCF2"];
    ParentsOptim[0] = ["Event_0cypz96"];
    addActivity(
        0,  //activity id
        NodeType.TASK, // activity type 
        "sid-47441335-A92F-4B95-999B-5A0FCDFEE072", // XML ID 
        "Quote_Analysis", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 1     
    ///////////////////////////////      
    ChildrenOptim[1] = ["sid-9FD79319-1B71-4B25-94D0-C1C0BC04417B"];
    ParentsOptim[1] = ["Condition_25F9785-235F-4BA8-8D3F-3854798E6EF0"];
    addActivity(
        1,  //activity id
        NodeType.TASK, // activity type 
        "sid-5D8D22A7-1742-4EA1-B8AA-77860774A62E", // XML ID 
        "Pay_Sparks", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 2     
    ///////////////////////////////      
    ChildrenOptim[2] = ["Event_0vjtkcs"];
    ParentsOptim[2] = ["sid-65720A2A-2794-4BD3-B673-5E38D0A4D4E1"];
    MsgOutOptim[2]= ["Event_0x8291w"];
    addActivity(
        2,  //activity id
        NodeType.TASK, // activity type 
        "Activity_0esk4hs", // XML ID 
        "Cancel_order", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 3     
    ///////////////////////////////      
    ChildrenOptim[3] = ["sid-26DBEBFF-BAF1-4B88-A84A-25E87D8B2878"];
    ParentsOptim[3] = ["Event_1vttjvz"];
    addActivity(
        3,  //activity id
        NodeType.TASK, // activity type 
        "sid-9278779F-D64C-44A8-BB23-342FD885198D", // XML ID 
        "Estimate_the_expected_usage", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 4     
    ///////////////////////////////      
    ChildrenOptim[4] = ["sid-B7D6978C-9985-4CE9-9D8F-5884DE9B75BE"];
    ParentsOptim[4] = ["sid-9278779F-D64C-44A8-BB23-342FD885198D"];
    addActivity(
        4,  //activity id
        NodeType.TASK, // activity type 
        "sid-26DBEBFF-BAF1-4B88-A84A-25E87D8B2878", // XML ID 
        "Prepare_a_quote_", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 5     
    ///////////////////////////////      
    ChildrenOptim[5] = ["sid-3F444730-08E2-48A9-9ED6-94CD055E7081"];
    ParentsOptim[5] = ["sid-D4074E68-AAAB-4AEC-8B09-510C359DE279"];
    addActivity(
        5,  //activity id
        NodeType.TASK, // activity type 
        "sid-DF6303CA-8443-4ECF-A070-A96028072AC4", // XML ID 
        "Insurance_plan_details_attached_to_the_quote", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 6     
    ///////////////////////////////      
    ChildrenOptim[6] = ["sid-DF6303CA-8443-4ECF-A070-A96028072AC4"];
    ParentsOptim[6] = ["Condition_3DAA1F9-D5D3-4515-BD40-AB126E856AEC"];
    addActivity(
        6,  //activity id
        NodeType.TASK, // activity type 
        "sid-D4074E68-AAAB-4AEC-8B09-510C359DE279", // XML ID 
        "Retrieve_customer_insurance_plan", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 7     
    ///////////////////////////////      
    ChildrenOptim[7] = ["sid-B915E66B-6811-4406-A33C-7F0E2923CD9F"];
    ParentsOptim[7] = ["Event_1530wd4"];
    addActivity(
        7,  //activity id
        NodeType.TASK, // activity type 
        "sid-0A783647-344C-4AC5-8D30-AC00C1181224", // XML ID 
        "Order_confirmation_received_from_r1", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 8     
    ///////////////////////////////      
    ChildrenOptim[8] = ["sid-BFC65806-6E59-4214-9EC7-D04DA15AE984"];
    ParentsOptim[8] = ["Condition_3055635-5895-4F6A-8DE6-618CB6D7C64C"];
    MsgOutOptim[8]= ["Event_0b674ab"];
    addActivity(
        8,  //activity id
        NodeType.TASK, // activity type 
        "sid-89022631-89C6-467D-BB16-93E55E5B2898", // XML ID 
        "Contact_external_garage", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 9     
    ///////////////////////////////      
    ChildrenOptim[9] = ["Event_0qzsgvi"];
    ParentsOptim[9] = ["sid-89022631-89C6-467D-BB16-93E55E5B2898"];
    MsgOutOptim[9]= ["sid-6C5A9378-E3D8-4D49-81A0-B71FC4B6492E"];
    addActivity(
        9,  //activity id
        NodeType.TASK, // activity type 
        "sid-BFC65806-6E59-4214-9EC7-D04DA15AE984", // XML ID 
        "Forwards_the_confirmation_to_the_customer_", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 10     
    ///////////////////////////////      
    ChildrenOptim[10] = ["sid-0366512C-CB64-4B12-A56C-E623E06C97B1"];
    ParentsOptim[10] = ["sid-7704547D-4E32-4F5A-920E-985CF15FB582"];
    addActivity(
        10,  //activity id
        NodeType.TASK, // activity type 
        "sid-F02C51E9-19F2-4894-A39B-D19DC81D36F8", // XML ID 
        "Send_cancellation_notification_", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 11     
    ///////////////////////////////      
    ChildrenOptim[11] = ["sid-F02C51E9-19F2-4894-A39B-D19DC81D36F8"];
    ParentsOptim[11] = ["Event_0x8291w"];
    addActivity(
        11,  //activity id
        NodeType.TASK, // activity type 
        "sid-7704547D-4E32-4F5A-920E-985CF15FB582", // XML ID 
        "Work_cancellation", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 12     
    ///////////////////////////////      
    ChildrenOptim[12] = ["sid-77979638-4CF5-448A-95E7-D5C9D579DC00", "sid-77979638-4CF5-448A-95E7-D5C9D579DC00"];
    ParentsOptim[12] = ["Event_04qux99"];
    addActivity(
        12,  //activity id
        NodeType.TASK, // activity type 
        "sid-3C1431D5-D732-4A23-BD90-DF64321C99CF", // XML ID 
        "Stock_analysis", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 13     
    ///////////////////////////////      
    ChildrenOptim[13] = ["sid-B915E66B-6811-4406-A33C-7F0E2923CD9F"];
    ParentsOptim[13] = ["sid-ACCB2512-67F5-418E-9081-E0AA01D56A90"];
    addActivity(
        13,  //activity id
        NodeType.TASK, // activity type 
        "sid-BF16C5DA-FEA1-43EB-A526-0BB72D75C122", // XML ID 
        "Order_confirmation_received_from_r2", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 14     
    ///////////////////////////////      
    ChildrenOptim[14] = ["Event_0bh4j1g"];
    ParentsOptim[14] = ["Event_1gzm7ak"];
    MsgOutOptim[14]= ["sid-ACCB2512-67F5-418E-9081-E0AA01D56A90"];
    addActivity(
        14,  //activity id
        NodeType.TASK, // activity type 
        "sid-390CE8A8-D57E-46C1-ABE3-33FD39AFE182", // XML ID 
        "Send_order_confirmation_r2", // activity name 
        "Second reseller", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 15     
    ///////////////////////////////      
    ChildrenOptim[15] = ["Gateway_19n65nc"];
    ParentsOptim[15] = ["Event_0b674ab"];
    addActivity(
        15,  //activity id
        NodeType.TASK, // activity type 
        "sid-E6B050B6-FC0C-4026-953E-6FF89C52CC0E", // XML ID 
        "Send_confirmation_of_appointment_", // activity name 
        "External garage", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 16     
    ///////////////////////////////      
    ChildrenOptim[16] = ["sid-47441335-A92F-4B95-999B-5A0FCDFEE072"];
    MsgInOptim[16]= ["sid-3F444730-08E2-48A9-9ED6-94CD055E7081"];
    addActivity(
        16,  //activity id
        NodeType.MSG_START, // activity type 
        "Event_0cypz96", // XML ID 
        "Receive the quote", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 17     
    ///////////////////////////////      
    ChildrenOptim[17] = ["sid-9278779F-D64C-44A8-BB23-342FD885198D"];
    addActivity(
        17,  //activity id
        NodeType.START, // activity type 
        "Event_1vttjvz", // XML ID 
        "Request for maintenance order received", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 18     
    ///////////////////////////////      
    ChildrenOptim[18] = ["Event_13rfpwt"];
    MsgInOptim[18]= ["Event_05emvq3"];
    addActivity(
        18,  //activity id
        NodeType.MSG_START, // activity type 
        "Event_1m9uzy4", // XML ID 
        "", // activity name 
        "Certified reseller", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 19     
    ///////////////////////////////      
    ChildrenOptim[19] = ["sid-390CE8A8-D57E-46C1-ABE3-33FD39AFE182"];
    MsgInOptim[19]= ["Event_1t0unw5"];
    addActivity(
        19,  //activity id
        NodeType.MSG_START, // activity type 
        "Event_1gzm7ak", // XML ID 
        "", // activity name 
        "Second reseller", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 20     
    ///////////////////////////////      
    ChildrenOptim[20] = ["sid-E6B050B6-FC0C-4026-953E-6FF89C52CC0E"];
    MsgInOptim[20]= ["sid-89022631-89C6-467D-BB16-93E55E5B2898"];
    addActivity(
        20,  //activity id
        NodeType.MSG_START, // activity type 
        "Event_0b674ab", // XML ID 
        "", // activity name 
        "External garage", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 21     
    ///////////////////////////////      
    ChildrenOptim[21] = ["Gateway_05goyjb"];
    ParentsOptim[21] = ["Condition_9BB7823-1380-4C03-A55B-7D7744C95469"];
    MsgOutOptim[21]= ["Event_04qux99"];
    addActivity(
        21,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0g6levg", // XML ID 
        "Send notification of acceptance", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 22     
    ///////////////////////////////      
    ChildrenOptim[22] = ["Gateway_1qmcawv"];
    ParentsOptim[22] = ["sid-DF6303CA-8443-4ECF-A070-A96028072AC4"];
    MsgOutOptim[22]= ["Event_0cypz96"];
    addActivity(
        22,  //activity id
        NodeType.EVENT, // activity type 
        "sid-3F444730-08E2-48A9-9ED6-94CD055E7081", // XML ID 
        "Quote sending", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 23     
    ///////////////////////////////      
    ChildrenOptim[23] = ["Gateway_1ohw6cn"];
    ParentsOptim[23] = ["Gateway_15t1v1j"];
    MsgOutOptim[23]= ["Event_1gzm7ak"];
    addActivity(
        23,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1t0unw5", // XML ID 
        "Contact a second reseller", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 24     
    ///////////////////////////////      
    ParentsOptim[24] = ["Condition_21432F4-0645-474A-9B1D-C2A270B93532"];
    MsgOutOptim[24]= ["sid-6C5A9378-E3D8-4D49-81A0-B71FC4B6492E"];
    addActivity(
        24,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0es4leg", // XML ID 
        "Scheduling an appointment", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 25     
    ///////////////////////////////      
    ChildrenOptim[25] = ["Gateway_15t1v1j"];
    ParentsOptim[25] = ["Condition_23D76E5-1D5E-4F27-B8BA-F62297E5AF7B"];
    MsgOutOptim[25]= ["Event_1m9uzy4"];
    addActivity(
        25,  //activity id
        NodeType.EVENT, // activity type 
        "Event_05emvq3", // XML ID 
        "Contact certified reseller", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 26     
    ///////////////////////////////      
    ChildrenOptim[26] = ["Event_1cwbv97"];
    ParentsOptim[26] = ["Gateway_1ohw6cn"];
    MsgOutOptim[26]= ["Event_0mf230p"];
    addActivity(
        26,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1qkl7ya", // XML ID 
        "Contact customer of the non availability", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 27     
    ///////////////////////////////      
    ChildrenOptim[27] = ["Event_12tyx2p"];
    ParentsOptim[27] = ["Event_1m9uzy4"];
    MsgOutOptim[27]= ["Event_1530wd4"];
    addActivity(
        27,  //activity id
        NodeType.EVENT, // activity type 
        "Event_13rfpwt", // XML ID 
        "Send order confirmation r1", // activity name 
        "Certified reseller", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 28     
    ///////////////////////////////      
    ChildrenOptim[28] = ["Event_00790yn"];
    ParentsOptim[28] = ["Gateway_05goyjb"];
    MsgInOptim[28]= ["Event_1qkl7ya"];
    addActivity(
        28,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0mf230p", // XML ID 
        "parts are not available", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 29     
    ///////////////////////////////      
    ChildrenOptim[29] = ["sid-65720A2A-2794-4BD3-B673-5E38D0A4D4E1"];
    ParentsOptim[29] = ["Gateway_05goyjb"];
    MsgInOptim[29]= ["sid-BFC65806-6E59-4214-9EC7-D04DA15AE984", "Event_0es4leg"];
    addActivity(
        29,  //activity id
        NodeType.EVENT, // activity type 
        "sid-6C5A9378-E3D8-4D49-81A0-B71FC4B6492E", // XML ID 
        "", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 30     
    ///////////////////////////////      
    ChildrenOptim[30] = ["Event_1l7rkx3"];
    ParentsOptim[30] = ["Gateway_1qmcawv"];
    MsgInOptim[30]= ["sid-0CB445C7-AA60-4DCC-8FFF-4DF194FD5472"];
    addActivity(
        30,  //activity id
        NodeType.EVENT, // activity type 
        "Event_052hy0v", // XML ID 
        "ko", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 31     
    ///////////////////////////////      
    ChildrenOptim[31] = ["sid-0A783647-344C-4AC5-8D30-AC00C1181224"];
    ParentsOptim[31] = ["Gateway_15t1v1j"];
    MsgInOptim[31]= ["Event_13rfpwt"];
    addActivity(
        31,  //activity id
        NodeType.EVENT, // activity type 
        "Event_1530wd4", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 32     
    ///////////////////////////////      
    ChildrenOptim[32] = ["sid-BF16C5DA-FEA1-43EB-A526-0BB72D75C122"];
    ParentsOptim[32] = ["Gateway_1ohw6cn"];
    MsgInOptim[32]= ["sid-390CE8A8-D57E-46C1-ABE3-33FD39AFE182"];
    addActivity(
        32,  //activity id
        NodeType.EVENT, // activity type 
        "sid-ACCB2512-67F5-418E-9081-E0AA01D56A90", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 33     
    ///////////////////////////////      
    ChildrenOptim[33] = ["sid-7704547D-4E32-4F5A-920E-985CF15FB582"];
    MsgInOptim[33]= ["Activity_0esk4hs"];
    addActivity(
        33,  //activity id
        NodeType.EVENT, // activity type 
        "Event_0x8291w", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 34     
    ///////////////////////////////      
    ChildrenOptim[34] = ["sid-3C1431D5-D732-4A23-BD90-DF64321C99CF"];
    ParentsOptim[34] = ["Gateway_1qmcawv"];
    MsgInOptim[34]= ["Event_0g6levg"];
    addActivity(
        34,  //activity id
        NodeType.EVENT, // activity type 
        "Event_04qux99", // XML ID 
        "Notification received", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 35     
    ///////////////////////////////      
    ChildrenOptim[35] = ["Event_0imfgrp"];
    ParentsOptim[35] = ["Condition_BFB90FA-99AA-4D96-83E3-D4FD8C0C3E8F"];
    MsgInOptim[35]= ["sid-0366512C-CB64-4B12-A56C-E623E06C97B1"];
    addActivity(
        35,  //activity id
        NodeType.EVENT, // activity type 
        "sid-7E1D3389-B269-4246-A85D-84B4CB516943", // XML ID 
        "", // activity name 
        "External garage", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 36     
    ///////////////////////////////      
    ParentsOptim[36] = ["Condition_7D9AF68-B779-44EE-B382-084542D262C9"];
    MsgOutOptim[36]= ["Event_052hy0v"];
    addActivity(
        36,  //activity id
        NodeType.END, // activity type 
        "sid-0CB445C7-AA60-4DCC-8FFF-4DF194FD5472", // XML ID 
        "Reject notification", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 37     
    ///////////////////////////////      
    ParentsOptim[37] = ["Event_0mf230p"];
    addActivity(
        37,  //activity id
        NodeType.END, // activity type 
        "Event_00790yn", // XML ID 
        "", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 38     
    ///////////////////////////////      
    ParentsOptim[38] = ["sid-5D8D22A7-1742-4EA1-B8AA-77860774A62E"];
    addActivity(
        38,  //activity id
        NodeType.END, // activity type 
        "sid-9FD79319-1B71-4B25-94D0-C1C0BC04417B", // XML ID 
        "Work order fulfilled", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 39     
    ///////////////////////////////      
    ParentsOptim[39] = ["Activity_0esk4hs"];
    addActivity(
        39,  //activity id
        NodeType.END, // activity type 
        "Event_0vjtkcs", // XML ID 
        "", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 40     
    ///////////////////////////////      
    ParentsOptim[40] = ["Condition_276F0AA-0B47-4821-8B9A-2265D233D78E"];
    addActivity(
        40,  //activity id
        NodeType.END, // activity type 
        "sid-2F7756D4-C9F8-4FB6-94D6-B59750DFA0A5", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 41     
    ///////////////////////////////      
    ParentsOptim[41] = ["Event_052hy0v"];
    addActivity(
        41,  //activity id
        NodeType.END, // activity type 
        "Event_1l7rkx3", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 42     
    ///////////////////////////////      
    ParentsOptim[42] = ["Event_1qkl7ya"];
    addActivity(
        42,  //activity id
        NodeType.END, // activity type 
        "Event_1cwbv97", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 43     
    ///////////////////////////////      
    ParentsOptim[43] = ["sid-BFC65806-6E59-4214-9EC7-D04DA15AE984"];
    addActivity(
        43,  //activity id
        NodeType.END, // activity type 
        "Event_0qzsgvi", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 44     
    ///////////////////////////////      
    ParentsOptim[44] = ["sid-F02C51E9-19F2-4894-A39B-D19DC81D36F8"];
    MsgOutOptim[44]= ["sid-7E1D3389-B269-4246-A85D-84B4CB516943"];
    addActivity(
        44,  //activity id
        NodeType.END, // activity type 
        "sid-0366512C-CB64-4B12-A56C-E623E06C97B1", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 45     
    ///////////////////////////////      
    ParentsOptim[45] = ["Event_13rfpwt"];
    addActivity(
        45,  //activity id
        NodeType.END, // activity type 
        "Event_12tyx2p", // XML ID 
        "", // activity name 
        "Certified reseller", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 46     
    ///////////////////////////////      
    ParentsOptim[46] = ["sid-390CE8A8-D57E-46C1-ABE3-33FD39AFE182"];
    addActivity(
        46,  //activity id
        NodeType.END, // activity type 
        "Event_0bh4j1g", // XML ID 
        "", // activity name 
        "Second reseller", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 47     
    ///////////////////////////////      
    ParentsOptim[47] = ["Gateway_19n65nc"];
    addActivity(
        47,  //activity id
        NodeType.END, // activity type 
        "Event_08v14sc", // XML ID 
        "", // activity name 
        "External garage", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 48     
    ///////////////////////////////      
    ParentsOptim[48] = ["sid-7E1D3389-B269-4246-A85D-84B4CB516943"];
    addActivity(
        48,  //activity id
        NodeType.END, // activity type 
        "Event_0imfgrp", // XML ID 
        "", // activity name 
        "External garage", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 49     
    ///////////////////////////////      
    ChildrenOptim[49] = ["Condition_9BB7823-1380-4C03-A55B-7D7744C95469", "Condition_7D9AF68-B779-44EE-B382-084542D262C9"];
    ParentsOptim[49] = ["sid-47441335-A92F-4B95-999B-5A0FCDFEE072"];
    addActivity(
        49,  //activity id
        NodeType.XOR, // activity type 
        "sid-AA3FD24D-6A11-48C3-AA58-8ED61F07FCF2", // XML ID 
        "Acceptance?", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 50     
    ///////////////////////////////      
    ChildrenOptim[50] = ["Event_0mf230p", "sid-6C5A9378-E3D8-4D49-81A0-B71FC4B6492E"];
    ParentsOptim[50] = ["Event_0g6levg"];
    addActivity(
        50,  //activity id
        NodeType.XOR, // activity type 
        "Gateway_05goyjb", // XML ID 
        "", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 51     
    ///////////////////////////////      
    ChildrenOptim[51] = ["Condition_25F9785-235F-4BA8-8D3F-3854798E6EF0", "Activity_0esk4hs"];
    ParentsOptim[51] = ["sid-6C5A9378-E3D8-4D49-81A0-B71FC4B6492E"];
    addActivity(
        51,  //activity id
        NodeType.XOR, // activity type 
        "sid-65720A2A-2794-4BD3-B673-5E38D0A4D4E1", // XML ID 
        "", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 52     
    ///////////////////////////////      
    ChildrenOptim[52] = ["Condition_3DAA1F9-D5D3-4515-BD40-AB126E856AEC", "Condition_276F0AA-0B47-4821-8B9A-2265D233D78E"];
    ParentsOptim[52] = ["sid-26DBEBFF-BAF1-4B88-A84A-25E87D8B2878"];
    addActivity(
        52,  //activity id
        NodeType.XOR, // activity type 
        "sid-B7D6978C-9985-4CE9-9D8F-5884DE9B75BE", // XML ID 
        "Insurance? ", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 53     
    ///////////////////////////////      
    ChildrenOptim[53] = ["Event_052hy0v", "Event_04qux99"];
    ParentsOptim[53] = ["sid-3F444730-08E2-48A9-9ED6-94CD055E7081"];
    addActivity(
        53,  //activity id
        NodeType.XOR, // activity type 
        "Gateway_1qmcawv", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 54     
    ///////////////////////////////      
    ChildrenOptim[54] = ["Condition_21432F4-0645-474A-9B1D-C2A270B93532", "Condition_23D76E5-1D5E-4F27-B8BA-F62297E5AF7B"];
    ParentsOptim[54] = ["sid-3C1431D5-D732-4A23-BD90-DF64321C99CF", "sid-3C1431D5-D732-4A23-BD90-DF64321C99CF"];
    addActivity(
        54,  //activity id
        NodeType.XOR, // activity type 
        "sid-77979638-4CF5-448A-95E7-D5C9D579DC00", // XML ID 
        "Stock?", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 55     
    ///////////////////////////////      
    ChildrenOptim[55] = ["Event_1qkl7ya", "sid-ACCB2512-67F5-418E-9081-E0AA01D56A90"];
    ParentsOptim[55] = ["Event_1t0unw5"];
    addActivity(
        55,  //activity id
        NodeType.XOR, // activity type 
        "Gateway_1ohw6cn", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 56     
    ///////////////////////////////      
    ChildrenOptim[56] = ["Condition_3055635-5895-4F6A-8DE6-618CB6D7C64C"];
    ParentsOptim[56] = ["sid-0A783647-344C-4AC5-8D30-AC00C1181224", "sid-BF16C5DA-FEA1-43EB-A526-0BB72D75C122"];
    addActivity(
        56,  //activity id
        NodeType.XOR, // activity type 
        "sid-B915E66B-6811-4406-A33C-7F0E2923CD9F", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 57     
    ///////////////////////////////      
    ChildrenOptim[57] = ["Event_1t0unw5", "Event_1530wd4"];
    ParentsOptim[57] = ["Event_05emvq3"];
    addActivity(
        57,  //activity id
        NodeType.XOR, // activity type 
        "Gateway_15t1v1j", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 58     
    ///////////////////////////////      
    ChildrenOptim[58] = ["Condition_BFB90FA-99AA-4D96-83E3-D4FD8C0C3E8F", "Event_08v14sc"];
    ParentsOptim[58] = ["sid-E6B050B6-FC0C-4026-953E-6FF89C52CC0E"];
    addActivity(
        58,  //activity id
        NodeType.XOR, // activity type 
        "Gateway_19n65nc", // XML ID 
        "", // activity name 
        "External garage", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 59     
    ///////////////////////////////      
    ChildrenOptim[59] = ["Event_0g6levg"];
    ParentsOptim[59] = ["sid-AA3FD24D-6A11-48C3-AA58-8ED61F07FCF2"];
    addActivity(
        59,  //activity id
        NodeType.TASK, // activity type 
        "Condition_9BB7823-1380-4C03-A55B-7D7744C95469", // XML ID 
        "Yes", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 60     
    ///////////////////////////////      
    ChildrenOptim[60] = ["sid-0CB445C7-AA60-4DCC-8FFF-4DF194FD5472"];
    ParentsOptim[60] = ["sid-AA3FD24D-6A11-48C3-AA58-8ED61F07FCF2"];
    addActivity(
        60,  //activity id
        NodeType.TASK, // activity type 
        "Condition_7D9AF68-B779-44EE-B382-084542D262C9", // XML ID 
        "No", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 61     
    ///////////////////////////////      
    ChildrenOptim[61] = ["sid-5D8D22A7-1742-4EA1-B8AA-77860774A62E"];
    ParentsOptim[61] = ["sid-65720A2A-2794-4BD3-B673-5E38D0A4D4E1"];
    addActivity(
        61,  //activity id
        NodeType.TASK, // activity type 
        "Condition_25F9785-235F-4BA8-8D3F-3854798E6EF0", // XML ID 
        "Yes", // activity name 
        "Customer", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 62     
    ///////////////////////////////      
    ChildrenOptim[62] = ["sid-D4074E68-AAAB-4AEC-8B09-510C359DE279"];
    ParentsOptim[62] = ["sid-B7D6978C-9985-4CE9-9D8F-5884DE9B75BE"];
    addActivity(
        62,  //activity id
        NodeType.TASK, // activity type 
        "Condition_3DAA1F9-D5D3-4515-BD40-AB126E856AEC", // XML ID 
        "Yes", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 63     
    ///////////////////////////////      
    ChildrenOptim[63] = ["sid-2F7756D4-C9F8-4FB6-94D6-B59750DFA0A5"];
    ParentsOptim[63] = ["sid-B7D6978C-9985-4CE9-9D8F-5884DE9B75BE"];
    addActivity(
        63,  //activity id
        NodeType.TASK, // activity type 
        "Condition_276F0AA-0B47-4821-8B9A-2265D233D78E", // XML ID 
        "No ", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 64     
    ///////////////////////////////      
    ChildrenOptim[64] = ["Event_0es4leg"];
    ParentsOptim[64] = ["sid-77979638-4CF5-448A-95E7-D5C9D579DC00"];
    addActivity(
        64,  //activity id
        NodeType.TASK, // activity type 
        "Condition_21432F4-0645-474A-9B1D-C2A270B93532", // XML ID 
        "Yes", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 65     
    ///////////////////////////////      
    ChildrenOptim[65] = ["Event_05emvq3"];
    ParentsOptim[65] = ["sid-77979638-4CF5-448A-95E7-D5C9D579DC00"];
    addActivity(
        65,  //activity id
        NodeType.TASK, // activity type 
        "Condition_23D76E5-1D5E-4F27-B8BA-F62297E5AF7B", // XML ID 
        "No", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 66     
    ///////////////////////////////      
    ChildrenOptim[66] = ["sid-89022631-89C6-467D-BB16-93E55E5B2898"];
    ParentsOptim[66] = ["sid-B915E66B-6811-4406-A33C-7F0E2923CD9F"];
    addActivity(
        66,  //activity id
        NodeType.TASK, // activity type 
        "Condition_3055635-5895-4F6A-8DE6-618CB6D7C64C", // XML ID 
        "", // activity name 
        "SPARKS", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 67     
    ///////////////////////////////      
    ChildrenOptim[67] = ["sid-7E1D3389-B269-4246-A85D-84B4CB516943"];
    ParentsOptim[67] = ["Gateway_19n65nc"];
    addActivity(
        67,  //activity id
        NodeType.TASK, // activity type 
        "Condition_BFB90FA-99AA-4D96-83E3-D4FD8C0C3E8F", // XML ID 
        "", // activity name 
        "External garage", //lane
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
