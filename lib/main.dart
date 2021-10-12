import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peoplecounter/counter.dart';
import 'package:peoplecounter/strings.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:peoplecounter/utils.dart';

StreamController<bool> isLightTheme = StreamController();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final darkTheme = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: primaryColor,
        brightness: Brightness.dark,
      ).copyWith(secondary: Colors.white));

    final lightTheme = ThemeData(
      primarySwatch: primaryColor,
    );

    return StreamBuilder<bool>(
      initialData: true,
      stream: isLightTheme.stream,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.contador_de_pessoas,
          theme: (snapshot?.data??true) ? lightTheme : darkTheme,
          home: MyHomePage(title: Strings.contador_de_pessoas),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-2567071790842101/5978092829',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  final AdSize adSize = AdSize(width: 300, height: 50);

  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  late AdWidget adWidget;
  late Container adContainer;

  @override
  void initState() {
    myBanner.load();
    adWidget = AdWidget(ad: myBanner);
    adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Counter(title: widget.title,),
          Positioned(bottom: 0.0, left: 0.0, right: 0.0,child: Align(alignment: FractionalOffset.bottomCenter,child: adContainer))
        ]
    );
  }
}
