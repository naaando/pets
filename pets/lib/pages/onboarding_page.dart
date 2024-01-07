import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/translate.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

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
            backgroundImage(context),
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
          t(context).onboardingTitle,
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
              children: [
                TextSpan(text: t(context).onboardingContent1),
              ],
            ),
          ),
        ),
        centerSpacer,
        Text(t(context).onboardingContent4),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/cadastro-pet'),
          label: Text(t(context).onboardingNoPetsCta),
          icon: const Icon(Icons.add),
        )
      ],
    );
  }

  backgroundImage(BuildContext context) {
    final fontColor = Theme.of(context).colorScheme.primary.withOpacity(0.4);

    final font =
        Theme.of(context).textTheme.labelSmall?.copyWith(color: fontColor);

    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/3778546.svg',
          semanticsLabel: t(context).onboardingAcessibleLabel,
          width: MediaQuery.of(context).size.width * 0.95,
        ),
        Positioned(
          top: 100,
          left: MediaQuery.of(context).size.width * 0.915,
          child: RotatedBox(
            quarterTurns: 1,
            child: GestureDetector(
              onTap: () async {
                const url =
                    'https://www.freepik.com/free-vector/different-pets-concept_7915264.htm#query=pets&position=15&from_view=search&track=sph&uuid=2395fe29-f874-4304-b22d-77205092eb02';
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Text(
                'Image by pikisuperstar on Freepik',
                textAlign: TextAlign.center,
                style: font,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
