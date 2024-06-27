//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

import {SimpleSwap} from "../src/SimpleSwap.sol";

contract SimpleSwapTest is Test {
    using SafeERC20 for IERC20;

    SimpleSwap public simpleSwap;

    address public constant USDT_WHALE = address(0x3f5CE5FBFe3E9af3971dD833D26bA9b5C936f0bE);

    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;

    function setUp() public {
        simpleSwap = new SimpleSwap();
    }

    function testSwapFromUSDTToDAI() public {
        vm.startPrank(USDT_WHALE);
        IERC20 tokenIn = IERC20(USDT);
        tokenIn.forceApprove(address(simpleSwap), 1000);
        uint256 amountOut = simpleSwap.swap(USDT, DAI, 1000);
        vm.stopPrank();
        assertGe(amountOut, 0);
    }
}
