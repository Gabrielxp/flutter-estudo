import 'package:expenses2/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MEDIA_QUERY = MediaQuery.of(context);

    //altura disponovel no disositivo - altura do appBar - altura da barra superior
    //Com isso o componente podera respeitar a altura disponivel
    final alturaDisponivel = MEDIA_QUERY.size.height;
    final larguraDisponivel = MEDIA_QUERY.size.width;

    final appBar = AppBar(
      title: Text(
        "Despesas Pessoais",
        style: TextStyle(
          //O text Scale Factor é uma propriedade que o cellar
          //tem para ampliar o tamanho da fonte
          fontSize: 15 * MEDIA_QUERY.textScaleFactor,
        ),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
            height: alturaDisponivel - MEDIA_QUERY.padding.top,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/medico2.jpg',
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(150, 0, 0, 460),
                  child: Image.asset(
                    'assets/images/logo_crmpr.png',
                    fit: BoxFit.none,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(185, 200, 0, 0),
                  child: Text(
                    "Receituario Médico Online",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 10,
                  width: larguraDisponivel,
                  margin:
                      EdgeInsets.fromLTRB(20, alturaDisponivel * 0.80, 20, 70),
                  child: RaisedButton(
                    elevation: 20,
                    child: Text(
                      'ACESSAR',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) {
                          return MyHomePage();
                        },
                      ));
                    },
                  ),
                ),
              ],
              fit: StackFit.passthrough,
            ),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
