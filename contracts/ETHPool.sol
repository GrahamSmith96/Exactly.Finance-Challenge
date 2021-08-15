//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";


contract ETHPool {
  address public Team; //only user that has permission to deposit rewards


  // the amount deposited and participation status is recorded for each user a, b, ...
  struct User {
    uint balance;
    uint percentage; // percentage of pool ownership
    bool inPool;
  }

  address[] public poolMembers;

  mapping(address => User) public users;

  constructor(address _team) payable {
    console.log("ETHPool deployed");
    Team = _team;
  }

  event Deposited(address, uint);

  function enrollUser() public payable {
    users[msg.sender].balance = msg.value;
    users[msg.sender].percentage = (users[msg.sender].balance * 100) / address(this).balance;
    users[msg.sender].inPool = true;
    poolMembers.push(msg.sender);

    /* this for loop will cost more gas as more members join the pool, forgive me for not
    knowing a more cost-efficient method to do this*/

    //adjusting the percentages of every other member
    for (uint i = 0; i < poolMembers.length; i++) {
    // 5 * 100/ 50 = 10%    5 * 10000 /50 = 100000%
        if(users[poolMembers[i]].inPool == true) {
        users[poolMembers[i]].percentage = (users[poolMembers[i]].balance * 100) / address(this).balance;
        }
    }
    
    emit Deposited(msg.sender, msg.value);
  }

  uint public reward;
  function depositRewards() public payable {
    require(msg.sender == Team);
    
  
    for (uint i = 0; i < poolMembers.length; i++) {

        if (users[poolMembers[i]].inPool == true) {
        
        reward = (msg.value * users[poolMembers[i]].percentage) / 100;
    
        users[poolMembers[i]].balance += reward;

        }
    }


  }

 

  function withdraw() external payable {
    require(users[msg.sender].balance >= msg.value);

    payable(msg.sender).transfer(users[msg.sender].balance);

    users[msg.sender].inPool = false;

    for (uint i = 0; i < poolMembers.length; i++) {
    // 5 * 100/ 50 = 10%    5 * 10000 /50 = 100000%
        if (users[poolMembers[i]].inPool == true) {
        users[poolMembers[i]].percentage = (users[poolMembers[i]].balance * 100) / address(this).balance;
        }
    
    }

    

  }

   receive() external payable {
    }





}
