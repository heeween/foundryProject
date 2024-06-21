//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {Wallet} from "../src/wallet.sol";

contract WalletTest is Test {
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet{value: 1e18}();
    }

    function _send(uint256 amount) private {
        (bool ok,) = address(wallet).call{value: amount}("");
        require(ok, "send ETH failed");
    }

    function testEthBalance() public view {
        console.log("Eth Balance", address(this).balance);
        console.log("Eth address", address(this));
        console.log("Eth address", address(wallet).balance);
    }

    function testSendEth() public {
        address(wallet).balance;
        deal(address(1), 100);
        assertEq(address(1).balance, 100);

        deal(address(1), 10);
        assertEq(address(1).balance, 10);

        deal(address(1), 123);
        vm.prank(address(1));
        _send(123);

        hoax(address(1), 345);
        _send(345);
        assertEq(address(wallet).balance, 468);
    }
}
