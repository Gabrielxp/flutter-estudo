import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final Function(String, double) onSubmitForm;

  TransactionForm(this.onSubmitForm);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Título"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: valueController,
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
                    onSubmitForm(titleController.text,
                        double.tryParse(valueController.text) ?? 0.0);
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
