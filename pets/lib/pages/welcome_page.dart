// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/square_tile.dart';
import 'package:pets/login.dart';
import 'package:pets/provider/user_provider.dart';

class WelcomePage extends ConsumerWidget {
  WelcomePage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();

  final double _sigmaX = 5; // from 0-10
  final double _sigmaY = 5; // from 0-10
  final double _opacity = 0.6;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(loggedUserProvider);

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
    final colorsScheme = Theme.of(context).colorScheme;

    return ClipRect(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: colorsScheme.primaryContainer.withOpacity(_opacity),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // google button
              GestureDetector(
                onTap: () => googleSignIn(ref),
                child: SquareTile(
                  imagePath: 'assets/images/google.png',
                  title: "Entrar com Google",
                ),
              ),

              SizedBox(height: 10),

              // // apple button
              // SquareTile(
              //     imagePath: 'assets/images/apple.png',
              //     title: "Continue with Apple"),

              // SizedBox(height: 10),

              // facebook button
              GestureDetector(
                onTap: () => facebookSignIn(ref),
                child: SquareTile(
                  imagePath: 'assets/images/facebook.png',
                  title: "Entrar com Facebook",
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Stack background(context, child) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: AssetImage(
              'assets/images/login/jamie-street-Zqy-x7K5Qcg-unsplash.jpg'),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  }
}
