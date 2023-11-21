import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SmallNativeAd extends StatefulWidget {
  ColorScheme scheme;

  SmallNativeAd({super.key, required this.scheme});

  @override
  SmallNativeAdState createState() => SmallNativeAdState();
}

class SmallNativeAdState extends State<SmallNativeAd> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;
  final double _adAspectRatioSmall = (91 / 355);

  final String _adUnitId =
      Platform.isAndroid ? 'ca-app-pub-4189251425238819/7196697261' : '';

  @override
  void initState() {
    super.initState();

    final naviteListener = NativeAdListener(
      onAdLoaded: (ad) {
        // ignore: avoid_print
        print('$NativeAd loaded.');
        setState(() {
          _nativeAdIsLoaded = true;
        });
      },
      onAdFailedToLoad: (ad, error) {
        // ignore: avoid_print
        print('$NativeAd failedToLoad: $error');
        ad.dispose();
      },
      onAdClicked: (ad) {},
      onAdImpression: (ad) {},
      onAdClosed: (ad) {},
      onAdOpened: (ad) {},
      onAdWillDismissScreen: (ad) {},
      onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
    );

    final nativeTemplateStyle = NativeTemplateStyle(
      templateType: TemplateType.small,
      mainBackgroundColor: widget.scheme.background,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: widget.scheme.surface,
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: widget.scheme.primary,
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
      secondaryTextStyle: NativeTemplateTextStyle(
        textColor: widget.scheme.onBackground,
        style: NativeTemplateFontStyle.italic,
        size: 14.0,
      ),
      tertiaryTextStyle: NativeTemplateTextStyle(
        textColor: widget.scheme.onBackground,
        style: NativeTemplateFontStyle.normal,
        size: 14.0,
      ),
    );

    _loadAd(
      naviteListener,
      nativeTemplateStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * _adAspectRatioSmall,
        width: MediaQuery.of(context).size.width,
        child: _nativeAdIsLoaded && _nativeAd != null
            ? AdWidget(ad: _nativeAd!)
            : null,
      ),
    );
  }

  /// Loads a native ad.
  void _loadAd(naviteListener, nativeTemplateStyle) {
    setState(() {
      _nativeAdIsLoaded = false;
    });

    _nativeAd = NativeAd(
      adUnitId: _adUnitId,
      listener: naviteListener,
      request: const AdRequest(),
      nativeTemplateStyle: nativeTemplateStyle,
    );

    _nativeAd!.load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }
}
