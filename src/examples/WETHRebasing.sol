// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../IWETHRebasing.sol";
import "../../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract WETHRebasingExample is Ownable {
    address public WETH = 0x4200000000000000000000000000000000000023; // testnet

    IWETHRebasing public constant wethRebase =
        IWETHRebasing(0x4200000000000000000000000000000000000023); //testnet

    constructor(address _initialOwner) Ownable(_initialOwner) {}

    /// Deposit/swap ETH for WETH
    function deposit() external payable {
        wethRebase.deposit{value: msg.value}();
    }

    /// Swap/withdraw ETH from WETH
    /// @param wad amount of ETH to be withdraw from WETH
    function withdraw(uint256 wad) external {
        wethRebase.withdraw(wad);
    }

    /// Get the total number of shares that has been distributed.
    function count() external view returns (uint256) {
        uint256 _count = wethRebase.count();
        return _count;
    }

    /// Retrieve the current share price based on the current contract balance.
    /// @return Current share price.
    function sharePrice() external view returns (uint256) {
        uint256 _sharedPrice = wethRebase.sharePrice();
        return _sharedPrice;
    }

    // Send a specify amount of Eth and get  WETH
    // When you send a specif  amount ETH to the WETH contract address,
    //the default function on the contract will be excuted  and  equall amount of WETH will be send back.
    function depositETH(uint256 _amount) external {
        require(WETH != address(0), "Invalid contract address");
        require(_amount > 0, "Invalid amount");

        (bool success, ) = WETH.call{value: _amount}("");
        require(success, "Ether transfer to contract failed");
    }
}
