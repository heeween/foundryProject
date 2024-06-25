//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/interfaces/IERC20.sol";

contract ForkTest is Test {
    IERC20 public dai;

    function setUp() public {
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    }

    function testDaiDeposit() public {
        address alice = address(123);
        deal(address(dai), alice, 1e6 * 1e18);
        uint256 bal = dai.balanceOf(alice);
        assertEq(bal, 1e6 * 1e18);
    }
}
