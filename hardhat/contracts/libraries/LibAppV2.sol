// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LibAppV2 {
    bytes32 constant APP_STORAGE_POSITION = keccak256("app.standard.app.storage");

    enum NodeType {
        START,      //0
        END,        //1
        MSG_START,  //2
        EVENT,      //3
        TASK,       //4
        XOR,        //5
        AND,        //6
        OTHER       //7
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
        uint256[] markings; // This array will be replaced by a mapping in the next update
    }

    struct Model {
        bool isSet;
        address owner;
        uint256 nbActivity;
        uint256 nbInstance;
        mapping(uint256 => Instance) instances;
        mapping(uint256 => Activity) activities;
        mapping(uint256 => string[]) childrenOptim;
        mapping(uint256 => string[]) parentsOptim;
        mapping(uint256 => string[]) msgInOptim;
        mapping(uint256 => string[]) msgOutOptim;
        mapping(string => string[]) replaySegments;
        // Add a new field to support encoding changes for the model.
        mapping(uint256 => string) activityMetadata; // New field for metadata
    }

    struct Instance {
        uint256 id;
        mapping(string => address) role2owner;
        uint256[] markingsIncluded;
        uint256[] markingsPending;
        uint256[] markingsExecuted;
        uint256[] xorIds;
        // Additional fields can be added for advanced execution logic
    }

    struct AppStorage {
        mapping(string => Model) models;
    }

    event TaskExecuted(
        address indexed from,
        string id,
        string data,
        string timestamp
    );

    event TaskExecutionError(
        address indexed from,
        string id,
        string timestamp
    );

    function appStorage() internal pure returns (AppStorage storage _as) {
        bytes32 position = APP_STORAGE_POSITION;
        assembly {
            _as.slot := position
        }
    }
    
  
}
