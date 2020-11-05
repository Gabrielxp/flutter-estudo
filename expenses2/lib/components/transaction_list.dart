import 'package:expenses2/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty ?  Column(
        children: [
          Text(
            'Nenhuma Transação Cadastrada',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 20),//ESSE CARALHO AQUI AJUDA A DAR UM ESPAÇAMENTO
          Container(
            height: 300,
            child: Image.asset(
              'assets/images/download.png',
               fit: BoxFit.cover)//Esse cover obedece o tamanho do item pai, no caso do container que a imagem ta
            )
        ],
      ) :  ListView.builder(
        //Pega quantidade de itens a serem renderizados
        itemCount: transactions.length,
        //Essa item builder  renderiza os componentes conforme for descendo a tela
        // Para não exigir muito recurso do celular
        itemBuilder: (contexto, index){
          final e = transactions[index];
          return
          //seguir mais ou menos esse card para o receituario
          Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5) ,
              elevation: 5,
              child: ListTile(
              hoverColor: Colors.red,
              title: Text(e.title),
              subtitle: Text('Valor: R\$${e.value.toStringAsFixed(2)}\nAvada kedavra'),
              trailing: Icon(Icons.more_vert),
              leading: CircleAvatar(
                backgroundColor: Colors.amber,//Mudar a cor e a descrição de acordo com o tipo de documento
                child: Text('R.E', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                
                ),
              ),
            ),
          );
          
          //  Card(
          //       child: Row(
          //         children: [
          //           Container(
          //             margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //             decoration: BoxDecoration(
          //                 border: Border.all(
          //                   //PEGA A COR DEFAULT DO THEME
          //               color: Theme.of(context).primaryColor,
          //               width: 2,
          //             )),
          //             padding: EdgeInsets.all(10),
          //             child: Text(
          //               'R\$${e.value.toStringAsFixed(2)}',
          //               style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 20,
          //               color: Theme.of(context).primaryColor,
          //                 ),
          //             ),
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 e.title,
          //                 //Forma de pegar o theme do title
          //                 style: Theme.of(context).textTheme.headline6,
          //               ),
          //               Text(
          //                 DateFormat('dd MM yyyy').format(e.date),
          //                 style: TextStyle(fontSize: 12, color: Colors.grey),
          //               )
          //             ],
          //           )
          //         ],
          //       ),
          //     );
        },
        ),
    );
  }
}
