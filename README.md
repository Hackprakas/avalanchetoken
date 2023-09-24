# Degen Token Creation
This Solidity program is a simple Token program that demonstrates the basic syntax and functionality of the Solidity programming language. The purpose of the code is to create a token on avalanche c chain network

## Description
This program is a simple contract written in Solidity, a programming language used for developing smart contracts. The contract has 5-6 functions which enables you to mint,burn,transfer,reedem and check the balance of token.
## Getting Started
### Executing program
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., DegenToken.sol). Copy and paste the following code into the file:
```
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
```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.4" (or another compatible version), and then click on the "Compile" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "DegenToken" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can mint the token...make sure you are on fuji test network

## Authors
Prakash
@Hackprakas

## License
This project is licensed under the MIT License - see the LICENSE.md file for details
