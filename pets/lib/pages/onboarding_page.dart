import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    final backgroundImageWidget = backgroundImage(context);

    final textualContentWidget = DefaultTextStyle(
      style: TextStyle(color: scheme.onPrimaryContainer),
      child: textualContent(
        context,
        const SizedBox(height: 360),
      ),
    );

    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            backgroundImageWidget,
            textualContentWidget,
          ],
        ),
      ),
    );
  }

  Column textualContent(
    BuildContext context,
    SizedBox centerSpacer,
  ) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Olá, seja bem vindo!',
          style: theme.textTheme.headlineMedium!
              .copyWith(color: theme.colorScheme.onPrimaryContainer),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
              children: const [
                TextSpan(text: 'Você ainda '),
                TextSpan(
                  text: 'não cadastrou',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ' nenhum dos seus pets')
              ],
            ),
          ),
        ),
        centerSpacer,
        const Text('Que tal cadastrar um agora?'),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/cadastro-pet'),
          label: const Text('Cadastrar novo pet'),
          icon: const Icon(Icons.add),
        )
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
