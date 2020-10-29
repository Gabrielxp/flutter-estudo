import 'package:expenses2/components/transaction_user.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
      ),
      body: Column(
        //Main axis da coluna é a vertical
        //Adiciono um espaço ao redor dos elementos da coluna
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          TransactionUser()
        ],
      ),
    );
  }
}
