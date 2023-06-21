import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/main_tab_bar.dart';
import 'package:pets/models/user.dart';
import 'package:pets/provider/user_provider.dart';

class UserAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const UserAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider).asData!.value!;

    // return AppBar(
    //   backgroundColor: Colors.transparent,
    //   shadowColor: Colors.transparent,
    //   title: Text(
    //     'Olá, ${user.name}',
    //     style: const TextStyle(color: Colors.black54),
    //   ),
    //   centerTitle: true,
    //   actions: <Widget>[
    //     IconButton(
    //       icon: CircleAvatar(
    //         radius: 20,
    //         backgroundImage: NetworkImage(user.picture!),
    //         backgroundColor: Colors.transparent,
    //       ),
    //       onPressed: () {
    //         // do something
    //       },
    //     )
    //   ],
    // );
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Olá, ${user.name}',
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(
              width: 18,
            ),
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(user.picture!),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              width: 18,
            ),
          ],
        )
      ],
    );
  }
}
