

---

# TransactionWithMappingStruct

Contrato inteligente em Solidity para gerenciamento seguro de depósitos e saques em ETH, com histórico detalhado de transações usando structs e mappings.

---

## Descrição

Este contrato permite que usuários façam depósitos e saques de ETH, armazenando um histórico completo de cada transação (valor e timestamp). O contrato implementa proteção contra ataques de reentrância, emitindo eventos para facilitar a interação com frontends e monitoramento.

---

## Funcionalidades principais

* Depósito e saque de ETH por usuários.
* Histórico completo de depósitos e saques registrado em structs.
* Uso de mappings para armazenamento eficiente por índice.
* Eventos emitidos para cada operação, permitindo monitoramento externo.
* Proteção contra ataques de reentrância via modifier `noReentrancy`.
* Funções `receive` e `fallback` para recebimento de ETH.

---

## Estrutura dos dados

* `Transaction`: struct que contém `amount` e `timestamp`.
* `balanceInfo`: struct que mantém saldo total, contagem e mapeamento de depósitos e saques.

---

## Como usar

1. Faça deploy do contrato em uma rede Ethereum compatível (ex: Sepolia Testnet).
2. Interaja usando a carteira MetaMask ou qualquer wallet compatível.
3. Use a função `depositMoney()` para enviar ETH e registrar o depósito.
4. Use a função `withdrawMoney(address payable _to, uint _amount)` para sacar ETH para um endereço.
5. Consulte os eventos `Deposited` e `Withdrawn` para histórico.

---

## Testes realizados

* Deploy e interação usando Remix IDE.
* Testes com MetaMask na Sepolia Testnet.
* Monitoramento de transações e eventos pelo [Sepolia Etherscan](https://sepolia.etherscan.io/tx/0x1aa330bc3c372c2febeee2be75b3a5597a3bd07a781fc76c9710abc3c6b8e9d3).


---

## Idéias para o futuro

* Adicionar funções para consultar histórico de transações por índice.
* Criar interface web para facilitar visualização das movimentações.
* Implementar testes automatizados usando Hardhat ou Foundry.
* Melhorar segurança e otimização do contrato.

