//SPDX-License-Identifier:MIT
pragma solidity ^0.7.6;
pragma abicoder v2;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import '@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

import {UniSwapAddLiquidity} from "../src/UniSwapAddLiquidity.sol";

contract UniSwapAddLiquidityTest is Test {

    address public DAI_WHALE = 0x3f5CE5FBFe3E9af3971dD833D26bA9b5C936f0bE;
    address public USDC_WHALE = 0x4B16c5dE96EB2117bBE5fd171E4d203624B014aa;
    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public constant factory = 0x1F98431c8aD98523631AE4a59f267346ea31F984;
    address public constant weth9 = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    UniSwapAddLiquidity public uniSwapAddLiquidity;

    function setUp() public {
        INonfungiblePositionManager manager = INonfungiblePositionManager(0xC36442b4a4522E871399CD717aBDD847Ab11FE88);
        uniSwapAddLiquidity = new UniSwapAddLiquidity(manager,factory,weth9);
    }

    function testMintLiquidityPosition() public {
        vm.startPrank(DAI_WHALE);
        IERC20(DAI).transfer(address(uniSwapAddLiquidity),20*1e18);
        vm.stopPrank();
        vm.startPrank(USDC_WHALE);
        IERC20(USDC).transfer(address(uniSwapAddLiquidity),20*1e6);
        vm.stopPrank();
        uniSwapAddLiquidity.mintNewPosition();
    }

}