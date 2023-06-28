import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var backgroundImageWidget = backgroundImage(context);
    var spacer = const SizedBox(height: 360);
    var textStyle = const TextStyle(color: Color.fromRGBO(57, 57, 57, 1));
    var textualContentWidget = DefaultTextStyle(
      style: textStyle,
      child: textualContent(context, spacer, textStyle),
    );

    return Scaffold(
      // backgroundColor: Colors[],
      body: Center(
          child: Stack(
        alignment: Alignment.center,
        children: [backgroundImageWidget, textualContentWidget],
      )),
    );
  }

  Column textualContent(
      BuildContext context, SizedBox centerSpacer, TextStyle textStyle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text('Olá, seja bem vindo!', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 6),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(style: textStyle, children: const [
                  TextSpan(text: 'Você ainda '),
                  TextSpan(
                      text: 'não cadastrou',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' nenhum dos seus pets')
                ]))),
        centerSpacer,
        const Text('Que tal cadastrar um agora?'),
        const SizedBox(height: 20),
        FilledButton(
            onPressed: () => Navigator.pushNamed(context, '/cadastro-pet'),
            child: const Text('Cadastrar novo pet'))
      ],
    );
  }

  SvgPicture backgroundImage(context) {
    return SvgPicture.asset(
      'assets/images/onboarding_background.svg',
      semanticsLabel: 'A person with a dog walking',
      width: MediaQuery.of(context).size.width * 0.95,
    );
  }
}
