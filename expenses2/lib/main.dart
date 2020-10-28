import 'package:expenses2/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

main(List<String> args) {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _transactions = [
    Transaction(
        id: "t1",
        title: "Novo Tênis de Corrida",
        value: 310.23,
        date: DateTime.now()),
    Transaction(
        id: "t1", title: "Conta de Luz", value: 310.23, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
      ),
      body: Column(
        //Main axis da coluna é a vertical
        //Adiciono um espaço ao redor dos elementos da coluna
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        //Cross Axis da coluna é o horizontal
        // Estica os elementos da coluna no eixo horizontal
        // não precisando dai usar o width no card
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Para colocar um card na tela inteira da pra por ele num Containet
          Container(
            //width: double.infinity,//Pega o width da tela inteira
            child: Card(
              color: Colors.blue,
              child: Text("Gráfico"),
              elevation: 5,
            ),
          ),
          Column(
            //retorna uma lista de cards convertendo para elementos
            //visuais usando o map
            children: _transactions.map((e) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.purple[50],
                        width: 2,
                      )),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'R\$${e.value.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('dd MM yyyy').format(e.date),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
