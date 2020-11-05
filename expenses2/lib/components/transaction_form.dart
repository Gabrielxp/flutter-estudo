import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {

  final Function(String, double) onSubmitForm;

  TransactionForm(this.onSubmitForm);

  @override
  _TransactionFormState createState() => _TransactionFormState();

}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm(){

    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <=0 ){
      return;
    }

   //ESSA VARIAVEL WIDGET VEM DA CLASSE STATE
    widget.onSubmitForm(title, value);

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Card(
        //elevation: 5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(labelText: "Título"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                //ESSA PARADA AQUI MOSTRA O INPUT SO DE NUMEROS
                //PODERIA SER TEXTINPUTTYPE.NUMBER (IGNORA DECIMAIS)
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: valueController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(labelText: "Valor (R\$)"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  textColor: Colors.purple,
                  child: Text('Nova Transação'),
                  onPressed: () {
                  
                    _submitForm();
                  
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
