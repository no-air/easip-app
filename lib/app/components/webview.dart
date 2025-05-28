import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class Webview extends GetView {
  final String url;
  final bool isSafeArea;

  const Webview({super.key, this.url = "", this.isSafeArea = true});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: isSafeArea,
      child: InAppWebView(
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          cacheEnabled: true,
          clearCache: true,
        ),
        initialUrlRequest: URLRequest(
          url: WebUri('${dotenv.env['WEBVIEW_URL']}$url'),
        ),
      ),
    );
  }
}
