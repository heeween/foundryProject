//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

interface IWETH {
    function balanceOf(address) external view returns (uint256);
    function deposit() external payable;
    function approve(address spender, uint256 amount) external returns (bool);
}

import {SimpleSwap} from "../src/SimpleSwap.sol";

contract SimpleSwapTest is Test {
    using SafeERC20 for IERC20;

    SimpleSwap public simpleSwap;

    address public constant DAI_WHALE = address(0x3f5CE5FBFe3E9af3971dD833D26bA9b5C936f0bE);
    address public constant USDT_WHALE = address(0x3f5CE5FBFe3E9af3971dD833D26bA9b5C936f0bE);

    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address public constant WETH9 = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function setUp() public {
        simpleSwap = new SimpleSwap();
    }

    function testSwapFromDAIToWETH() public {
        vm.startPrank(DAI_WHALE);
        IERC20 tokenIn = IERC20(DAI);
        tokenIn.approve(address(simpleSwap), 1 ether);
        uint256 amountOut = simpleSwap.swap(DAI, WETH9, 1 ether);
        vm.stopPrank();
        console.log(amountOut);
        assertGe(amountOut, 0);
    }

    function testSwapFromUSDTToDAI() public {
        vm.startPrank(USDT_WHALE);
        IERC20 tokenIn = IERC20(USDT);
        uint256 balOfWhale = tokenIn.balanceOf(USDT_WHALE);
        console.log(balOfWhale);
        tokenIn.forceApprove(address(simpleSwap), 1000);
        uint256 amountOut = simpleSwap.swap(USDT, DAI, 1000);
        vm.stopPrank();
        console.log(amountOut);
        assertGe(amountOut, 0);
    }
}
