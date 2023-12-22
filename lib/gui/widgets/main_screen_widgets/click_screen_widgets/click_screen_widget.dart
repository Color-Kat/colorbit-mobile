import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/score_data_model.dart';


class ClickScreenWidget extends StatefulWidget {
  const ClickScreenWidget({super.key});

  @override
  State<ClickScreenWidget> createState() => _ClickScreenWidgetState();
}


class _ClickScreenWidgetState extends State<ClickScreenWidget> {

  @override
  void initState() {
    Future.delayed(Duration.zero, () => _showAlertDialog());
    context.read<ScoreDataModel>().initScoreData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 18, 18),
          title: const Text(
            'COLOR bit',
            style: TextStyle(
              color: Colors.red,
              fontFamily: "Inter-Black",
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                '${context.watch<ScoreDataModel>().getScore().toString()} ETH',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20
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
          children: [
            Expanded(
              flex: 30,
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Нажмите на видеокарту, чтобы заработать 1 ETH',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ),
            Expanded(
              flex: 80,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: item(context)
              )
            ),
            Expanded(
                flex: 30,
                child: Container(
                  alignment: Alignment.center,
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
                    child: const Text(
                      'Улучшить',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget item(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          context.read<ScoreDataModel>().updateScoreOnCardClick();
        },
        splashColor: Colors.white,
        borderRadius: BorderRadius.circular(300),
        child: Container(
          width: 400,
          height: 400,
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
          child: Image.asset(
            context.watch<ScoreDataModel>().getCurrentCard().imageRef,
            fit: BoxFit.contain,
          ),
        ),
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
                Text('Кажется ваше устройство находится не в сети.'),
                Text('Проверьте подключение к интернету и перезапустите приложение.'),
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
    margin: const EdgeInsets.only(left: 110, right: 110, bottom: 120),
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