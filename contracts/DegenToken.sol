// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    constructor() ERC20("Degen", "DGN") {}

    event Purchase(address indexed buyer, uint256 amount, string message);

    modifier positiveAmount(uint256 amount) {
        require(amount > 0, "Amount has to be greater than 0 wei");
        _;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transfer(address to, uint256 amount) public override positiveAmount(amount) returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public override positiveAmount(amount) returns (bool) {
        _transfer(from, to, amount);
        _approve(from, msg.sender, allowance(from, msg.sender) - amount);
        return true;
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function redeemAsset(uint256 amount, string memory message) public positiveAmount(amount) {
        _burn(msg.sender, amount);
        emit Purchase(msg.sender, amount, message);
    }

    function burn(uint256 amount) public positiveAmount(amount) {
        _burn(msg.sender, amount);
    }

    function burnFrom(address account, uint256 amount) public positiveAmount(amount) {
        uint256 currentAllowance = allowance(account, msg.sender);
        require(currentAllowance >= amount, "Allowance too low");
        _approve(account, msg.sender, currentAllowance - amount);
        _burn(account, amount);
    }

    function balance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
}
