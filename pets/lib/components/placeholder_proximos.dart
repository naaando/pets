import 'package:flutter/material.dart';

class PlaceholderProximos extends StatelessWidget {
  const PlaceholderProximos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text.rich(
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
          Positioned(
            bottom: -36,
            right: 0,
            child: FilledButton.icon(
              onPressed: () => {},
              icon: const Icon(Icons.add),
              label: const Text('Agendar'),
            ),
          ),
        ],
      ),
    );
  }
}
