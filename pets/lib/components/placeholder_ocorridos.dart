import 'package:flutter/material.dart';

class PlaceholderOcorridos extends StatelessWidget {
  const PlaceholderOcorridos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            TextSpan(children: [
              TextSpan(
                text:
                    'Assim como nos agendados você pode acompanhar eventos do animal que foram registrados.\n\n',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Quando você ',
                  ),
                  TextSpan(
                    text: 'conclui',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const TextSpan(
                    text: ' um agendamento ele vem para cá.\n',
                  ),
                ],
              ),
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Da mesma forma quando anota algum registro ',
                  ),
                  TextSpan(
                    text: 'com a data no passado',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const TextSpan(
                    text: ' ele também vem para cá.\n',
                  ),
                ],
              )
            ]),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Positioned(
            bottom: -36,
            right: 0,
            child: FilledButton.icon(
              onPressed: () => {},
              icon: const Icon(Icons.add),
              label: const Text('Criar agendamento'),
            ),
          ),
        ],
      ),
    );
  }
}
