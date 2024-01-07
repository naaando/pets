import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/provider/space_provider.dart';
import 'package:pets/provider/user_provider.dart';
import 'package:pets/translate.dart';

class SpacesPage extends HookConsumerWidget {
  const SpacesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loggedUserProvider).asData!.value!;
    final activeSpace = user.espacoAtivoId;
    final spaces = ref.watch(spacesProvider);

    onSpaceSelected(space) {
      ref.read(loggedUserProvider.notifier).setActiveSpace(space.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t(context).spaces),
      ),
      body: spaces.when(
        data: (spaces) {
          final spacesList = spaces.values.toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Text(
                  "Espaços Disponíveis",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 8),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: spacesList.length,
                  itemBuilder: (context, index) => spaceComponent(
                    context,
                    spacesList[index],
                    activeSpace,
                    onSpaceSelected,
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                  ),
                ),
              ],
            ),
          );
        },
        error: (err, stack) => throw err,
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget spaceComponent(context, space, activeSpace, onSpaceSelected) {
    final selected = activeSpace == space.id;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    final selectedTrailing = [
      IconButton(
        icon: const Icon(Icons.check_circle_rounded),
        onPressed: () {},
      ),
    ];

    final notSelectedTrailing = [
      IconButton(
        icon: const Icon(Icons.circle_outlined),
        onPressed: () => onSpaceSelected(space),
      ),
    ];

    return ListTile(
      selected: selected,
      selectedColor: colorScheme.onPrimaryContainer,
      selectedTileColor: colorScheme.primaryContainer,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: CircleAvatar(
        foregroundColor: selected
            ? colorScheme.onPrimaryContainer
            : colorScheme.onBackground,
        backgroundColor: selected
            ? colorScheme.primaryContainer
            : colorScheme.surfaceVariant,
        child: const Icon(Icons.home),
      ),
      title: Text(space.nome ?? ''),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: selected ? selectedTrailing : notSelectedTrailing,
      ),
    );
  }
}
