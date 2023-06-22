import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FabActions extends HookWidget {
  const FabActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var showFab = useState(false);
    var toggle = () => showFab.value = !showFab.value;

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
        label: const Text('Adicionar pet'),
        onPressed: () => {Navigator.pushNamed(context, '/pet')},
        icon: const Icon(Icons.pets),
      ),
      const SizedBox(
        height: 8,
      ),
      FloatingActionButton.extended(
        label: const Text('Adicionar evento'),
        onPressed: () => {Navigator.pushNamed(context, '/evento')},
        icon: const Icon(Icons.history_edu),
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
