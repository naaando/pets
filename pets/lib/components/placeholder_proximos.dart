import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pets/translate.dart';

class PlaceholderProximos extends HookWidget {
  final ValueNotifier<bool> showMenu;

  const PlaceholderProximos(this.showMenu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      TextSpan(
                        text: t(context).placeholderProximos1,
                      ),
                      TextSpan(
                        text: t(context).placeholderProximos2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      TextSpan(
                        text: t(context).placeholderProximos3,
                      )
                    ],
                  ),
                  TextSpan(
                    children: [
                      TextSpan(
                        text: t(context).placeholderProximos4,
                      ),
                      TextSpan(
                        text: t(context).placeholderProximos5,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      TextSpan(
                        text: t(context).placeholderProximos6,
                      ),
                      TextSpan(
                        text: t(context).placeholderProximos7,
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
            label: Text(t(context).schedule),
          ),
        ),
      ],
    );
  }
}
