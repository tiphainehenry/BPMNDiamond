// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { LibApp } from "../libraries/LibApp.sol";

interface IProcess {

    function newInstance(
        string memory _name,
        uint256 _activityIdsLength,
        uint[] memory _included,
        uint[] memory _pending,
        uint[] memory _executed,
        string[] memory _keyReplaySegment,
        string[][] memory _valueReplaySegment
    ) external;

    function addActivity(
        uint _id,
        LibApp.NodeType _type,
        string memory _xmlID,
        string memory _name,
        string memory _lane,
        string memory _data_in,
        string memory _data_out,
        string memory _timestamp,
        string[] memory _child,
        string[] memory _parent,
        string[] memory _msgIn,
        string[] memory _msgOut
    ) external;
}
