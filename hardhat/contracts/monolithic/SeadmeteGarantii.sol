// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;
contract SeadmeteGarantii{
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
    addWorkflowInstance("myContract",41);
    markings_included = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]; // flow arcs assigned with a sequential index (included/pending/done)
    markings_executed = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    markings_pending = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    //________________________________________ Populate activities ___________________________//    
    ///////////////////////////////      
    //====> Populate activity 0     
    ///////////////////////////////      
    ChildrenOptim[0] = ["sid-DAB5F507-EFF9-47EF-8321-F9C2F5FA0C0F"];
    ParentsOptim[0] = ["sid-1B7E9696-9C54-40E8-8B9A-870A0ABDF635"];
    addActivity(
        0,  //activity id
        NodeType.TASK, // activity type 
        "sid-1CD046B2-F1DE-4E72-B186-DF757F0F0C04", // XML ID 
        "Toimetab_seadme_tookojajuhataja_katte", // activity name 
        "Laojuhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 1     
    ///////////////////////////////      
    ChildrenOptim[1] = ["sid-E2D50642-1DA9-48B4-A1AB-551FE2F59C63"];
    ParentsOptim[1] = ["sid-BE0732BC-5BFA-4BEA-AA19-733D3FAAB241"];
    addActivity(
        1,  //activity id
        NodeType.TASK, // activity type 
        "sid-879120B8-4CD9-4C47-82E3-EFB91447D38D", // XML ID 
        "Tellib_transpordi_tootja_remondikeskusesse", // activity name 
        "Laojuhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 2     
    ///////////////////////////////      
    ChildrenOptim[2] = ["sid-543E867B-FE95-422E-A25E-E8584400AA70"];
    ParentsOptim[2] = ["Condition_3F394B5-24A3-41B2-A70A-FEDED8168106"];
    addActivity(
        2,  //activity id
        NodeType.TASK, // activity type 
        "sid-EB69579C-EF16-4414-BC8C-1F1B7F20005B", // XML ID 
        "Saadab_seadme_kulleriga_valja", // activity name 
        "Laojuhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 3     
    ///////////////////////////////      
    ChildrenOptim[3] = ["sid-164C0EFF-2B9A-4893-B2DB-325C55891720"];
    ParentsOptim[3] = ["sid-40098927-352B-4CDF-A6BC-55107978D3C7", "sid-2CFB401F-E8DA-4C44-BAF1-32D4E5EC0D58"];
    addActivity(
        3,  //activity id
        NodeType.TASK, // activity type 
        "sid-B3AE24CC-FFE6-4592-9C39-728CC9A45341", // XML ID 
        "Vatab_seadme_vastu_lattu", // activity name 
        "Laojuhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 4     
    ///////////////////////////////      
    ChildrenOptim[4] = ["sid-84B5CB3C-E7CB-40E6-B5EA-6DE12F949FAA"];
    ParentsOptim[4] = ["Condition_90B21C2-FB72-497F-B41A-AB6EE3E4B854", "Condition_41A5BBA-BBB0-454E-A947-65B55036C5E1"];
    addActivity(
        4,  //activity id
        NodeType.TASK, // activity type 
        "sid-655BCB50-6C40-4142-BAA1-261489F4548A", // XML ID 
        "Registreerib_seadme_tootja_juurde__saadetud_seadmete_andmebaasi", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 5     
    ///////////////////////////////      
    ChildrenOptim[5] = ["sid-03F6742B-9635-4069-8FCD-E0C301A5FF0C"];
    ParentsOptim[5] = ["sid-1CD046B2-F1DE-4E72-B186-DF757F0F0C04", "sid-309BFA47-2018-486B-A2C6-720AC2FC87B4"];
    addActivity(
        5,  //activity id
        NodeType.TASK, // activity type 
        "sid-DAB5F507-EFF9-47EF-8321-F9C2F5FA0C0F", // XML ID 
        "Hindab_kas_seadet_on_vaimalik_remontida_Hansabis", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 6     
    ///////////////////////////////      
    ChildrenOptim[6] = ["sid-879120B8-4CD9-4C47-82E3-EFB91447D38D"];
    ParentsOptim[6] = ["Condition_348E072-F751-4739-A396-5FAB93B42FFF", "sid-F8690217-2307-40A5-A61E-3EF5F39B9CAE"];
    addActivity(
        6,  //activity id
        NodeType.TASK, // activity type 
        "sid-BE0732BC-5BFA-4BEA-AA19-733D3FAAB241", // XML ID 
        "Vormistab_saatedokumendid", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 7     
    ///////////////////////////////      
    ChildrenOptim[7] = ["sid-55897027-E46C-468A-A5BD-625512853329"];
    ParentsOptim[7] = ["sid-879120B8-4CD9-4C47-82E3-EFB91447D38D"];
    addActivity(
        7,  //activity id
        NodeType.TASK, // activity type 
        "sid-E2D50642-1DA9-48B4-A1AB-551FE2F59C63", // XML ID 
        "Pakib_kauba_ja_saadab_valja", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 8     
    ///////////////////////////////      
    ChildrenOptim[8] = ["sid-5347D7F1-610B-4CC3-AEC1-1F94454397F5"];
    ParentsOptim[8] = ["sid-164C0EFF-2B9A-4893-B2DB-325C55891720"];
    addActivity(
        8,  //activity id
        NodeType.TASK, // activity type 
        "sid-D4E6D16E-D0F4-4473-A4DD-829ECF1655EE", // XML ID 
        "Annab_klienditoe_spetsilistile_teada_remonditud_seadmest", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 9     
    ///////////////////////////////      
    ChildrenOptim[9] = ["sid-D4E6D16E-D0F4-4473-A4DD-829ECF1655EE"];
    ParentsOptim[9] = ["sid-B3AE24CC-FFE6-4592-9C39-728CC9A45341"];
    addActivity(
        9,  //activity id
        NodeType.TASK, // activity type 
        "sid-164C0EFF-2B9A-4893-B2DB-325C55891720", // XML ID 
        "Registreerib_seadme_saabumise_ja_tuvastab_millisel_viisil_on_seade_Hansabisse_toodud", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 10     
    ///////////////////////////////      
    ChildrenOptim[10] = ["sid-543E867B-FE95-422E-A25E-E8584400AA70"];
    ParentsOptim[10] = ["Condition_FD26262-9A3E-4D10-9723-8F8237AE66F5"];
    addActivity(
        10,  //activity id
        NodeType.TASK, // activity type 
        "sid-DDC5F833-4DD6-43FE-BAD7-5AD7F891F5E2", // XML ID 
        "Annab_seadme_tehnikule", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 11     
    ///////////////////////////////      
    ChildrenOptim[11] = ["sid-E28CC810-DB0D-413D-A0FE-5FDA0394BBAA"];
    ParentsOptim[11] = ["Condition_00D722A-78BF-41B8-AF7A-02A9F3F6EFCB", "sid-65765301-4B25-4C76-9535-DECCF4C3EA79"];
    addActivity(
        11,  //activity id
        NodeType.TASK, // activity type 
        "sid-AB73CCD4-7D6C-4872-B5B3-BEAEF0965FB3", // XML ID 
        "Vatab_seadme_vastu_ja_tuvastab_rikke", // activity name 
        "Remonditehnik", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 12     
    ///////////////////////////////      
    ChildrenOptim[12] = ["sid-B32A0916-B0A5-4EC8-BB34-46054FE3C97F"];
    ParentsOptim[12] = ["Condition_68632E2-1250-41B3-9F3E-02008D14A7BE"];
    addActivity(
        12,  //activity id
        NodeType.TASK, // activity type 
        "sid-A0412598-4D5B-45B5-9292-0409BE89EFFC", // XML ID 
        "Remondib_seadme", // activity name 
        "Remonditehnik", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 13     
    ///////////////////////////////      
    ChildrenOptim[13] = ["sid-B3AE24CC-FFE6-4592-9C39-728CC9A45341"];
    ParentsOptim[13] = ["sid-249307F2-98C5-452E-9248-5DE68862F557"];
    addActivity(
        13,  //activity id
        NodeType.TASK, // activity type 
        "sid-40098927-352B-4CDF-A6BC-55107978D3C7", // XML ID 
        "Viib_remonditud_seadme_lattu", // activity name 
        "Remonditehnik", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 14     
    ///////////////////////////////      
    ChildrenOptim[14] = ["sid-E9F66E5F-B46A-4CF4-858E-D438D9824F2C"];
    ParentsOptim[14] = ["Condition_8F3D20F-DA3A-4B86-9755-23D4C3E551D9"];
    addActivity(
        14,  //activity id
        NodeType.TASK, // activity type 
        "sid-5DA39FA5-564C-4864-9B45-9BB81CE08961", // XML ID 
        "Viib_remonditud_seadme_assistendi_juurde", // activity name 
        "Remonditehnik", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 15     
    ///////////////////////////////      
    ChildrenOptim[15] = ["sid-40098927-352B-4CDF-A6BC-55107978D3C7"];
    ParentsOptim[15] = ["Condition_21061BE-11E3-4127-91AA-DBDBD94A3AB1"];
    addActivity(
        15,  //activity id
        NodeType.TASK, // activity type 
        "sid-249307F2-98C5-452E-9248-5DE68862F557", // XML ID 
        "Informeerib_klientoe_spetsialisti", // activity name 
        "Remonditehnik", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 16     
    ///////////////////////////////      
    ChildrenOptim[16] = ["sid-BE0732BC-5BFA-4BEA-AA19-733D3FAAB241"];
    ParentsOptim[16] = ["Condition_ED57E10-FA75-4C28-8B13-627C2B6EC7AF"];
    addActivity(
        16,  //activity id
        NodeType.TASK, // activity type 
        "sid-F8690217-2307-40A5-A61E-3EF5F39B9CAE", // XML ID 
        "Selgitab_valja_tootja_kontakti", // activity name 
        "Muugijuht", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 17     
    ///////////////////////////////      
    ChildrenOptim[17] = ["sid-AB73CCD4-7D6C-4872-B5B3-BEAEF0965FB3"];
    ParentsOptim[17] = ["sid-17AA4693-C3E0-4D0D-9463-D7BE82CAC7EA"];
    addActivity(
        17,  //activity id
        NodeType.TASK, // activity type 
        "sid-65765301-4B25-4C76-9535-DECCF4C3EA79", // XML ID 
        "Registreerib_tellimuse_ja_vatab_seadme_vastu", // activity name 
        "Assistent", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 18     
    ///////////////////////////////      
    ChildrenOptim[18] = ["sid-B53B9E38-A94C-407F-BCFE-B94AD9028F01"];
    ParentsOptim[18] = ["sid-5DA39FA5-564C-4864-9B45-9BB81CE08961"];
    addActivity(
        18,  //activity id
        NodeType.TASK, // activity type 
        "sid-E9F66E5F-B46A-4CF4-858E-D438D9824F2C", // XML ID 
        "Annab_kliendile_seadme_ule", // activity name 
        "Assistent", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 19     
    ///////////////////////////////      
    ChildrenOptim[19] = ["sid-2CFB401F-E8DA-4C44-BAF1-32D4E5EC0D58"];
    ParentsOptim[19] = ["sid-E2D50642-1DA9-48B4-A1AB-551FE2F59C63"];
    addActivity(
        19,  //activity id
        NodeType.TASK, // activity type 
        "sid-55897027-E46C-468A-A5BD-625512853329", // XML ID 
        "Vatab_seadme_vastu_ja_alustab_remonti", // activity name 
        "Tootja remondikeskus", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 20     
    ///////////////////////////////      
    ChildrenOptim[20] = ["sid-B3AE24CC-FFE6-4592-9C39-728CC9A45341"];
    ParentsOptim[20] = ["sid-55897027-E46C-468A-A5BD-625512853329"];
    addActivity(
        20,  //activity id
        NodeType.TASK, // activity type 
        "sid-2CFB401F-E8DA-4C44-BAF1-32D4E5EC0D58", // XML ID 
        "Saadab_seadme_tagasi_Hansabisse", // activity name 
        "Tootja remondikeskus", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 21     
    ///////////////////////////////      
    ChildrenOptim[21] = ["sid-1CD046B2-F1DE-4E72-B186-DF757F0F0C04"];
    addActivity(
        21,  //activity id
        NodeType.START, // activity type 
        "sid-1B7E9696-9C54-40E8-8B9A-870A0ABDF635", // XML ID 
        "Seade_saabubremonti_kulleriga", // activity name 
        "Laojuhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 22     
    ///////////////////////////////      
    ChildrenOptim[22] = ["sid-DAB5F507-EFF9-47EF-8321-F9C2F5FA0C0F"];
    addActivity(
        22,  //activity id
        NodeType.START, // activity type 
        "sid-309BFA47-2018-486B-A2C6-720AC2FC87B4", // XML ID 
        "Seade_tuuakse_remonti_otse_tookotta_Hansabi_tootaja_poolt", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 23     
    ///////////////////////////////      
    ChildrenOptim[23] = ["sid-65765301-4B25-4C76-9535-DECCF4C3EA79"];
    addActivity(
        23,  //activity id
        NodeType.START, // activity type 
        "sid-17AA4693-C3E0-4D0D-9463-D7BE82CAC7EA", // XML ID 
        "Seade_on_toodud_Hansabisse_kliendi_poolt", // activity name 
        "Assistent", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 24     
    ///////////////////////////////      
    ParentsOptim[24] = ["sid-EB69579C-EF16-4414-BC8C-1F1B7F20005B", "sid-DDC5F833-4DD6-43FE-BAD7-5AD7F891F5E2"];
    addActivity(
        24,  //activity id
        NodeType.END, // activity type 
        "sid-543E867B-FE95-422E-A25E-E8584400AA70", // XML ID 
        "Remonditud_seade_valjastatud", // activity name 
        "Laojuhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 25     
    ///////////////////////////////      
    ParentsOptim[25] = ["sid-E9F66E5F-B46A-4CF4-858E-D438D9824F2C"];
    addActivity(
        25,  //activity id
        NodeType.END, // activity type 
        "sid-B53B9E38-A94C-407F-BCFE-B94AD9028F01", // XML ID 
        "Klient_saab_remonditud_seadmele_katte", // activity name 
        "Assistent", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 26     
    ///////////////////////////////      
    ChildrenOptim[26] = ["Condition_90B21C2-FB72-497F-B41A-AB6EE3E4B854", "Condition_00D722A-78BF-41B8-AF7A-02A9F3F6EFCB"];
    ParentsOptim[26] = ["sid-DAB5F507-EFF9-47EF-8321-F9C2F5FA0C0F"];
    addActivity(
        26,  //activity id
        NodeType.XOR, // activity type 
        "sid-03F6742B-9635-4069-8FCD-E0C301A5FF0C", // XML ID 
        "", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 27     
    ///////////////////////////////      
    ChildrenOptim[27] = ["Condition_ED57E10-FA75-4C28-8B13-627C2B6EC7AF", "Condition_348E072-F751-4739-A396-5FAB93B42FFF"];
    ParentsOptim[27] = ["sid-655BCB50-6C40-4142-BAA1-261489F4548A"];
    addActivity(
        27,  //activity id
        NodeType.XOR, // activity type 
        "sid-84B5CB3C-E7CB-40E6-B5EA-6DE12F949FAA", // XML ID 
        "", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 28     
    ///////////////////////////////      
    ChildrenOptim[28] = ["Condition_3F394B5-24A3-41B2-A70A-FEDED8168106", "Condition_FD26262-9A3E-4D10-9723-8F8237AE66F5"];
    ParentsOptim[28] = ["sid-D4E6D16E-D0F4-4473-A4DD-829ECF1655EE"];
    addActivity(
        28,  //activity id
        NodeType.XOR, // activity type 
        "sid-5347D7F1-610B-4CC3-AEC1-1F94454397F5", // XML ID 
        "", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 29     
    ///////////////////////////////      
    ChildrenOptim[29] = ["Condition_41A5BBA-BBB0-454E-A947-65B55036C5E1", "Condition_68632E2-1250-41B3-9F3E-02008D14A7BE"];
    ParentsOptim[29] = ["sid-AB73CCD4-7D6C-4872-B5B3-BEAEF0965FB3"];
    addActivity(
        29,  //activity id
        NodeType.XOR, // activity type 
        "sid-E28CC810-DB0D-413D-A0FE-5FDA0394BBAA", // XML ID 
        "", // activity name 
        "Remonditehnik", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 30     
    ///////////////////////////////      
    ChildrenOptim[30] = ["Condition_8F3D20F-DA3A-4B86-9755-23D4C3E551D9", "Condition_21061BE-11E3-4127-91AA-DBDBD94A3AB1"];
    ParentsOptim[30] = ["sid-A0412598-4D5B-45B5-9292-0409BE89EFFC"];
    addActivity(
        30,  //activity id
        NodeType.XOR, // activity type 
        "sid-B32A0916-B0A5-4EC8-BB34-46054FE3C97F", // XML ID 
        "", // activity name 
        "Remonditehnik", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 31     
    ///////////////////////////////      
    ChildrenOptim[31] = ["sid-EB69579C-EF16-4414-BC8C-1F1B7F20005B"];
    ParentsOptim[31] = ["sid-5347D7F1-610B-4CC3-AEC1-1F94454397F5"];
    addActivity(
        31,  //activity id
        NodeType.TASK, // activity type 
        "Condition_3F394B5-24A3-41B2-A70A-FEDED8168106", // XML ID 
        "", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 32     
    ///////////////////////////////      
    ChildrenOptim[32] = ["sid-655BCB50-6C40-4142-BAA1-261489F4548A"];
    ParentsOptim[32] = ["sid-03F6742B-9635-4069-8FCD-E0C301A5FF0C"];
    addActivity(
        32,  //activity id
        NodeType.TASK, // activity type 
        "Condition_90B21C2-FB72-497F-B41A-AB6EE3E4B854", // XML ID 
        "", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 33     
    ///////////////////////////////      
    ChildrenOptim[33] = ["sid-AB73CCD4-7D6C-4872-B5B3-BEAEF0965FB3"];
    ParentsOptim[33] = ["sid-03F6742B-9635-4069-8FCD-E0C301A5FF0C"];
    addActivity(
        33,  //activity id
        NodeType.TASK, // activity type 
        "Condition_00D722A-78BF-41B8-AF7A-02A9F3F6EFCB", // XML ID 
        "", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 34     
    ///////////////////////////////      
    ChildrenOptim[34] = ["sid-DDC5F833-4DD6-43FE-BAD7-5AD7F891F5E2"];
    ParentsOptim[34] = ["sid-5347D7F1-610B-4CC3-AEC1-1F94454397F5"];
    addActivity(
        34,  //activity id
        NodeType.TASK, // activity type 
        "Condition_FD26262-9A3E-4D10-9723-8F8237AE66F5", // XML ID 
        "", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 35     
    ///////////////////////////////      
    ChildrenOptim[35] = ["sid-F8690217-2307-40A5-A61E-3EF5F39B9CAE"];
    ParentsOptim[35] = ["sid-84B5CB3C-E7CB-40E6-B5EA-6DE12F949FAA"];
    addActivity(
        35,  //activity id
        NodeType.TASK, // activity type 
        "Condition_ED57E10-FA75-4C28-8B13-627C2B6EC7AF", // XML ID 
        "Tootja_remonditingimused_ei_ole_teada", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 36     
    ///////////////////////////////      
    ChildrenOptim[36] = ["sid-BE0732BC-5BFA-4BEA-AA19-733D3FAAB241"];
    ParentsOptim[36] = ["sid-84B5CB3C-E7CB-40E6-B5EA-6DE12F949FAA"];
    addActivity(
        36,  //activity id
        NodeType.TASK, // activity type 
        "Condition_348E072-F751-4739-A396-5FAB93B42FFF", // XML ID 
        "Tootja_remonditingimused_on_teada", // activity name 
        "Tookoja juhataja", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 37     
    ///////////////////////////////      
    ChildrenOptim[37] = ["sid-655BCB50-6C40-4142-BAA1-261489F4548A"];
    ParentsOptim[37] = ["sid-E28CC810-DB0D-413D-A0FE-5FDA0394BBAA"];
    addActivity(
        37,  //activity id
        NodeType.TASK, // activity type 
        "Condition_41A5BBA-BBB0-454E-A947-65B55036C5E1", // XML ID 
        "Seade_on_vaja_saata_tootja_remondikeskusesse", // activity name 
        "Remonditehnik", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 38     
    ///////////////////////////////      
    ChildrenOptim[38] = ["sid-5DA39FA5-564C-4864-9B45-9BB81CE08961"];
    ParentsOptim[38] = ["sid-B32A0916-B0A5-4EC8-BB34-46054FE3C97F"];
    addActivity(
        38,  //activity id
        NodeType.TASK, // activity type 
        "Condition_8F3D20F-DA3A-4B86-9755-23D4C3E551D9", // XML ID 
        "Seade_on_toodud_kliendi_poolt", // activity name 
        "Remonditehnik", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 39     
    ///////////////////////////////      
    ChildrenOptim[39] = ["sid-A0412598-4D5B-45B5-9292-0409BE89EFFC"];
    ParentsOptim[39] = ["sid-E28CC810-DB0D-413D-A0FE-5FDA0394BBAA"];
    addActivity(
        39,  //activity id
        NodeType.TASK, // activity type 
        "Condition_68632E2-1250-41B3-9F3E-02008D14A7BE", // XML ID 
        "Seadet_on_vaimalik_remontida_Hansabis", // activity name 
        "Remonditehnik", //lane
        "",
        "",
        "12/31/2022");
    ///////////////////////////////      
    //====> Populate activity 40     
    ///////////////////////////////      
    ChildrenOptim[40] = ["sid-249307F2-98C5-452E-9248-5DE68862F557"];
    ParentsOptim[40] = ["sid-B32A0916-B0A5-4EC8-BB34-46054FE3C97F"];
    addActivity(
        40,  //activity id
        NodeType.TASK, // activity type 
        "Condition_21061BE-11E3-4127-91AA-DBDBD94A3AB1", // XML ID 
        "Seade_ei_ole_toodud_kliendi_poolt", // activity name 
        "Remonditehnik", //lane
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
