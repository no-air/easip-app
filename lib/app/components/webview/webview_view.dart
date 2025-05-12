import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'webview_controller.dart';

class WebviewView extends GetView<WebViewController> {
  WebviewView({super.key});

  final c = Get.find<WebViewController>();

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("urls: ${c.urls.value}");
    }

    return SafeArea(
      child: InAppWebView(
        webViewEnvironment: c.webViewEnvironment.value,
        initialUrlRequest: URLRequest(url: WebUri(c.urls.value)),
        initialSettings: InAppWebViewSettings(
          isInspectable: kDebugMode,
          mediaPlaybackRequiresUserGesture: false,
          allowsInlineMediaPlayback: true,
          iframeAllow: "camera; microphone",
          iframeAllowFullscreen: true,
        ),
        onWebViewCreated: (controller) {
          if (c.webViewController.value == null) {
            c.webViewController.value = controller;
          }

          c.webViewController.value?.loadUrl(
            urlRequest: URLRequest(url: WebUri(c.urls.value)),
          );
        },
        onPermissionRequest: (controller, request) async {
          return PermissionResponse(
            resources: request.resources,
            action: PermissionResponseAction.GRANT,
          );
        },
      ),
    );
  }
}
