import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/provider/user_provider.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:pets/translate.dart';

class UserAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const UserAppBar({
    super.key,
  });

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(loggedUserProvider).asData!.value!;

    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: TextButton.icon(
              focusNode: FocusNode(debugLabel: 'Menu Button'),
              onPressed: () {
                Navigator.pushNamed(context, '/spaces');
              },
              icon: const Icon(Icons.workspaces),
              label: Text(user.espacoAtivo.value?.nome ?? ''),
            ),
          ),
          // Text(
          //   t(context).helloUser(user.name!),
          //   style: TextStyle(
          //     color: Theme.of(context).colorScheme.onSurface,
          //     fontSize: 12,
          //   ),
          // ),
          // const SizedBox(
          //   width: 12,
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 14,
              backgroundImage: FastCachedImageProvider(
                user.picture!,
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
