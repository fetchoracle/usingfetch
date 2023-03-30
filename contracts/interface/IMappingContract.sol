// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMappingContract{
    function getFetchID(bytes32 _id) external view returns(bytes32);
}