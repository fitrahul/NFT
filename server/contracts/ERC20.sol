// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract RahulToken {
    string public name = "KESHRI";
    string public symbol = "RKT";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping (address => uint) public balances; // balances means tokens (for understanding)
    mapping (address => mapping (address => uint)) public allowed;

    constructor(uint256 _totalTokens) {
        totalSupply = _totalTokens;
        balances[msg.sender] = _totalTokens; // Initially owner have this fixed number of tokens
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner]; // check balance of a particular owner by there address
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        // _value means number of tokens need to be transfered to receiver
        // --- I(msg.sender) am transfering to other(_to) from my own account ---
        require(balances[msg.sender] >= _value, "Insufficent number of Tokens");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        // let owner(msg.sender) have 50 tokens and want to give 20 tokens(_value) to _spender
        // to spend this token in behalf of owner
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        // to check the number of tokens given to _spender by _owner
        return allowed[_owner][_spender];
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        // --- I(msg.sender) am transfering to other(_to) from other account(_from) who approve me ---
        require(balances[_from] >= _value, "Owner have less balance than given value");
        require(allowed[_from][msg.sender] >= _value, "Allowed balance to me is low");
        balances[_from] -= _value;
        allowed[_from][msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}
