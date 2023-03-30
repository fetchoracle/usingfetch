// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "../UsingFetch.sol";

/**
 * @title UserContract
 * This contract inherits UsingFetch for simulating user interaction
 */
contract BenchUsingFetch is UsingFetch {
    constructor(address payable _fetch) UsingFetch(_fetch) {}

    function sliceUint(bytes memory _b) public pure returns (uint256) {
        return _sliceUint(_b);
    }
}
