// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    constructor() ERC20("Degen", "DGN") {}

    event status(address indexed buyer, uint256 amount, string message);

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

    function redeemAsset(uint256 amount) public positiveAmount(amount) {
        require(amount>5,"you cannot reedem amount greater than 5");
        if(amount==1){
            _burn(msg.sender,1);
            emit status(msg.sender,amount,"congratulations you have won a cool glass");
        }
         if(amount==2){
            _burn(msg.sender,2);
            emit status(msg.sender,amount,"congratulations you have won a gun");
        }
         if(amount==3){
            _burn(msg.sender,3);
            emit status(msg.sender,amount,"congratulations you have won a 3d armour");
        }
        if(amount==4){
            _burn(msg.sender,4);
            emit status(msg.sender,amount,"congratulations you have won a glow wall");
        }
        if(amount==5){
            _burn(msg.sender,5);
            emit status(msg.sender,amount,"congratulations you have won a sniper with unlimited bullets");
        }

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
