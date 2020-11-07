import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexible & Expanded',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Flexible & Expanded'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,// O ESPAÇÃO NAO UTILIZADO E DISTRIBUIDO
        children: <Widget>[
          Container(
            height: 100,
            child: Text('Item 1 - pretty big!'),
            color: Colors.red,
          ),
          Expanded(//e a mesma coisa que flexible porem com tight por default
              flex: 1,
              //fit: FlexFit.tight,//TIGHT PEGA O ESPAÇO EM BRANCO QUE SOBRAR
              child: Container(
              height: 100,
              width: 400,
              child: Text('Item 2'),
              color: Colors.blue,
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.loose,//LOOSE PEGA O TAMANHO NECESSARIO
              child: Container(
              height: 100,
              child: Text('Item 3'),
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
