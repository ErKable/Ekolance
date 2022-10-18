// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract EtherWallet {
    address payable public owner;
    mapping(address => uint256) public userToAmount;

    event thankBro(address user, uint256 amout);

    constructor() {
        owner = payable(msg.sender);
    }

    // receive() external payable {}

    function deposit() external payable {
        require(msg.value > 0, "Trying to send 0 eth");
        userToAmount[msg.sender] += msg.value;
    }


    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);
    }

    function withdrawFromBro(address user) external {
        require(msg.sender == owner, "caller is not the owner");
        uint256 amount = userToAmount[user];
        payable(msg.sender).transfer(amount);   
        delete userToAmount[user];
        emit thankBro(user, amount);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function getAmount(address user) external view returns (uint256) {
        return userToAmount[user];
    }
}
