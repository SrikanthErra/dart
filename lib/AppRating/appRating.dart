import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:medicineinventory/AppRating/page/rate_comment_page.dart';
import 'package:medicineinventory/AppRating/page/rate_dialog_page.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import '../Constants/assetsPath.dart';
import 'page/rate_stars_page.dart';
import 'widget/rate_app_init_widget.dart';
import 'widget/tabbar_widget.dart';

class AppRating extends StatefulWidget {
  final RateMyApp rateMyApp;

  const AppRating({super.key, required this.rateMyApp});
  @override
  _AppRatingState createState() => _AppRatingState();
}

class _AppRatingState extends State<AppRating> {
  String comment = '';
  @override
  Widget build(BuildContext context) {
    return RateAppInitWidget(
      builder: (RateMyApp) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetPath.Background),
              fit: BoxFit.cover,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: TabBarWidget(
              tabs: [
                Tab(icon: Icon(Icons.open_in_full), text: 'Dialog'),
                Tab(icon: Icon(Icons.rate_review), text: 'Comment'),
                Tab(icon: Icon(Icons.star_rate_sharp), text: 'Stars'),
              ],
              title: strings.AppTitle,
              children: [
                RateDialogPage(rateMyApp: widget.rateMyApp),
                RateCommentPage(rateMyApp: widget.rateMyApp),
                RateStarsPage(rateMyApp: widget.rateMyApp),
              ],
            ),
          ),
        ),
        bottomSheet: Image.asset(
          AssetPath.footer,
          width: double.infinity,
          height: 40,
        ),
      ),
    );
  }
}
