import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'data/AdService.dart';
import 'data/Gifs.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';
import 'GifDetailPage.dart';

class GifsImages extends StatefulWidget {
  @override
  _GifsImagesState createState() => _GifsImagesState();
}

class _GifsImagesState extends State<GifsImages> 
{
  var data = Gifs.gifs_path;
  late BannerAd bannerAd1;
  bool isBannerAdLoaded = false;
  @override
  void initState() {
    super.initState();
    bannerAd1 = GetBannerAd();
  }

  BannerAd GetBannerAd() {
    return BannerAd(
        size: AdSize.largeBanner,
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
    bannerAd1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gif Images",
          style: Theme.of(context).appBarTheme.toolbarTextStyle,
        ),
      ),
      body: SafeArea(
        child: data != null
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Padding(
                      //8.0
                      padding:
                          EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),

                      child: ListTile(
                        title: CachedNetworkImage(
                          imageUrl: data[index],
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fadeOutDuration: const Duration(seconds: 1),
                          fadeInDuration: const Duration(seconds: 3),
                        ),
                      ),
                    ),
                    onTap: () {
                      print("Click on Gif Grid item $index");
                      Navigator.push(
                          context,
                           MaterialPageRoute(
                              builder: (context) => GifDetailPage(index)));
                    },
                  );
                },
                itemCount: data.length,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: bannerAd1.size.height.toDouble(),
        width: bannerAd1.size.width.toDouble(),
        child: AdWidget(ad: bannerAd1),
      ),
    );
  }
}
