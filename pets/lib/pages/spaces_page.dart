import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
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
    final spaces = ref.watch(spacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(t(context).spaces),
        actions: [IconButton(icon: const Icon(Icons.delete), onPressed: () {})],
      ),
      body: spaces.when(
        data: (spaces) {
          final spacesList = spaces.values.toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: spacesList.length,
                  itemBuilder: (context, index) =>
                      spaceComponent(context, spacesList[index]),
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ],
            ),
          );
        },
        error: (err, stack) => throw err,
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget spaceComponent(context, space) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      selected: true,
      selectedColor: colorScheme.primary,
      selectedTileColor: colorScheme.primaryContainer,
      leading: CircleAvatar(
        foregroundColor: colorScheme.primary,
        backgroundColor: colorScheme.primaryContainer,
        child: const Icon(Icons.home),
      ),
      title: Text(space.nome ?? ''),
      trailing: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {},
      ),
    );
  }
}
