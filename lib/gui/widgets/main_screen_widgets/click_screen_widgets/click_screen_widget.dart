import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/score_data_model.dart';


class ClickScreenWidget extends StatefulWidget {
  const ClickScreenWidget({super.key});

  @override
  State<ClickScreenWidget> createState() => _ClickScreenWidgetState();
}


class _ClickScreenWidgetState extends State<ClickScreenWidget>
    with SingleTickerProviderStateMixin{
  late AnimationController _controller;

  @override
  void initState() {
    Future.delayed(Duration.zero, () => _showAlertDialog());
    context.read<ScoreDataModel>().initScoreData();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 18, 18),
          title: Image.asset(
            'assets/images/logos/appbar_logo.png',
            width: 120,
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                '${context.watch<ScoreDataModel>().getScore().toString()} ETH',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 43, 43, 43)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 70),
              child: Text(
                'Нажмите на видеокарту, чтобы заработать ${context.watch<ScoreDataModel>().getCurrentCard().id + 1} ETH',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 380,
              width: 380,
              child: InkWell(
                onTap: () {
                  _controller.forward();
                  Future.delayed(const Duration(milliseconds: 200), () {
                    context.read<ScoreDataModel>().updateScoreOnCardClick();
                    _controller.reverse();
                  });
                },
                borderRadius: BorderRadius.circular(300),
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 1.0,
                    end: 0.96,
                  ).animate(_controller),
                  child: item(context),
                ),
              )
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 80),
              child: ElevatedButton(
                onPressed: () {
                  context.read<ScoreDataModel>().updateCard(context);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    backgroundColor: Colors.red,
                    minimumSize: const Size(300, 50)
                ),
                child: Text(
                  'Улучшить за ${context.watch<ScoreDataModel>().getCurrentCard().price} ETN',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget item(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300),
          color: const Color.fromARGB(255, 18, 18, 18),
          border: Border.all(
              width: 3,
              color: Colors.red
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF0000).withAlpha(60),
              blurRadius: 40.0,
              spreadRadius: 0.0,
              offset: const Offset(0.0, 3.0,),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: Image.asset(
            context.watch<ScoreDataModel>().getCurrentCard().imageRef,
            alignment: Alignment.center,
            height: 380,
            width: 380,
          ),
        )
      ),
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ошибка подключения'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Проверьте подключение к интернету.'),
                Text('Пока Вы не в сети, вам'),
                Text('доступна Игра-кликер.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Ок',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


SnackBar getSnackBar(String snackBarMessage) {

  final snackBar = SnackBar(
    content: Center(
      child: Text(
          snackBarMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Colors.white),
          textDirection: TextDirection.ltr
      ),
    ),
    duration: const Duration(milliseconds: 1500),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(100),
      ),
    ),
    backgroundColor: Colors.black54,
    margin: const EdgeInsets.only(left: 110, right: 110, bottom: 130),
  );

  return snackBar;
}


void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .removeCurrentSnackBar();
  ScaffoldMessenger.of(context)
      .showSnackBar(
      getSnackBar(message));
}