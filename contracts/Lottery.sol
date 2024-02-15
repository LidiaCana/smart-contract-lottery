// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Lottery{
           address public  manager;
           address payable[] public players;
      
    constructor ( ){
        manager= msg.sender;

    }
    function enter() public payable {
        require(msg.value> 0.1 ether);
       players.push(payable(msg.sender));
    }
    function random () private view returns (uint){
     return  uint(keccak256(abi.encode(block.difficulty, block.timestamp, players)));

    }
    function getWinner()public restriction {
       
         uint indexWinner = random()% players.length;
         players[indexWinner].transfer(address(this).balance);
         players = new address payable [](0);
    }
    modifier restriction (){
    require(msg.sender == manager);
        _;
    }

    function getPlayers() public view returns (address payable [] memory) {
        return  players;

    }

}