//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Lottery{

    address payable[] public players;
    address public manager;



    constructor(){
        manager = msg.sender;
    }

    receive () payable external{
        require(msg.value == 0.1 ether);// .1 ether dena pdega
        players.push(payable(msg.sender));//jisne payment ki uska address push karo aur show karo

    }

    function getBalance() public view returns(uint){
        require(msg.sender == manager,"You are not the manager");//jo address hai vo manager 
        //ke address ke equal hona chaiye kyunki hme sirf manager ko balance dikhana
        return address(this).balance;
    }

    function random() internal view returns(uint){
//generate random number caution!!!
       return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }


    function pickWinner() public{

        require(msg.sender == manager); //manager select karega winner
        require (players.length >= 2); //2 player hona compulsory

        uint r = random();
        address payable winner;


        uint index = r % players.length;//to generate random no that is 0,1 only i.e array index

        winner = players[index];

        winner.transfer(getBalance());//transfer money to winner


        players = new address payable[](0);
    }

}

