import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) onSubmitForm;

  TransactionForm(this.onSubmitForm);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final __valueController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(__valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    //ESSA VARIAVEL WIDGET VEM DA CLASSE STATE
    //ENVIA OS DADOS PRA TRANSACTION FORM
    widget.onSubmitForm(title, value, selectedDate);
  }

  _showDatePicker() {
    //Essa função abre o compomente de selecionar data
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((dataSelecionada) {
      setState(() {
        selectedDate = dataSelecionada;
      });
    });
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
                controller: _titleController,
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
                controller: __valueController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(labelText: "Valor (R\$)"),
              ),
            ),
            Container(
              height: 70,
              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Row(
                children: [
                  Text(selectedDate == null
                      ? "Nenhuma data Selecionada"
                      : 'Data selecionada: ' +
                          DateFormat('dd/MM/yyyy').format(selectedDate)),
                  FlatButton(
                    onPressed: () => _showDatePicker(),
                    child: Text(
                      "Selecionar Data",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: RaisedButton(
                    color: Theme.of(context).textTheme.button.color,
                    textColor: Colors.white,
                    child: Text('Nova Transação'),
                    onPressed: () {
                      _submitForm();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
