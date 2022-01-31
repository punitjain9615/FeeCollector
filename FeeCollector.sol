pragma solidity ^0.8.7;
contract FeeCollector {  
    address public owner;
    uint256 public balance;
    event Received(address, uint);
    constructor() {
        owner = msg.sender; 
    }
    
    receive() payable external {
         balance += msg.value;
         emit Received(msg.sender, msg.value);
    }
     
    mapping (string=>address) public myusers;
       function insertauser(string memory name, address acadrs) internal {
       myusers[name]=acadrs;
    }
    function deleteauser (string memory name) internal {
        delete myusers[name];
    }
    
    function withdraw(uint amount, string memory name) public {
        require(msg.sender == owner);
        require(amount <= balance);
        
        address payable destaddress= payable(myusers[name]);
        destaddress.transfer(amount); 
        balance -= amount;
    }
}
