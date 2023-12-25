import 'package:colorbit/core/models/score_data_model.dart';
import 'package:colorbit/gui/widgets/main_screen_widgets/main_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';


void main() async {


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScoreDataModel())
      ],
      child: const Application(),
    )
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: MainScreenWidget(),
      )
    );
  }
}
