// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract myToken {
    string public name = "xyToken";
    string public symbol = "XYT";
    uint256 public decimals = 18;
    uint256 public totalSupply;
    mapping(address=>uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from,address indexed to,uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);

    function _mint(address to,uint256 amount) internal {
        require(to != address(0));
        totalSupply += amount;
        balanceOf[to] += amount;
        emit Transfer(address(0), to, amount);
    }
    constructor(){
        _mint(msg.sender,10*10**decimals);
    }
 
    function transfer(address to, uint256 value) public returns (bool) {
        require(balanceOf[msg.sender] >= value && to!=address(0));
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    function burn(uint256 amount) public returns (bool) {
        require(balanceOf[msg.sender] >= amount);
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "approve to zero address");
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender,spender,amount);
        return true;
    }
    function transferFrom(address from, address to,uint256 amount) public returns (bool) {
        require(allowance[from][msg.sender] >= amount);
        require(balanceOf[from] >= amount);

        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        

        emit Transfer(from, to, amount);

        return true;
    }  
}
