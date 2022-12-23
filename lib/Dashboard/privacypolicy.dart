import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//mport 'package:webview_flutter/webview_flutter.dart';

class privacyPolicy extends StatefulWidget {
  const privacyPolicy({super.key});

  @override
  State<privacyPolicy> createState() => _privacyPolicyState();
}

class _privacyPolicyState extends State<privacyPolicy> {
  /* final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
  Factory(() => EagerGestureRecognizer())
}; */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UAT-MedicineHomeInv"),
        centerTitle: true,
       //backgroundColor: Colors.green[900],
      ),
      body: Container(
        color: Colors.transparent,
        child: ContainedTabBarView(
          tabs: [
            Text(
              "Privacy Policy",
              
              style: TextStyle(fontSize: 17,color: Colors.black),
            ),
            Text(
              "Terms and Conditions",
              style: TextStyle(fontSize: 17,color: Colors.black),
            ),
            Text(
              "Copyright Policy",
              style: TextStyle(fontSize: 17,color: Colors.black),
            )
          ],
          views: [
            Container(
              child: WebView(
                initialUrl:
                    "https://www.cgg.gov.in/mgov-privacy-policy/?depot_name=" +
                        "Centre for Good Governance (CGG), Govt. of Telangana",
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
                initialUrl:
                    "https://www.cgg.gov.in/mgov-terms-conditions/?depot_name=" +
                        "Centre for Good Governance (CGG), Govt. of Telangana&depot_email=info@cgg.gov.in",
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
                initialUrl:
                    "https://www.cgg.gov.in/mgov-copyright-policy/?depot_name=" +
                        "Centre for Good Governance (CGG), Govt. of Telangana&capital=Hyderabad, Telangana",
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
