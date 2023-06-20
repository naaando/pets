import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/config.dart';
import 'package:pets/models/remedio.dart';
import 'package:pets/provider/remedio_provider.dart';

class DashboardTab extends HookConsumerWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var remedios = ref.watch(remediosProvider);
    var remedios = <String, Remedio>{};

    return Scaffold(
      body: content(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/remedio');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget content(BuildContext context) {
    var themeData = Theme.of(context).copyWith(
        cardTheme: CardTheme.of(context).copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.red.shade50,
    ));

    return Theme(
        data: themeData,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Text('Registros de vacinas, remédios, compras de ração...',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            compraDeRacaoExemplo(),
            vacinaExemplo(),
            testeCard(),
          ],
        ));
  }

  compraDeRacaoExemplo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                child: Icon(Icons.shopping_cart),
              ),
              title: Text('Compra de ração'),
              subtitle: Text('Ração para cachorro'),
              trailing: Text(Jiffy.now().format(pattern: 'dd/MM/yyyy')),
            )
          ],
        ),
      ),
    );
  }

  vacinaExemplo() {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  child: Icon(Icons.vaccines),
                ),
                title: Text('Vacina'),
                subtitle: Text('V8'),
                trailing: Text(Jiffy.now().format(pattern: 'dd/MM/yyyy')),
              )
            ])));
  }

  testeCard() {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(16).subtract(EdgeInsets.only(top: 16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                    foregroundImage: NetworkImage(
                        "${baseUri}storage/pets/7VL11n8DzKZ2u8toLIoOASRXfJ7UOODi5HaVmOJE.jpg")),
                title: Text('Agnaldo'),
                subtitle: Text(Jiffy.now().jms),
                trailing: Text(
                  'A fazer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.yellow),
                ),
              ),
              Text('Remedio de verme Natuverm')
            ],
          )),
    );
  }
}
