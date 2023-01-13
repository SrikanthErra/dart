import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Constants/TextStyles.dart';
import '../Constants/urlConstant.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class privacyPolicy extends StatefulWidget {
  const privacyPolicy({super.key});

  @override
  State<privacyPolicy> createState() => _privacyPolicyState();
}

class _privacyPolicyState extends State<privacyPolicy> {
  /* final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
  Factory(() => EagerGestureRecognizer())
}; */
  final pageUrl1 =
      UrlConstants.baseUrlPrivacyPolicy + UrlConstants.PrivacyPolicyExtension;
  final pageUrl2 = UrlConstants.baseUrlTermsAndConditions +
      UrlConstants.TermsAndConditionsExtension;
  final pageUrl3 =
      UrlConstants.baseUrlCopyRights + UrlConstants.CopyRightsExtension;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          strings.PrivacyPolicyTitle,
          style: subHeaderStyle,
        ),
        centerTitle: true,
        //backgroundColor: Colors.green[900],
      ),
      body: Container(
        color: Colors.transparent,
        child: ContainedTabBarView(
          tabs: [
            Text(
              strings.Sidemenu_privacyPolicy,
              style: WhitePageText,
            ),
            Text(
              strings.privacyPolicy_TandC,
              style: WhitePageText,
            ),
            Text(
              strings.privacyPolicy_CopyRight,
              style: WhitePageText,
            )
          ],
          views: [
            Container(
              child: WebView(
                initialUrl: Uri.parse(pageUrl1).toString(),
                javascriptMode: JavascriptMode.unrestricted,
                // gestureRecognizers: gestureRecognizers,
                gestureRecognizers: Set()
                  ..add(
                    Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer(),
                    ), // or null
                  ),
              ),
            ),
            Container(
              child: WebView(
                initialUrl: Uri.parse(pageUrl2).toString(),
                javascriptMode: JavascriptMode.unrestricted,
                //  gestureRecognizers: gestureRecognizers,
                gestureRecognizers: Set()
                  ..add(
                    Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer(),
                    ), // or null
                  ),
              ),
            ),
            Container(
              child: WebView(
                initialUrl: Uri.parse(pageUrl3).toString(),
                javascriptMode: JavascriptMode.unrestricted,
                // gestureRecognizers: gestureRecognizers,
                gestureRecognizers: Set()
                  ..add(
                    Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer(),
                    ), // or null
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
