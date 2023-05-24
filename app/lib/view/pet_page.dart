import 'package:flutter/material.dart';

class PetPage extends StatelessWidget {
  PetPage({Key key}) : super(key: key);

  void _void() {
    //
  }

  Widget emptyPlaceholder() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ListTile(
          leading: Icon(Icons.pets),
          title: Text('Ninguém!'),
          subtitle: Text('Parece que você ainda não registrou nenhum animal.'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: const Text('CADASTRAR'),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    );
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.all(20),
      child: emptyPlaceholder()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus pets')),
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: _void,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
