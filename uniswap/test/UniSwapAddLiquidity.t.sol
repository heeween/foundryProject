//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

import {UniswapLiquidity} from "../src/UniSwapAddLiquidity.sol";

contract UniswapLiquidityTest is Test {
    using SafeERC20 for IERC20;
UniswapLiquidity private swapLiquidity;
    address constant CALLER = address(123);
  address constant TOKEN_A = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
  address constant TOKEN_A_WHALE = 0xF977814e90dA44bFA03b6295A0616a897441aceC;
  address constant TOKEN_B = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
  address constant TOKEN_B_WHALE = 0x3f5CE5FBFe3E9af3971dD833D26bA9b5C936f0bE;
  uint256 constant TOKEN_A_AMOUNT = 100000;
  uint256 constant TOKEN_B_AMOUNT = 100000;

  IERC20 public tokenA;
  IERC20 public tokenB;
  function setUp() public{
    swapLiquidity = new UniswapLiquidity();
    tokenA = IERC20(TOKEN_A);
    tokenB = IERC20(TOKEN_B);
    deal(TOKEN_A_WHALE,1 ether);
    deal(TOKEN_B_WHALE,1 ether);
vm.prank(TOKEN_B_WHALE);
tokenB.safeTransfer(CALLER,TOKEN_B_AMOUNT);
vm.prank(TOKEN_A_WHALE);
tokenA.safeTransfer(CALLER,TOKEN_A_AMOUNT);
vm.startPrank(CALLER);
tokenA.approve(address(swapLiquidity),TOKEN_A_AMOUNT);
tokenB.approve(address(swapLiquidity),TOKEN_B_AMOUNT);
vm.stopPrank();
  }
  function testAddLiquidity() public {
    vm.prank(CALLER);
swapLiquidity.addLiquidity(TOKEN_A, TOKEN_B, TOKEN_A_AMOUNT, TOKEN_B_AMOUNT);
  }
}