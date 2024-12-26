import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'QuotesList.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';
import 'AboutUs.dart';
import 'HomePage.dart';
import 'ImagesList.dart';
import 'MessagesList.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  //\nUrl: ${AppUrl()}
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              currentAccountPicture: CircleAvatar(
                radius: 19 * SizeConfig.widthMultiplier,
                backgroundImage: const NetworkImage(
                    'https://pbs.twimg.com/profile_images/1158115409993691138/wABb5ZLe_400x400.jpg'),
                backgroundColor: Theme.of(context).primaryIconTheme.color,
              ),
              accountName: const Text(Strings.accountName),
              accountEmail: const Text(Strings.accountEmail),
            ),
            Container(
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.home,
                          color: Theme.of(context).primaryIconTheme.color),
                      title: const Text("Home Page"),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryIconTheme.color),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()));
                      }),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.format_quote,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: const Text("Quotes"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => QuotesList()));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.image,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: const Text("Images"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => ImagesList()));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.info,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: const Text("About Developer"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () {
                      //interstitialTag = "about";
                      Navigator.of(context).pop();

                      //_interstitialAd.isLoaded() != null
                      //  ? _interstitialAd?.show()
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => AboutUs()));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.feedback,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: const Text("Submit Feedback"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () async {
                      Navigator.of(context).pop();
                      print("Feedback Button Clicked");

                      if (await canLaunch(Strings.mailContent)) {
                        await launch(Strings.mailContent);
                      } else {
                        throw 'Could not launch $Strings.mailContent';
                      }
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.more,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: const Text("Other Apps"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () {
                      Navigator.of(context).pop();
                      print("More Button Clicked");
                      launch(Strings.accountUrl);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.rate_review,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: const Text("Rate This App"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () {
                      Navigator.of(context).pop();
                      //launch(Strings.appUrl);
                      Strings.RateNReview();
                    },
                  ),
                  const Divider(),
                  ListTile(
                      leading: Icon(Icons.share,
                          color: Theme.of(context).primaryIconTheme.color),
                      title: const Text("Share App"),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryIconTheme.color),
                      onTap: () {
                        print("Share Button Clicked");
                        Navigator.of(context).pop();
                        final RenderBox box =
                            context.findRenderObject() as RenderBox;
                        Share.share(
                          Strings.shareAppText,
                          sharePositionOrigin:
                              box.localToGlobal(Offset.zero) & box.size,
                        );
                      }),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.close,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: const Text("Close"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
