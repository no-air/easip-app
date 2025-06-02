import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class Webview extends StatefulWidget {
  final String url;
  final bool isSafeArea;

  const Webview({required this.url, this.isSafeArea = true, super.key});

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  @override
  Widget build(BuildContext context) {
    final String url = widget.url;
    final bool isSafeArea = widget.isSafeArea;

    void onWebViewCreated(InAppWebViewController webViewController) {
      webViewController.addJavaScriptHandler(
        handlerName: "goToPage",
        callback: (args) async {
          if (args.isEmpty || args[0] == null) {
            return;
          }
          if (args[0] is String && args[0].toString().startsWith('http')) {
            Get.to(Webview(url: args[0] as String, isSafeArea: isSafeArea));
            return;
          }
          Get.toNamed(args[0] as String);
        },
      );
      webViewController.addJavaScriptHandler(
        handlerName: "goBack",
        callback: (args) async {
          Get.back();
        },
      );
    }

    if (url.isEmpty) {
      return const Center(child: Text("No URL provided"));
    }

    if (kDebugMode) {
      print('Webview URL: $url');
    }

    return Container(
      color: Colors.white,
      child: SafeArea(
        top: isSafeArea,
        bottom: isSafeArea,
        child: InAppWebView(
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            cacheEnabled: true,
            clearCache: true,
          ),
          onWebViewCreated: onWebViewCreated,
          onConsoleMessage: (_, consoleMessage) {
            if (kDebugMode) {
              print(
                '🌐 WebView Console: [${consoleMessage.messageLevel}] ${consoleMessage.message}',
              );
            }
          },
          initialUrlRequest: URLRequest(url: WebUri(url)),
        ),
      ),
    );
  }
}
