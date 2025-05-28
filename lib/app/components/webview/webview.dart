import 'dart:developer';

import 'package:easip_app/app/routes/app_routes.dart';
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
          Get.toNamed(Routes.initial);

          return {'status': 'success', 'received_args': args};
        },
      );
    }

    void onLoadStop(InAppWebViewController controller, WebUri? url) async {
      log('Page finished loading: $url');
      try {
        await controller.evaluateJavascript(
          source: """
        if (!window.flutter) {
          window.flutter = true;
          console.log('Flutter environment enabled via evaluateJavascript.');
        } else {
          console.error('useFlutterStore or its actions not found on window.');
        }
      """,
        );
      } catch (e) {
        if (kDebugMode) {
          print("Error calling setIsFlutterEnabled: $e");
        }
      }
    }

    if (url.isEmpty) {
      return const Center(child: Text("No URL provided"));
    }

    if (kDebugMode) {
      print('Webview URL: $url');
    }

    return SafeArea(
      top: isSafeArea,
      bottom: isSafeArea,
      child: InAppWebView(
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          cacheEnabled: true,
          clearCache: true,
        ),
        onWebViewCreated: onWebViewCreated,
        onLoadStop: onLoadStop,
        onConsoleMessage: (_, consoleMessage) {
          if (kDebugMode) {
            print(
              '🌐 WebView Console: [${consoleMessage.messageLevel}] ${consoleMessage.message}',
            );
          }
        },
        initialUrlRequest: URLRequest(url: WebUri(url)),
      ),
    );
  }
}
