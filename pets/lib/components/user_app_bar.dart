import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/provider/user_provider.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';

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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Olá, ${user.name}',
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          const SizedBox(
            width: 12,
          ),
          CircleAvatar(
            radius: 14,
            backgroundImage: FastCachedImageProvider(
              user.picture!,
            ),
            backgroundColor: Colors.transparent,
          )
        ],
      ),
    );
  }
}
