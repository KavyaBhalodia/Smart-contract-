// SPDX-License-Identifier: MIT
pragma solidity  >=0.4.22 <0.7.0;

contract banking{
  mapping(address=>uint) public Account;
  mapping(address=>bool) public userExists;

  function createAccount() public payable returns(string memory){
      require(userExists[msg.sender]==false,'Account Already Exists');
      if(msg.value==0){
          Account[msg.sender]=0;
          userExists[msg.sender]=true;
          return 'Account created';
      }
      require(userExists[msg.sender]==false,'Account already Exists');
      Account[msg.sender] = msg.value;
      userExists[msg.sender] = true;
      return 'account created';
  }
  
  function deposit() public payable returns(string memory){
      require(userExists[msg.sender]==true, 'Account is not created');
      require(msg.value>0, 'Value for deposit is Zero');
      Account[msg.sender]=Account[msg.sender]+msg.value;
      return 'Deposited Succesfully';
  }
  
  function withdraw(uint amount) public payable returns(string memory){
      require(Account[msg.sender]>amount, 'Insufficeint balance in Bank account');
      require(userExists[msg.sender]==true, 'Account is not created');
      require(amount>0, 'Enter non-zero value for withdrawal');
      Account[msg.sender]=Account[msg.sender]-amount;
      msg.sender.transfer(amount);
      return 'Withdrawal Succesful';
  }
 
  function TransferAmount(address payable userAddress, uint amount) public returns(string memory){
      require(Account[msg.sender]>amount, 'insufficeint balance in Bank account');
      require(userExists[msg.sender]==true, 'Account is not created');
      require(userExists[userAddress]==true, 'to Transfer account does not exists in bank accounts ');
      require(amount>0, 'Enter non-zero value for sending');
      Account[msg.sender]=Account[msg.sender]-amount;
      Account[userAddress]=Account[userAddress]+amount;
      return 'Transfer successful';
  }
  
  function sendAmount(address payable toAddress , uint256 amount) public payable returns(string memory){
      require(amount>0, 'Enter non-zero value for withdrawal');
      require(userExists[msg.sender]==true, 'Account is not created');
      require(Account[msg.sender]>amount, 'insufficeint balance in Bank account');
      Account[msg.sender]=Account[msg.sender]-amount;
      toAddress.transfer(amount);
      return 'transfer success';
  }
  
  function AccountBalance() public view returns(uint){
      return Account[msg.sender];
  }
  
  function accountExist() public view returns(bool){
      return userExists[msg.sender];
  }
  
}