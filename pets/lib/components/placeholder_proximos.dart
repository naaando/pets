import 'package:flutter/material.dart';

class PlaceholderProximos extends StatelessWidget {
  final ValueNotifier<bool> showMenu;

  const PlaceholderProximos(this.showMenu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Você pode agendar ',
                      ),
                      TextSpan(
                        text:
                            'consultas, vacinas, medicações e outras tarefas e compromissos ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const TextSpan(
                        text: 'do animal.\n\n',
                      )
                    ],
                  ),
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Os agendamentos podem ',
                      ),
                      TextSpan(
                        text: 'ser repetições para tarefas rotineiras',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const TextSpan(
                        text: ' ou ',
                      ),
                      TextSpan(
                        text: 'por quantidade como as doses em medicamentos.\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(
            height: 22,
          ),
        ]),
        Positioned(
          bottom: 0,
          right: 10,
          child: FilledButton.icon(
            onPressed: () => showMenu.value = !showMenu.value,
            icon: const Icon(Icons.add),
            label: const Text('Agendar'),
          ),
        ),
      ],
    );
  }
}
