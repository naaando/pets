import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/main_tab_bar.dart';
import 'package:pets/models/user.dart';
import 'package:pets/provider/user_provider.dart';

class PetsAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const PetsAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(160);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider).asData!.value!;

    return AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      bottom: appbarBottom(context, user),
    );
  }

  PreferredSize appbarBottom(context, User user) {
    return PreferredSize(
      preferredSize: MediaQuery.of(context).size,
      child: Column(children: [
        userProfile(user),
        ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(20)),
          child: MainTabBar(),
        )
      ]),
    );
  }

  Widget userProfile(User user) {
    var name = user.name ?? '';
    var email = user.email ?? '';
    var photo = user.picture;

    return Container(
      padding: const EdgeInsets.only(left: 30, bottom: 20),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                      child: Image.network(
                    photo!,
                    errorBuilder: (context, object, stackTrace) =>
                        const Icon(Icons.person_outline_rounded),
                  ))),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(email,
                  style: const TextStyle(fontSize: 13, color: Colors.white)),
              const Text('Pai de pet',
                  style: TextStyle(fontSize: 13, color: Colors.white)),
            ]),
          ),
        ],
      ),
    );
  }
}
