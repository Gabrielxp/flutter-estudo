import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/transaction_form.dart';

import 'dart:math';

import 'package:expenses2/components/transaction_form.dart';
import 'package:expenses2/components/transaction_list.dart';
import 'package:expenses2/models/transaction.dart';

import 'models/transaction.dart';

main(List<String> args) {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ESSA PARADA AQUI DEFINE UMA ORIENTAÇÃO PRO APP
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          primaryColor: Colors.teal[900],
          primarySwatch: Colors.teal,
          accentColor: Colors.teal,
          fontFamily: 'Roboto',

          //JA ESSA PARADA DEFINE UMA PERSONALIZAÇÃO DE THEME PARA APP BAR
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold))),
          //ESSA PARADA DEFINE UM PADRÃO DE THEME PARA TODOS OS TITLES
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontSize: 16,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.teal[900]))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  //Busca as transações mais antigas
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime data) {
    final newTransaction = Transaction(
        id: Random().nextInt(999999).toString(),
        title: title,
        value: value,
        date: data);

    setState(() {
      _transactions.add(newTransaction);
    });

    //Fez fechar a modal
    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  _opentransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        "Despesas Pessoais",
        style: TextStyle(
          //O text Scale Factor é uma propriedade que o cellar
          //tem para ampliar o tamanho da fonte
          fontSize: 15 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _opentransactionFormModal(context))
      ],
    );
    //altura disponovel no disositivo - altura do appBar - altura da barra superior
    //Com isso o componente podera respeitar a altura disponivel
    final alturaDisponivel = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //Main axis da coluna é a vertical
          //Adiciono um espaço ao redor dos elementos da coluna
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          //Cross Axis da coluna é o horizontal
          // Estica os elementos da coluna no eixo horizontal
          // não precisando dai usar o width no card
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Para colocar um card na tela inteira da pra por ele num Containet
            //Chart(_recentTransactions),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
              height: alturaDisponivel * 0.99,
              child: TransactionList(_transactions, _deleteTransaction),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _opentransactionFormModal(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
