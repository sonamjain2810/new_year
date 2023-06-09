import 'dart:async';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_app/data/Wallpapers.dart';
import 'data/AdService.dart';
import 'data/Messages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/Stickers.dart';
import 'data/Strings.dart';
import 'widgets/AppStoreItemWidget2.dart';
import 'widgets/CustomFBTextWidget.dart';
import 'widgets/CustomFeatureCard.dart';
import 'widgets/CustomFullCard.dart';
import 'widgets/MessageWidget3.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/Gifs.dart';
import 'data/Images.dart';
import 'data/Quotes.dart';
import 'data/Shayari.dart';
import 'data/Status.dart';
import 'utils/SizeConfig.dart';
import 'MyDrawer.dart';
import 'widgets/CustomBannerWidget.dart';
import 'widgets/MessageWidget1.dart';

// Height = 8.96
// Width = 4.14
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final facebookAppEvents = FacebookAppEvents();
  String interstitialTag = "";
  String _authStatus = 'Unknown';

  late BannerAd bannerAd2, bannerAd3;
  bool isBannerAdLoaded = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => initPlugin());
    AdService.createInterstialAd();

    bannerAd2 = GetBannerAd();
    bannerAd3 = GetBannerAd();
  }

  BannerAd GetBannerAd() {
    return BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: Strings.iosAdmobBannerId,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            isBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          isBannerAdLoaded = true;
          ad.dispose();
        }),
        request: AdRequest())
      ..load();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd2.dispose();
    bannerAd3.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.requestTrackingAuthorization();

      switch (status) {
        case TrackingStatus.authorized:
          print("Tracking Status Authorized");
          break;
        case TrackingStatus.denied:
          print("Tracking Status Denied");
          break;
        case TrackingStatus.notDetermined:
          print("Tracking Status not Determined");
          break;
        case TrackingStatus.notSupported:
          print("Tracking Status not Supported");
          break;
        case TrackingStatus.restricted:
          print("Tracking Status Restricted");
          break;
        default:
      }
    } on PlatformException {
      setState(() => _authStatus = 'PlatformException was thrown');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: Theme.of(context).appBarTheme.textTheme!.headline1,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  DesignerContainer(
                    isLeft: false,
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Center(
                        child: Text("Choose Wishes From Below",
                            style: Theme.of(context).textTheme.headline1),
                      ),
                    ),
                  ),

                  Divider(),

                  // Wishes Start
                  DesignerContainer(
                    isLeft: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("Select Your Language For Wishes  ",
                              style: Theme.of(context).textTheme.headline1),
                        ),
                        // Honey
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.height(6.0)),
                              child: Row(
                                children: [
                                  //English
                                  InkWell(
                                    child: MessageWidget3(
                                      headLine: "English",
                                      subTitle: Messages.english_data[2],
                                      imagePath:
                                          "http://www.andiwiniosapps.in/new_year/1.png",
                                      color: Colors.orange,
                                    ),
                                    onTap: () {
                                      print("English Message Clicked");
                                      interstitialTag = "lang_english";
                                      facebookAppEvents.logEvent(
                                        name: "Message List",
                                        parameters: {
                                          'button_id': 'lang_english_button',
                                        },
                                      );
                                      AdService.context = context;
                                      AdService.interstitialTag =
                                          "lang_english";
                                      AdService.showInterstitialAd();
                                    },
                                  ),

                                  Column(
                                    children: [
                                      InkWell(
                                        child: MessageWidget1(
                                          headLine: "हिंदी",
                                          subTitle: Messages.hindi_data[0],
                                          imagePath:
                                              "http://www.andiwiniosapps.in/new_year/2.png",
                                          color: Colors.brown,
                                        ),
                                        onTap: () {
                                          print("Hindi Clicked");
                                          interstitialTag = "lang_hindi";
                                          facebookAppEvents.logEvent(
                                            name: "Message List",
                                            parameters: {
                                              'button_id': 'lang_hindi_button',
                                            },
                                          );
                                          //AdService.goTo(context, interstitialTag);
                                          AdService.context = context;
                                          AdService.interstitialTag =
                                              "lang_hindi";
                                          AdService.showInterstitialAd();
                                        },
                                      ),
                                      SizedBox(
                                        height: SizeConfig.height(8.0),
                                      ),

                                      //Spainsh
                                      InkWell(
                                        child: MessageWidget1(
                                          headLine: "Español",
                                          subTitle: Messages.spanish_data[6],
                                          imagePath:
                                              "http://www.andiwiniosapps.in/new_year/3.png",
                                          color: Colors.deepOrangeAccent,
                                        ),
                                        onTap: () {
                                          print("For All Clicked");
                                          interstitialTag = "lang_spanish";
                                          facebookAppEvents.logEvent(
                                            name: "Message List",
                                            parameters: {
                                              'button_id':
                                                  'lang_spanish_button',
                                            },
                                          );
                                          AdService.context = context;
                                          AdService.interstitialTag =
                                              "lang_spanish";
                                          AdService.showInterstitialAd();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // rikhil

                        // Abdul

                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.height(6.0)),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      // German
                                      InkWell(
                                        child: MessageWidget1(
                                          headLine: "Deutsche",
                                          subTitle: Messages.german_data[6],
                                          imagePath:
                                              "http://www.andiwiniosapps.in/new_year/7.png",
                                          color: Colors.redAccent,
                                        ),
                                        onTap: () {
                                          print("German Clicked");
                                          interstitialTag = "lang_german";
                                          facebookAppEvents.logEvent(
                                            name: "Message List",
                                            parameters: {
                                              'button_id': 'lang_german_button',
                                            },
                                          );
                                          //AdService.goTo(context, interstitialTag);
                                          AdService.context = context;
                                          AdService.interstitialTag =
                                              "lang_german";
                                          AdService.showInterstitialAd();
                                        },
                                      ),
                                      SizedBox(
                                        height: SizeConfig.height(8.0),
                                      ),

                                      // French
                                      InkWell(
                                          child: MessageWidget1(
                                            headLine: "français",
                                            subTitle: Messages.french_data[3],
                                            imagePath:
                                                "http://www.andiwiniosapps.in/new_year/5.png",
                                            color: Colors.blueGrey,
                                          ),
                                          onTap: () {
                                            print("français Clicked");
                                            interstitialTag = "lang_french";
                                            facebookAppEvents.logEvent(
                                              name: "Message List",
                                              parameters: {
                                                'button_id':
                                                    'lang_french_button',
                                              },
                                            );
                                            AdService.context = context;
                                            AdService.interstitialTag =
                                                "lang_french";
                                            AdService.showInterstitialAd();
                                          }),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // Italy
                                      InkWell(
                                        child: MessageWidget1(
                                          headLine: "Italiano",
                                          subTitle: Messages.italy_data[0],
                                          imagePath:
                                              "http://www.andiwiniosapps.in/new_year/6.png",
                                          color: Colors.green[400],
                                        ),
                                        onTap: () {
                                          print("Italian Clicked");
                                          interstitialTag = "lang_italian";
                                          facebookAppEvents.logEvent(
                                            name: "Message List",
                                            parameters: {
                                              'button_id':
                                                  'lang_italian_button',
                                            },
                                          );
                                          //AdService.goTo(context, interstitialTag);
                                          AdService.context = context;
                                          AdService.interstitialTag =
                                              "lang_italian";
                                          AdService.showInterstitialAd();
                                        },
                                      ),

                                      SizedBox(
                                        height: SizeConfig.height(8.0),
                                      ),

                                      //Portugal
                                      InkWell(
                                        child: MessageWidget1(
                                          headLine: "Português",
                                          subTitle: Messages.portugal_data[1],
                                          imagePath:
                                              "http://www.andiwiniosapps.in/new_year/4.png",
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onTap: () {
                                          print("Portuguese Clicked");
                                          interstitialTag = "lang_portuguese";
                                          facebookAppEvents.logEvent(
                                            name: "Message List",
                                            parameters: {
                                              'button_id':
                                                  'lang_portuguese_button',
                                            },
                                          );
                                          AdService.context = context;
                                          AdService.interstitialTag =
                                              "lang_portuguese";
                                          AdService.showInterstitialAd();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        //Kalam
                      ],
                    ),
                  ),

                  // Wishes end
                  Divider(),
                  DesignerContainer(
                    isLeft: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("👋,Games For You | 👗 🆙 | 🫣 🔍 | 🧩🤔",
                              style: Theme.of(context).textTheme.headline1),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                AppStoreItemWidget2(
                                  appTitle: "",
                                  imageUrl:
                                      "https://is5-ssl.mzstatic.com/image/thumb/Purple112/v4/4a/8c/62/4a8c6201-b787-d4fa-e1d0-4b585454c47c/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.png",
                                  appUrl:
                                      "https://apps.apple.com/us/app/puzzle-games-jigsaw-puzzles/id1660034531",
                                ),
                                AppStoreItemWidget2(
                                  appTitle: "",
                                  imageUrl:
                                      "https://is3-ssl.mzstatic.com/image/thumb/Purple112/v4/88/77/c6/8877c63f-7403-9b49-d575-578d80075271/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.png",
                                  appUrl:
                                      "https://apps.apple.com/us/app/christmas-game-dressup-girl-hd/id6443515715",
                                ),
                                AppStoreItemWidget2(
                                  appTitle: "",
                                  imageUrl:
                                      "https://is1-ssl.mzstatic.com/image/thumb/Purple112/v4/a2/4c/bf/a24cbfec-774f-8ef4-7901-95857d34e6a1/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.png",
                                  appUrl:
                                      "https://apps.apple.com/us/app/christmas-hidden-objects-brain/id1542868606",
                                ),
                                AppStoreItemWidget2(
                                  appTitle: "",
                                  imageUrl:
                                      "https://is1-ssl.mzstatic.com/image/thumb/Purple122/v4/ff/3b/6e/ff3b6e42-cd15-99ef-e566-18250123f049/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.png",
                                  appUrl:
                                      "https://apps.apple.com/us/app/christmas-decoration-makeover/id1660383621",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    //banner
                  ),

                  Divider(),

                  // Shayari start
                  DesignerContainer(
                    isLeft: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("New Year Shayari",
                              style: Theme.of(context).textTheme.headline1),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: InkWell(
                            child: Container(
                              width: size.width - SizeConfig.width(16),
                              height: size.width / 2,
                              decoration: BoxDecoration(
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.dark
                                        ? Theme.of(context).primaryColorDark
                                        : Colors.yellow[900],
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(SizeConfig.height(20)),
                                  topRight:
                                      Radius.circular(SizeConfig.height(20)),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 4,
                                      color: Colors.grey),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Icon(Icons.format_quote,
                                      color: Theme.of(context)
                                          .primaryIconTheme
                                          .color),
                                  Positioned(
                                    top: 20,
                                    width: size.width - SizeConfig.width(16),
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(SizeConfig.width(8)),
                                        child: Text(
                                          Shayari.shayari_data[1],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    right: 0,
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(SizeConfig.width(8)),
                                        child: Text(
                                          "Tap Here to Continue",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color:
                                                      Colors.purpleAccent[700]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              print("Shayari Clicked");
                              interstitialTag = "shayari";
                              facebookAppEvents.logEvent(
                                name: "Shayari List",
                                parameters: {
                                  'button_id': 'Shayari_button',
                                },
                              );
                              //AdService.goTo(context, interstitialTag);
                              AdService.context = context;
                              AdService.interstitialTag = "shayari";
                              AdService.showInterstitialAd();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Shayari end

                  Divider(),
                  DesignerContainer(
                      isLeft: false,
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("✋ Need Your HELP? 😊",
                              style: Theme.of(context).textTheme.headline1),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text(
                              "Your suggestions are very important to improve your experience in next APP Update. Let me know how our team can improve. Thanks! and click the BUTTON Below 👇🏻 to RATE this app.",
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Strings.RateNReview();
                            },
                            child: const Text("⬇️ Rate & Review ⬇️"))
                      ])),
                  Divider(),

                  //Wallpapers Start
                  DesignerContainer(
                    isLeft: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("New Year Wallpapers",
                              style: Theme.of(context).textTheme.headline1),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Wallpapers.wallpapers_path[7],
                                        ontap: null),
                                  ),
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Wallpapers.wallpapers_path[3],
                                        ontap: null),
                                  ),
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Wallpapers.wallpapers_path[4],
                                        ontap: null),
                                  ),
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Wallpapers.wallpapers_path[6],
                                        ontap: null),
                                  ),
                                ],
                              ),
                              onTap: () {
                                print("Wallpapers Clicked");
                                facebookAppEvents.logEvent(
                                  name: "Wallpaper List",
                                  parameters: {
                                    'button_id': 'wallpaper_button',
                                  },
                                );
                                AdService.context = context;
                                AdService.interstitialTag = "wallpaper";
                                AdService.showInterstitialAd();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Wallpapers End
                  Divider(),
                  //Stickers Start
                  DesignerContainer(
                    isLeft: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("New Year Stickers",
                              style: Theme.of(context).textTheme.headline1),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Stickers.stickers_path[7],
                                        ontap: null),
                                  ),
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Stickers.stickers_path[3],
                                        ontap: null),
                                  ),
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Stickers.stickers_path[4],
                                        ontap: null),
                                  ),
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Stickers.stickers_path[6],
                                        ontap: null),
                                  ),
                                ],
                              ),
                              onTap: () {
                                print("Stickers Clicked");
                                facebookAppEvents.logEvent(
                                  name: "Stickers List",
                                  parameters: {
                                    'button_id': 'sticker_button',
                                  },
                                );
                                AdService.context = context;
                                AdService.interstitialTag = "sticker";
                                AdService.showInterstitialAd();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Stickers End

                  Divider(),
                  // Quotes Start
                  DesignerContainer(
                    isLeft: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("New Year Quotes",
                              style: Theme.of(context).textTheme.headline1),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: InkWell(
                            child: Container(
                              width: size.width - SizeConfig.width(16),
                              height: size.width / 2,
                              decoration: BoxDecoration(
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.dark
                                        ? Theme.of(context).primaryColorDark
                                        : Colors.pink[900],
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(SizeConfig.height(20)),
                                  topRight:
                                      Radius.circular(SizeConfig.height(20)),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 4,
                                      color: Colors.grey),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Icon(Icons.format_quote,
                                      color: Theme.of(context)
                                          .primaryIconTheme
                                          .color),
                                  Positioned(
                                    top: 20,
                                    width: size.width - SizeConfig.width(16),
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(SizeConfig.width(8)),
                                        child: Text(
                                          Quotes.quotes_data[3],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    right: 0,
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(SizeConfig.width(8)),
                                        child: Text(
                                          "Tap Here to Continue",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.yellow[700]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              print("Quotes Clicked");
                              interstitialTag = "quotes";
                              facebookAppEvents.logEvent(
                                name: "Quotes List",
                                parameters: {
                                  'button_id': 'Quotes_button',
                                },
                              );
                              //AdService.goTo(context, interstitialTag);
                              AdService.context = context;
                              AdService.interstitialTag = "quotes";
                              AdService.showInterstitialAd();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Quotes End
                  Divider(),

                  //banner
                  Container(
                    height: bannerAd2.size.height.toDouble(),
                    width: bannerAd2.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd2),
                  ),
                  //banner
                  Divider(),

                  //Gifs Start
                  DesignerContainer(
                    isLeft: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("New Year Gifs",
                              style: Theme.of(context).textTheme.headline1),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Gifs.gifs_path[0],
                                        ontap: null),
                                  ),
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Gifs.gifs_path[3],
                                        ontap: null),
                                  ),
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Gifs.gifs_path[4],
                                        ontap: null),
                                  ),
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Gifs.gifs_path[6],
                                        ontap: null),
                                  ),
                                ],
                              ),
                              onTap: () {
                                print("Gifs Clicked");
                                interstitialTag = "gif";
                                facebookAppEvents.logEvent(
                                  name: "GIF List",
                                  parameters: {
                                    'button_id': 'gif_button',
                                  },
                                );
                                AdService.context = context;
                                AdService.interstitialTag = "gif";
                                AdService.showInterstitialAd();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Gifs End

                  Divider(),

                  //Image Start
                  DesignerContainer(
                    isLeft: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("New Year Wishes Images",
                              style: Theme.of(context).textTheme.headline1),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Images.images_path[7],
                                        ontap: null),
                                  ),
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Images.images_path[6],
                                        ontap: null),
                                  ),
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Images.images_path[13],
                                        ontap: null),
                                  ),
                                  IgnorePointer(
                                    child: CustomFeatureCard(
                                        size: size,
                                        imageUrl: Images.images_path[12],
                                        ontap: null),
                                  ),
                                ],
                              ),
                              onTap: () {
                                print("Images Clicked");
                                interstitialTag = "image";
                                facebookAppEvents.logEvent(
                                  name: "Image List",
                                  parameters: {
                                    'button_id': 'Image_button',
                                  },
                                );
                                AdService.context = context;
                                AdService.interstitialTag = "image";
                                AdService.showInterstitialAd();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Image End

                  Divider(),
                  //banner
                  Container(
                    height: bannerAd3.size.height.toDouble(),
                    width: bannerAd3.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd3),
                  ),
                  //banner
                  Divider(),
                  // Wish Creator Start
                  InkWell(
                    child: DesignerContainer(
                      isLeft: false,
                      child: IgnorePointer(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(SizeConfig.width(8)),
                              child: Text("Generate New Year Cards",
                                  style: Theme.of(context).textTheme.headline1),
                            ),
                            Padding(
                              padding: EdgeInsets.all(SizeConfig.width(8)),
                              child: CustomBannerWidget(
                                size: MediaQuery.of(context).size,
                                imagePath: Gifs.gifs_path[26],
                                buttonText: "Generate Greeting",
                                topText: "Send New Year",
                                middleText: "Wishes & E-Cards",
                                bottomText: "Share it With Your Loved Ones",
                                ontap: null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      print("Meme Clicked");
                      interstitialTag = "meme";
                      facebookAppEvents.logEvent(
                        name: "Meme Generator",
                        parameters: {
                          'button_id': 'meme_button',
                        },
                      );
                      //AdService.goTo(context, interstitialTag);
                      AdService.context = context;
                      AdService.interstitialTag = "meme";
                      AdService.showInterstitialAd();
                    },
                  ),
                  // Wish Creator End

                  Divider(),

                  // Status Start
                  InkWell(
                      child: DesignerContainer(
                        isLeft: true,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(SizeConfig.width(8)),
                              child: Text("New Year Status Wishes",
                                  style: Theme.of(context).textTheme.headline1),
                            ),
                            Padding(
                              padding: EdgeInsets.all(SizeConfig.width(8)),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IgnorePointer(
                                      child: CustomFBTextWidget(
                                        size: size,
                                        text: Status.status_data[2],
                                        color: Colors.orange[900],
                                        url: Images.images_path[1],
                                        isLeft: false,
                                        ontap: null,
                                      ),
                                    ),
                                    SizedBox(width: SizeConfig.width(8)),
                                    IgnorePointer(
                                      child: CustomFBTextWidget(
                                        size: size,
                                        text: Status.status_data[3],
                                        color: Colors.blue,
                                        url: Images.images_path[1],
                                        isLeft: false,
                                        ontap: null,
                                      ),
                                    ),
                                    SizedBox(width: SizeConfig.width(8)),
                                    IgnorePointer(
                                      child: CustomFBTextWidget(
                                        size: size,
                                        text: Status.status_data[4],
                                        color: Colors.indigoAccent,
                                        url: Images.images_path[1],
                                        isLeft: false,
                                        ontap: null,
                                      ),
                                    ),
                                    SizedBox(width: SizeConfig.width(8)),
                                    IgnorePointer(
                                      child: CustomFBTextWidget(
                                        size: size,
                                        text: Status.status_data[1],
                                        color: Colors.purple,
                                        url: Images.images_path[1],
                                        isLeft: false,
                                        ontap: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        print("Status Clicked");
                        interstitialTag = "status";
                        facebookAppEvents.logEvent(
                          name: "Status List",
                          parameters: {
                            'button_id': 'Status_button',
                          },
                        );
                        AdService.context = context;
                        AdService.interstitialTag = "status";
                        AdService.showInterstitialAd();
                      }),

                  //Status End

                  Divider(),

                  InkWell(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(SizeConfig.width(8)),
                            child: Text("Play Game \"Sell Rakhi\"",
                                style: Theme.of(context).textTheme.headline1),
                          ),
                          IgnorePointer(
                            child: CustomFullCard(
                              size: MediaQuery.of(context).size,
                              imageUrl: "lib/assets/rakhi_game.jpeg",
                              ontap: () {},
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        if (Platform.isAndroid) {
                          // Android-specific code
                          print("More Button Clicked");
                          launch(
                              "https://play.google.com/store/apps/developer?id=Festival+Messages+SMS");
                        } else if (Platform.isIOS) {
                          // iOS-specific code
                          print("More Button Clicked");
                          launch(
                              "https://apps.apple.com/us/app/-/id1434054710");

                          facebookAppEvents.logEvent(
                            name: "Play Rakshabandhan Game",
                            parameters: {
                              'clicked_on_play_rakshabandhan_game': 'Yes',
                            },
                          );
                        }
                      }),

                  Divider(),

                  Padding(
                    padding: EdgeInsets.all(SizeConfig.width(8)),
                    child: Text("Apps From Developer",
                        style: Theme.of(context).textTheme.headline1),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Row(
                        children: <Widget>[
                          //Column1
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is1-ssl.mzstatic.com/image/thumb/Purple117/v4/8f/e7/b5/8fe7b5bc-03eb-808c-2b9e-fc2c12112a45/mzl.jivuavtz.png/292x0w.jpg",
                                  appTitle: "Good Morning Images & Messages",
                                  appUrl:
                                      "https://apps.apple.com/us/app/good-morning-images-messages-to-wish-greet-gm/id1232993917"),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/44/e0/fd/44e0fdb5-667b-5468-7b2f-53638cba539e/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg",
                                  appTitle: "Birthday Status Wishes Quotes",
                                  appUrl:
                                      "https://apps.apple.com/us/app/birthday-status-wishes-quotes/id1522542709"),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/1a/58/a4/1a58a480-a0ae-1940-2cf3-38524430f66b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                  appTitle: "Astrology Horoscope Lal Kitab",
                                  appUrl:
                                      "https://apps.apple.com/us/app/astrology-horoscope-lal-kitab/id1448343526"),
                            ],
                          ),
                          SizedBox(width: SizeConfig.width(3)),
                          //Column2
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/e9/96/64/e99664d3-1083-5fac-6a0c-61718ee209fd/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                  appTitle: "Weight Loss My Diet Coach Tips",
                                  appUrl:
                                      "https://apps.apple.com/us/app/weight-loss-my-diet-coach-tips/id1448343218"),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is2-ssl.mzstatic.com/image/thumb/Purple127/v4/5f/7c/45/5f7c45c7-fb75-ea39-feaa-a698b0e4b09e/pr_source.jpg/292x0w.jpg",
                                  appTitle: "English Speaking Course Grammar",
                                  appUrl:
                                      "https://apps.apple.com/us/app/english-speaking-course-learn-grammar-vocabulary/id1233093288"),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/50/ad/82/50ad82d9-0d82-5007-fcdd-cc47c439bfd0/AppIcon-0-1x_U007emarketing-0-85-220-10.png/292x0w.jpg",
                                  appTitle: "English Hindi Language Diction",
                                  appUrl:
                                      "https://apps.apple.com/us/app/english-hindi-language-diction/id1441243874"),
                            ],
                          ),
                          SizedBox(width: SizeConfig.width(3)),
                          //Column3

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /*AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is3-ssl.mzstatic.com/image/thumb/Purple118/v4/17/f5/0c/17f50c4d-431b-72c6-b9f4-d1706da59394/AppIcon-0-1x_U007emarketing-0-0-85-220-7.png/292x0w.jpg",
                                  appTitle: "Celebrate Happy New Year 2019",
                                  appUrl:
                                      "https://apps.apple.com/us/app/celebrate-happy-new-year-2019/id1447735210"),
                              Divider(),*/
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/79/1e/61/791e61de-500c-6c97-3947-8abbc6b887e3/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                  appTitle: "Bangladesh Passport Visa Biman",
                                  appUrl:
                                      "https://apps.apple.com/us/app/bangladesh-passport-visa-biman/id1443074171"),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/dd/34/c3/dd34c3e8-5c9f-51aa-a3eb-3a203f5fd49b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-10.png/292x0w.jpg",
                                  appTitle: "Complete Spoken English Course",
                                  appUrl:
                                      "https://apps.apple.com/us/app/complete-spoken-english-course/id1440118617"),
                            ],
                          ),
                          SizedBox(width: SizeConfig.width(3)),

                          //Column4
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/bd/00/ee/bd00ee3b-43af-6b07-62a6-28c68373a8b5/AppIcon-1x_U007emarketing-85-220-0-9.png/292x0w.jpg",
                                  appTitle:
                                      "Happy Thanksgiving Day Greeting SMS",
                                  appUrl:
                                      "https://apps.apple.com/us/app/happy-merry_christmas-greeting-sms/id1435157874"),
                              Divider(),
                              /*AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is4-ssl.mzstatic.com/image/thumb/Purple91/v4/f0/84/d7/f084d764-79a8-f6d1-3778-1cb27fabb8bd/pr_source.png/292x0w.jpg",
                                  appTitle: "Egg Recipes 100+ Recipes",
                                  appUrl:
                                      "https://apps.apple.com/us/app/egg-recipes-100-recipes-collection-for-eggetarian/id1232736881"),
                              Divider(),*/
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is1-ssl.mzstatic.com/image/thumb/Purple114/v4/0f/d6/f4/0fd6f410-9664-94a5-123f-38d787bf28c6/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg",
                                  appTitle: "Rakshabandhan Images Greetings",
                                  appUrl:
                                      "https://apps.apple.com/us/app/rakshabandhan-images-greetings/id1523619788"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

