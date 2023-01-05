import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:side_menu/Constants/StringConstants.dart';
import '../Constants/TextStyles.dart';
import '../Constants/assetsPath.dart';
import 'page/rate_stars_page.dart';
import 'widget/rate_app_init_widget.dart';

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
        appBar: AppBar(
          title: Text(
            strings.AppRatingTitle,
            style: subHeaderStyle,
          ),
          centerTitle: true,
          //backgroundColor: Color.fromARGB(0, 21, 91, 110),
        ),
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
            child: Column(
              children: [
                RateStarsPage(rateMyApp: widget.rateMyApp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
