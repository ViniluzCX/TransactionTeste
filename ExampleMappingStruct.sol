// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract MappingStruct {

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct balanceInfo {
        uint totalBalance;

        uint numDeposits;
        mapping(uint => Transaction) deposits;

        uint numWithdrawals;
        mapping(uint => Transaction) withdrawals;
    }

    event Deposited(address indexed user, uint amount, uint timestamp);
    event Withdrawn(address indexed user, uint amount, uint timestamp);


    mapping(address => balanceInfo) public balances;
    

    // reentrancy
    bool private verify;
    modifier noReentrancy() {
        require(!verify, "Reentrancy detected");
        verify = true;
        _;
        verify = false;
    }

    function depositMoney() public payable {
       balances[msg.sender].totalBalance += msg.value;

        Transaction memory deposit = Transaction(msg.value, block.timestamp);
        balances[msg.sender].deposits[balances[msg.sender].numDeposits] = deposit;
        balances[msg.sender].numDeposits++;

        emit Deposited(msg.sender, msg.value, block.timestamp);
    }

    function withdrawMoney(address payable _to, uint _amount) public noReentrancy {
        require(balances[msg.sender].totalBalance >= _amount, "Saldo insuficiente");
        balances[msg.sender].totalBalance -= _amount;
        Transaction memory withdrawal = Transaction(_amount, block.timestamp);
        balances[msg.sender].withdrawals[balances[msg.sender].numWithdrawals] = withdrawal;
        balances[msg.sender].numWithdrawals++;
        
        (bool sent, ) = _to.call{value: _amount}("");
            require(sent, "Falha no envio do Ether");

        emit Withdrawn(msg.sender, _amount, block.timestamp);

        }

    receive() external payable {
        balances[msg.sender].totalBalance += msg.value;
    }

    fallback() external payable {}
}
