import 'dart:developer';

import 'package:expenses2/components/item_menu.dart';
import 'package:expenses2/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onDeleteComponent;

  TransactionList(this.transactions, this.onDeleteComponent);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                'Nenhuma Transação Cadastrada',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                  height: 20), //ESSE CARALHO AQUI AJUDA A DAR UM ESPAÇAMENTO
              Container(
                  height: 300,
                  child: Image.asset('assets/images/download.png',
                      fit: BoxFit
                          .cover) //Esse cover obedece o tamanho do item pai, no caso do container que a imagem ta
                  )
            ],
          )
        : ListView(
            //Essa item builder  renderiza os componentes conforme for descendo a tela
            // Para não exigir muito recurso do celular
            children: transactions.map((e) {
              final GlobalKey _menuKey = new GlobalKey();

              return
                  //seguir mais ou menos esse card para o receituario
                  Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 5,
                child: ListTile(
                  hoverColor: Colors.red,
                  title: Text(e.title),
                  subtitle: Text(
                      'Valor: R\$${e.value.toStringAsFixed(2)}\nAvada kedavra Data: ${DateFormat('dd/MM/yyyy').format(e.date)}'),
                  trailing: PopupMenuButton(
                    key: _menuKey,
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (_) {
                      return <PopupMenuItem<ItemMenu>>[
                        (PopupMenuItem<ItemMenu>(
                            child: Text("Deletar"),
                            value: ItemMenu(acao: 'deletar', id: e.id)))
                      ];
                    },
                    onSelected: (value) {
                      log(value.toString());
                      if ('deletar'.contains(value.acao)) {
                        log(value.acao);
                        log(value.id);
                        log(value.change());
                        onDeleteComponent(value.id);
                      }
                    },
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors
                        .amber, //Mudar a cor e a descrição de acordo com o tipo de documento
                    child: Text(
                      'R.E',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
  }
}
