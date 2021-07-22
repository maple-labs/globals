pragma solidity ^0.6.7;

import "ds-test/test.sol";

import "./Globals.sol";

contract GlobalsTest is DSTest {
    Globals globals;

    function setUp() public {
        globals = new Globals();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
