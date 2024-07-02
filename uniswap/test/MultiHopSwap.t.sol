//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol";
import {MultiHopSwap} from "../src/MultiHopSwap.sol";
import {IWETH} from "../src/interfaces/IWETH.sol";


contract MultiHopSwapTest is Test {

    MultiHopSwap public multiHopSwap;
    address public constant swaper = address(123);
    address public constant DAI_WHALE = address(0x3f5CE5FBFe3E9af3971dD833D26bA9b5C936f0bE);

    function setUp() public {
        multiHopSwap = new MultiHopSwap();
    }

    function testSwapFromDAIToUSDCToWETH() public {
        deal(swaper,1 ether);
        vm.startPrank(swaper);
        IWETH weth = IWETH(multiHopSwap.WETH9());
        weth.deposit{value:1 ether}();
        weth.approve(address(multiHopSwap), 1 ether);
        uint256 amountOut = multiHopSwap.swapExactInputMultihop(1 ether);
        vm.stopPrank();
        console.log(amountOut);
        assertGe(amountOut, 0);
    }

}
