import 'package:flutter/material.dart';

import 'package:nuha/app/constant/styles.dart';
// import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
// import '../controllers/zis_controller.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ZisView extends StatefulWidget {
  const ZisView({super.key});

  @override
  State<ZisView> createState() => _ZisViewState();
}

class _ZisViewState extends State<ZisView> {
  InAppWebViewController? _con;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      // bottomNavigationBar: NavbarView(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.875.h),
        child: AppBar(
          // titleSpacing: 8.055556.w,
          title: Center(
            child: Text(
              "Nuha x RumahZakat",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: titleColor),
            ),
          ),
          backgroundColor: backgroundColor1,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: dark,
          ),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
              'https://www.rumahzakat.org/donasi?source=1042020001001'),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
            useOnLoadResource: true,
          ),
        ),
        onWebViewCreated: (controller) {
          _con = controller;
          _con?.loadUrl(
              urlRequest: URLRequest(
            url: Uri.parse(
                'https://www.rumahzakat.org/donasi?source=1042020001001'),
            headers: {
              'Content-Security-Policy': 'zoom: 0.9', // Set zoom level to 90%
            },
          ));
        },
      ),
    );
  }
}
