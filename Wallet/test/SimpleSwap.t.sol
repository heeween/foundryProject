//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";

interface IWETH {
    function balanceOf(address) external view returns (uint256);
    function deposit() external payable;
    function approve(address spender, uint256 amount) external returns (bool);
}

import {SimpleSwap} from "../src/SimpleSwap.sol";

contract SimpleSwapTest is Test {
    SimpleSwap public simpleSwap;
    address public constant SwapRouterAddress = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
    IWETH private weth;

    function setUp() public {
        simpleSwap = new SimpleSwap(SwapRouterAddress);
        weth = IWETH(simpleSwap.WETH9());
    }

    function testSwap() public {
        vm.startPrank(address(123));
        vm.deal(address(123), 1 ether);
        weth.deposit{value: 1 ether}();
        weth.approve(address(simpleSwap), 1 ether);
        uint256 amountOut = simpleSwap.swapWETHForDAI(1 ether);
        vm.stopPrank();
        console.log(amountOut);
        assertGe(amountOut, 0);
    }
}
