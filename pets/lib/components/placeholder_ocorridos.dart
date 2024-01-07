import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pets/translate.dart';

class PlaceholderOcorridos extends HookWidget {
  final ValueNotifier<bool> showMenu;

  const PlaceholderOcorridos(this.showMenu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final textColor = colorScheme.brightness == Brightness.light
        ? colorScheme.primaryContainer
        : colorScheme.onBackground;

    final backgroundColor = colorScheme.brightness == Brightness.light
        ? colorScheme.onPrimaryContainer
        : colorScheme.primaryContainer;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
                bottom: 30,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: t(context).placeholderTimeline1,
                  ),
                  TextSpan(
                    children: [
                      TextSpan(
                        text: t(context).placeholderTimeline2,
                      ),
                      TextSpan(
                        text: t(context).placeholderTimeline3,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: t(context).placeholderTimeline4,
                      ),
                    ],
                  ),
                  TextSpan(
                    children: [
                      TextSpan(
                        text: t(context).placeholderTimeline5,
                      ),
                      TextSpan(
                        text: t(context).placeholderTimeline5,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: t(context).placeholderTimeline6,
                      ),
                    ],
                  )
                ]),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: textColor),
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: FilledButton.icon(
            onPressed: () => showMenu.value = !showMenu.value,
            icon: const Icon(Icons.add),
            label: Text(t(context).registerEvent),
          ),
        ),
      ],
    );
  }
}
