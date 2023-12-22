import 'dart:io';

import 'package:clicker/gui/widgets/main_screen_widgets/click_screen_widgets/click_screen_widget.dart';
import 'package:clicker/gui/widgets/main_screen_widgets/webview_screen_widget/webview_screen_container.dart';
import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  late Future<bool> _internetFuture;
  @override
  void initState() {
    _internetFuture = internet();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: FutureBuilder(
        future: _internetFuture,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
            if(snapshot.data == true) {
              return WebViewScreenWidget();
            } else {
              return const ClickScreenWidget();
            }
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<bool> internet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}