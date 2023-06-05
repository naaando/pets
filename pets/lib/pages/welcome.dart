// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pets/components/square_tile.dart';
import 'package:pets/login.dart';

class WelcomePage extends ConsumerWidget {
  WelcomePage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();

  final double _sigmaX = 5; // from 0-10
  final double _sigmaY = 5; // from 0-10
  final double _opacity = 0.2;
  final _formKey = GlobalKey<FormState>();

  void googleSignIn(WidgetRef ref) async {
    googleLogin(ref);
    // Provider.of<LoginState>(context, listen: false).loginGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: background(context, form(context, ref)),
        ),
      ),
    );
  }

  Widget form(context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 1).withOpacity(_opacity),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),

                    // google + apple sign in buttons
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // google button
                          GestureDetector(
                            onTap: () => googleSignIn(ref),
                            child: SquareTile(
                                imagePath: 'assets/images/google.png',
                                title: "Continue with Google"),
                          ),

                          SizedBox(height: 10),

                          // // apple button
                          // SquareTile(
                          //     imagePath: 'assets/images/apple.png',
                          //     title: "Continue with Apple"),

                          // SizedBox(height: 10),

                          // // facebook button
                          // SquareTile(
                          //     imagePath: 'assets/images/facebook.png',
                          //     title: "Continue with Facebook"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Stack background(context, child) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.network(
          'https://source.unsplash.com/random/?pets',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  }
}
