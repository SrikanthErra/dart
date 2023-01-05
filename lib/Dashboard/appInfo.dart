import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:side_menu/Constants/StringConstants.dart';
import '../Constants/TextStyles.dart';
import '../Constants/appColor.dart';
import '../Constants/assetsPath.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({super.key});

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
    installerStore: '',
  );
  //String VersionNumber = "";
  @override
  Widget build(BuildContext context) {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      packageInfo.appName;
      packageInfo.packageName;
      packageInfo.version;
      packageInfo.buildNumber;
    });
    return Scaffold(
      bottomSheet: Image.asset(
        AssetPath.footer,
        width: double.infinity,
        height: 40,
      ),
      appBar: AppBar(
        title: Text(
          strings.AppInfoTitle,
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
          //alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Image(
                    height: 100,
                    width: 100,
                    image: AssetImage(AssetPath.AppLogo)),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _packageInfo.appName,
                      style: TitleStyle,
                    ),
                    Text(
                      _packageInfo.version,
                      style: headerTextsStyle,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, right: 10, left: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                              BorderSide(color: AppColors.Navybluish, width: 1),
                        ),
                        //elevation: 10.0,
                        shadowColor: AppColors.navy,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            strings.AppDescription,
                            maxLines: 8,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //getVersion();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

/*   getVersion() async {
    await appVersion().getAppVersion().then((value) {
      setState(() {
        VersionNumber = value;
      });
    });
  } */
}

/* class appVersion {
  Future<dynamic> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionValue = packageInfo.version;
    return versionValue;
  }
} */
