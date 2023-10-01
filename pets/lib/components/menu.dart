import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pets/translate.dart';

class Menu extends HookWidget {
  final ValueNotifier<bool> showMenu;
  const Menu(this.showMenu, {Key? key}) : super(key: key);

  void toggleMenu() => showMenu.value = !showMenu.value;

  @override
  Widget build(BuildContext context) {
    return gestureDetector(
      container(
        actionsAligner(
          actions(),
        ),
      ),
    );
  }

  Widget gestureDetector(Widget child) {
    return GestureDetector(
      onTap: toggleMenu,
      child: child,
    );
  }

  Widget container(Widget child) {
    final context = useContext();
    final scheme = Theme.of(context).colorScheme;

    return Container(
      // color: scheme.primary.withOpacity(0.2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0.25),
            scheme.primary,
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: child,
    );
  }

  Widget actionsAligner(List<Widget> children) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  List<Widget> actions() {
    final context = useContext();

    return [
      const SizedBox(
        height: 110,
      ),
      FloatingActionButton.extended(
        label: Text(t().vaccine),
        onPressed: () {
          toggleMenu();
          Navigator.pushNamed(context, '/cadastro-vacina');
        },
        icon: const Icon(Icons.vaccines),
        heroTag: null,
      ),
      const SizedBox(
        height: 8,
      ),
      FloatingActionButton.extended(
        label: Text(t().medication),
        onPressed: () {
          toggleMenu();
          Navigator.pushNamed(context, '/medicacao');
        },
        icon: const Icon(Icons.medication_liquid),
        heroTag: null,
      ),
      const SizedBox(
        height: 8,
      ),
      FloatingActionButton.extended(
        label: Text(t().pet),
        onPressed: () {
          toggleMenu();
          Navigator.pushNamed(context, '/cadastro-pet');
        },
        icon: const Icon(Icons.pets),
        heroTag: null,
      ),
    ].reversed.toList();
  }
}
