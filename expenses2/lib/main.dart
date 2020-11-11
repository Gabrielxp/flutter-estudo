import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/transaction_form.dart';

import 'dart:math';

import 'package:expenses2/components/transaction_form.dart';
import 'package:expenses2/components/transaction_list.dart';
import 'package:expenses2/models/transaction.dart';

import 'models/transaction.dart';

//LINK INSPIRAÇÃO PARA TELAS: https://www.youtube.com/watch?v=6zd4ziDN7XY
main(List<String> args) {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  //Esse objeto Contexto possui uma informação para localização do componente na arvore
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

//esse with é um mixin, reaproveita funcoes, esse observer verifica o estado geral do app quando esta pausado, ativo, resumido...
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];

//ESSE METODO É EXECUTADO ANTES DO BUILD, PODE SER USADO PARA BUSCAR COISAS NO BACKEND
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //É NECESSARIO REGISTRAR O OBSERVER PARA FUNCIONAR A VERIFICAÇÃO DE ESTADO A NIVEL DE APLICAÇÃO
    WidgetsBinding.instance.addObserver(this);
  }

//ESSE METODO E EXECUTADO QUANDO UM WIDGET TA SENDO DESTRUIDO
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //CASO SAIA DO COMPONENTE WIDGET, É NECESSARIO DES-REGISTRAR O COMPONENTE
    WidgetsBinding.instance.removeObserver(this);
  }

//executado quando o widget sobre alteração
  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

//esse metodo e executado quando tem alteração de estado a nivel de aplicação no celular
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

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
    final MEDIA_QUERY = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text(
        "Despesas Pessoais",
        style: TextStyle(
          //O text Scale Factor é uma propriedade que o cellar
          //tem para ampliar o tamanho da fonte
          fontSize: 15 * MEDIA_QUERY.textScaleFactor,
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
    final alturaDisponivel = MEDIA_QUERY.size.height -
        appBar.preferredSize.height -
        MEDIA_QUERY.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        //ESSA PARADA CRIA UMA AREA SEGURA PARA O CORPO DO APP
        child: SingleChildScrollView(
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
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _opentransactionFormModal(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
