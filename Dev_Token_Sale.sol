// SPDX -License-Identifier: MIP
pragma solidity ^0.7.0;

import './DevToken.sol';

contract DevTokenSale{
   // address of admin
   address payable public admin;
   // Define the instnce of DevToken
   DevToken public devtoken;
   // Token price variable
   uint256 public tokenprice;
   // Count of token sold variable
   uint256 public totalsold;

   event sell(address _sender, uint256 _tokenvalue);

   // constructor
   constructor(address _tokenaddress, uint256 _tokenvalue){
     admin = msg.sender;
     tokenprice = _tokenvalue;
     devtoken = DevToken(_tokenaddress);
    
}

   // buytokens function
   function buyTokens(uint256 _totalvalue) public payable{
   // check if the contract has the token or not 
   require(devtoken.balanceOf(address(this)) >= _totalvalue, 'The smart contract dont hold the enough tokens');
   // check if the amount filled by user is accurate
   require(msg.value == _totalvalue * tokenprice, 'you are not sending enough ether');
   // transfer the token to the user
   devtoken.transfer(msg.sender, _totalvalue);
   // increase the token sold
   totalsold += _totalvalue;
   // emit sell event for ui
   emit sell(msg.sender, _totalvalue);
    
 }
 
   // end sale 
   function endSale() public {
   // check if the admin has clicked the function
   require(msg.sender == admin, 'You are not the admin');
   // transfer all the remaning tokens to admin
   devtoken.transfer(msg.sender, devtoken.balanceOf(address(this)));
   // transfer all the tokens to admin and selfdestruct the 
   selfdestruct(admin);
   
   }
   
}
