import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//mport 'package:webview_flutter/webview_flutter.dart';

class privacyPolicy extends StatefulWidget {
  const privacyPolicy({super.key});

  @override
  State<privacyPolicy> createState() => _privacyPolicyState();
}

class _privacyPolicyState extends State<privacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UAT-MedicineHomeInv"),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),
      body: Container(
        color: Colors.black.withOpacity(0.3),
        child: ContainedTabBarView(
          tabs: [
            Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 17),
            ),
            Text(
              """Terms and
              Conditions""",
              style: TextStyle(fontSize: 17),
            ),
            Text(
              "Copyright Policy",
              style: TextStyle(fontSize: 17),
            )
          ],
          views: [
            Container(
              child: WebView(
                initialUrl:
                    "https://www.cgg.gov.in/mgov-privacy-policy/?depot_name=" +
                        "AGRICULTURE and  FARMERS WELFARE, GOVERNMENT OF INDIA",
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
            Container(
              child: WebView(
                initialUrl:
                    "https://www.cgg.gov.in/mgov-terms-conditions/?depot_name=" +
                        "AGRICULTURE " +
                        "and" +
                        " FARMERS WELFARE, GOVERNMENT OF INDIA" +
                        "&" +
                        " capital=NEW DELHI, INDIA",
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
            Container(
              child: WebView(
                initialUrl:
                    "https://www.cgg.gov.in/mgov-copyright-policy/?depot_name=" +
                        "AGRICULTURE " +
                        "and" +
                        " FARMERS WELFARE, GOVERNMENT OF INDIA & depot_email=info@cgg.gov.in",
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
