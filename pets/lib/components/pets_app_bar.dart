import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pets/provider/user_provider.dart';

class PetsAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  late AppBar appBar;

  PetsAppBar({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(140);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider.notifier);

    return appBar = AppBar(
      title: Text(title),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      bottom: user.state != null ? appbarBottom(user.state!) : null,
    );
  }

  PreferredSize appbarBottom(GoogleSignInAccount user) {
    var name = user.displayName ?? '';
    var email = user.email;
    var photo = user.photoUrl;

    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: Container(
        padding: const EdgeInsets.only(left: 30, bottom: 20),
        child: Row(children: [
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
          )
        ]),
      ),
    );
  }
}
