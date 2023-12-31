import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreenWidget extends StatelessWidget {
  WebViewScreenWidget({super.key});

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://colorbit.ru'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if(await controller.canGoBack()) {
            controller.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
