import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FabActions extends HookWidget {
  const FabActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var showFab = useState(false);
    toggle() => showFab.value = !showFab.value;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children:
          showFab.value ? fabExpanded(toggle, context) : fabCollapsed(toggle),
    );
  }

  fabCollapsed(toggle) {
    return [
      FloatingActionButton(
        onPressed: toggle,
        child: const Icon(Icons.add),
      )
    ];
  }

  fabExpanded(toggle, context) {
    return [
      FloatingActionButton.extended(
        label: const Text('Vacina'),
        onPressed: () => {Navigator.pushNamed(context, '/cadastro-vacina')},
        icon: const Icon(Icons.vaccines),
        heroTag: null,
      ),
      const SizedBox(
        height: 8,
      ),
      FloatingActionButton.extended(
        label: const Text('Medicação'),
        onPressed: () => {Navigator.pushNamed(context, '/medicacao')},
        icon: const Icon(Icons.medication_liquid),
        heroTag: null,
      ),
      const SizedBox(
        height: 8,
      ),
      FloatingActionButton.extended(
        label: const Text('Pet'),
        onPressed: () => {Navigator.pushNamed(context, '/cadastro-pet')},
        icon: const Icon(Icons.pets),
        heroTag: null,
      ),
      const SizedBox(
        height: 8,
      ),
      FloatingActionButton(
        onPressed: toggle,
        child: const Icon(Icons.close),
      )
    ];
  }
}
