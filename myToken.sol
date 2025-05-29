// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract myToken {
    string public name = "xyToken";
    string public symbol = "XYT";
    uint256 public decimals = 18;
    uint256 public totalSupply;
    mapping(address=>uint256) public balanceOf;

    event Transfer(address from,address to,uint256 amount);
    
    function _mint(address to,uint256 amount) internal {
        require(msg.sender != address(0));
        totalSupply += amount;
        balanceOf[to] += amount;
        emit Transfer(address(0), to, amount);
    }
    constructor(){
        _mint(msg.sender,10*10**decimals);
    }

    function transfer(address to, uint256 value) public {
        require(balanceOf[msg.sender] >= value && to!=address(0));
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
    }
    function burn(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount);
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}