class DesignerContainer extends StatelessWidget {
  const DesignerContainer({
    Key? key,
    required this.child,
    required this.isLeft,
  }) : super(key: key);

  final Widget child;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isLeft
          ? BoxDecoration(
              color: Colors.yellow[700],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(SizeConfig.height(20)),
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0), blurRadius: 4, color: Colors.grey),
              ],
            )
          : BoxDecoration(
              color: Colors.pink[400],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(SizeConfig.height(20)),
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0), blurRadius: 4, color: Colors.grey),
              ],
            ),
      child: child,
    );
  }
}

class CustomHeader1 extends StatelessWidget {
  const CustomHeader1({
    Key? key,
    this.headerText,
    this.imagePath,
    this.descriptionText,
  }) : super(key: key);

  final String? headerText, imagePath, descriptionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 3 * SizeConfig.widthMultiplier,
        bottom: 10 * SizeConfig.widthMultiplier,
        left: 10 * SizeConfig.widthMultiplier,
        right: 10 * SizeConfig.widthMultiplier,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryVariant,
        borderRadius: BorderRadius.only(
          //30
          bottomRight: Radius.circular(MediaQuery.of(context).size.width),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    headerText!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    width: 1.93 * SizeConfig.widthMultiplier,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(imagePath!),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 2 * SizeConfig.heightMultiplier,
          ),
          Text(
            descriptionText!,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class AppStoreAppsItemWidget1 extends StatelessWidget {
  const AppStoreAppsItemWidget1({
    Key? key,
    this.imageUrl,
    this.appUrl,
    this.appTitle,
  }) : super(key: key);

  final String? imageUrl, appUrl, appTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(SizeConfig.width(16))),
            child: Padding(
              padding: EdgeInsets.only(right: SizeConfig.width(3)),
              child: CachedNetworkImage(
                height: SizeConfig.height(80),
                width: SizeConfig.width(80),
                imageUrl: imageUrl!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fadeOutDuration: const Duration(seconds: 1),
                fadeInDuration: const Duration(seconds: 3),
              ),
            ),
          ),
          Text(
            appTitle!,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () {
        launch(appUrl!);
      },
    );
  }
}
