import 'dart:io';

import 'package:colorbitmining/gui/widgets/main_screen_widgets/click_screen_widgets/click_screen_widget.dart';
import 'package:colorbitmining/gui/widgets/main_screen_widgets/webview_screen_widget/webview_screen_container.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  Widget? screen;
  late final listener;

  @override
  void initState() {
    listener = InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          setState(() {
            screen = WebViewScreenWidget();
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            screen = const ClickScreenWidget();
          });
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if(screen == null) {
      return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 43, 43, 43),
        ),
        child: const CircularProgressIndicator()
      );
    } else {
      return screen!;
    }
  }
}