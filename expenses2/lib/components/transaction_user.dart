import 'dart:math';

import 'package:expenses2/components/transaction_form.dart';
import 'package:expenses2/components/transaction_list.dart';
import 'package:expenses2/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
        id: "t1",
        title: "Novo Tênis de Corrida",
        value: 310.23,
        date: DateTime.now()),
    Transaction(
        id: "t1", title: "Conta de Luz", value: 310.23, date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transactions),
        TransactionForm(_addTransaction)
      ],
    );
  }
}
