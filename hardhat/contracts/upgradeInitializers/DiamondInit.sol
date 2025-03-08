// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/******************************************************************************\
* Author: Nick Mudge <nick@perfectabstractions.com> (https://twitter.com/mudgen)
* EIP-2535 Diamonds: https://eips.ethereum.org/EIPS/eip-2535
*
* Implementation of a diamond.
/******************************************************************************/

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {LibApp} from "../libraries/LibApp.sol";

import { IDiamondLoupe } from "../interfaces/IDiamondLoupe.sol";
import { IDiamondCut } from "../interfaces/IDiamondCut.sol";
import { IERC173 } from "../interfaces/IERC173.sol";
import { IERC165 } from "../interfaces/IERC165.sol";
import { IProcess } from "../interfaces/IProcess.sol";
// It is expected that this contract is customized if you want to deploy your diamond
// with data from a deployment script. Use the init function to initialize state variables
// of your diamond. Add parameters to the init funciton if you need to.

contract DiamondInit {
    event testInit (uint _zone);  

    // You can add parameters to this function in order to pass in 
    // data to set your own state variables
    function init() external {
        // adding ERC165 data
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        ds.supportedInterfaces[type(IERC165).interfaceId] = true;
        ds.supportedInterfaces[type(IDiamondCut).interfaceId] = true;
        ds.supportedInterfaces[type(IDiamondLoupe).interfaceId] = true;
        ds.supportedInterfaces[type(IERC173).interfaceId] = true;

 
        // add your own state variables 
        // EIP-2535 specifies that the `diamondCut` function takes two optional 
        // arguments: address _init and bytes calldata _calldata
        // These arguments are used to execute an arbitrary function using delegatecall
        // in order to set state variables in the diamond during deployment or an upgrade
        // More info here: https://eips.ethereum.org/EIPS/eip-2535#diamond-interface 
    }
    function initProcessus() external {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        //__________________________________ create instance _____________________________________// 
        IProcess processus =IProcess(ds.dialga);
        uint[] memory included = new uint256[](8);
        included[2]=1;
        uint[] memory executed = new uint256[](8);
        uint[] memory pending = new uint256[](8);
        string[] memory vide;
        string[] memory keyReplaySegment = new string[](1);
        keyReplaySegment[0]="Event_07w16d4";
        string[][] memory valueReplaySegment = new string[][](1);
        valueReplaySegment[0]= new string[](6);
        valueReplaySegment[0][0]="Event_1jryq1w";
        valueReplaySegment[0][1]="Event_1xb2qil";
        valueReplaySegment[0][2]="Activity_0jptkb4";
        valueReplaySegment[0][3]="Gateway_07qh5z4";
        valueReplaySegment[0][4]="Event_07w16d4";
        valueReplaySegment[0][5]="Event_0m90tu0";
        processus.newInstance("myContract",8,included,executed,pending,keyReplaySegment,valueReplaySegment);

        //__________________________________ replay handle  _____________________________________// 
        //________________________________________ Populate activities ___________________________//    
        ///////////////////////////////      
        //====> Populate activity 0     
        ///////////////////////////////      
        string[] memory child = new string[](1);
        string[] memory parent = new string[](1);
        string[] memory msgIn = new string[](1);
        string[] memory msgOut = new string[](1);

        child[0]="Event_1jryq1w";
        parent[0]="Event_1m9jbqa";
        msgIn[0]="Event_07w16d4";

        IProcess(ds.dialga).addActivity(
            0,  //activity id
            LibApp.NodeType.TASK, // activity type 
            "Activity_15n2fuv", // XML ID 
            "RealisationProjet", // activity name 
            "BureauEtude", //lane
            "",
            "",
            "12/31/2022",
            child,
            parent,
            msgIn,
            vide);
        ///////////////////////////////      
        //====> Populate activity 1     
        ///////////////////////////////      
        child[0]="Gateway_07qh5z4";
        parent[0]="Event_1xb2qil";
        IProcess(ds.dialga).addActivity(
            1,  //activity id
            LibApp.NodeType.TASK, // activity type 
            "Activity_0jptkb4", // XML ID 
            "VerificationsN1", // activity name 
            "VerificateurN1", //lane
            "",
            "",
            "12/31/2022",
            child,
            parent,
            vide,
            vide);
        ///////////////////////////////      
        //====> Populate activity 2     
        ///////////////////////////////      
        child[0]="Activity_15n2fuv";
        IProcess(ds.dialga).addActivity(
            2,  //activity id
            LibApp.NodeType.START, // activity type 
            "Event_1m9jbqa", // XML ID 
            "startProject", // activity name 
            "BureauEtude", //lane
            "",
            "",
            "12/31/2022",
            child,
            vide,
            vide,
            vide);
        ///////////////////////////////      
        //====> Populate activity 3     
        ///////////////////////////////      
        child[0]="Activity_0jptkb4";
        msgIn[0]="Event_1jryq1w";
        IProcess(ds.dialga).addActivity(
            3,  //activity id
            LibApp.NodeType.MSG_START, // activity type 
            "Event_1xb2qil", // XML ID 
            "receiveNotif", // activity name 
            "VerificateurN1", //lane
            "",
            "",
            "12/31/2022",
            child,
            vide,
            msgIn,
            vide);
        ///////////////////////////////      
        //====> Populate activity 4     
        ///////////////////////////////      
        parent[0]="Activity_15n2fuv";
        msgOut[0]="Event_1xb2qil";
        IProcess(ds.dialga).addActivity(
            4,  //activity id
            LibApp.NodeType.END, // activity type 
            "Event_1jryq1w", // XML ID 
            "notify", // activity name 
            "BureauEtude", //lane
            "",
            "",
            "12/31/2022",
            vide,
            parent,
            vide,
            msgOut);
        ///////////////////////////////      
        //====> Populate activity 5     
        ///////////////////////////////      
        parent[0]="Gateway_07qh5z4";
        msgOut[0]="Activity_15n2fuv";
        IProcess(ds.dialga).addActivity(
            5,  //activity id
            LibApp.NodeType.END, // activity type 
            "Event_07w16d4", // XML ID 
            "replay", // activity name 
            "VerificateurN1", //lane
            "",
            "",
            "12/31/2022",
            vide,
            parent,
            vide,
            msgOut);
        ///////////////////////////////      
        //====> Populate activity 6     
        ///////////////////////////////      
        parent[0]="Activity_15n2fuv";
        IProcess(ds.dialga).addActivity(
            6,  //activity id
            LibApp.NodeType.END, // activity type 
            "Event_0m90tu0", // XML ID 
            "finish", // activity name 
            "VerificateurN1", //lane
            "",
            "",
            "12/31/2022",
            vide,
            parent,
            vide,
            vide);
        ///////////////////////////////      
        //====> Populate activity 7     
        ///////////////////////////////      
        child = new string[](2);
        child[0] ="Event_07w16d4";
        child[1]="Event_0m90tu0";
        parent[0]="Activity_0jptkb4";
        IProcess(ds.dialga).addActivity(
            7,  //activity id
            LibApp.NodeType.XOR, // activity type 
            "Gateway_07qh5z4", // XML ID 
            "choose", // activity name 
            "VerificateurN1", //lane
            "",
            "",
            "12/31/2022",
            child,
            parent,
            vide,
            vide);
    }

    function initProcessus3() external {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();

        uint[] memory included = new uint256[](3);
        included[1]=1;
        uint[] memory executed = new uint256[](3);
        uint[] memory pending = new uint256[](3);
        string[] memory vide;
        string[] memory keyReplaySegment = new string[](0);
        string[][] memory valueReplaySegment = new string[][](0);
        IProcess(ds.dialga).newInstance("myContract",3,included,executed,pending,keyReplaySegment,valueReplaySegment);

        string[] memory child = new string[](1);
        string[] memory parent = new string[](1);

        child[0]="Event_0v3hqen";
        parent[0]="StartEvent_1";
        IProcess(ds.dialga).addActivity(
            0,  //activity id
            LibApp.NodeType.TASK, // activity type 
            "Activity_0vt6rwj", // XML ID 
            "A1", // activity name 
            "Lane A", //lane
            "{dataObject:xxxx}",
            "",
            "12/31/2022",
            child,
            parent,
            vide,
            vide
        );

        child[0]="Activity_0vt6rwj";
        IProcess(ds.dialga).addActivity(
            1,  //activity id
            LibApp.NodeType.TASK, // activity type 
            "Activity_0vhk57c", // XML ID 
            "A2", // activity name 
            "Lane A", //lane
            "",
            "",
            "12/31/2022",
            child,
            vide,
            vide,
            vide
        );

        parent[0]="Activity_0vt6rwj";
        IProcess(ds.dialga).addActivity(
            2,  //activity id
            LibApp.NodeType.START, // activity type 
            "StartEvent_1", // XML ID 
            "", // activity name 
            "Lane A", //lane
            "",
            "",
            "12/31/2022",
            vide,
            parent,
            vide,
            vide
        );
    }
    
}
