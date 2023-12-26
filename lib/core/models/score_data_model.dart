import 'package:colorbitmining/core/controllers/shared_preferences_controller.dart';
import 'package:colorbitmining/gui/widgets/main_screen_widgets/click_screen_widgets/click_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import '../../data/entities/video_card.dart';


class ScoreDataModel extends ChangeNotifier {
  int _score = 0;
  int _currentListIndex = 0;
  VideoCard _currentVideoCard = VideoCard(
    id: 0,
    name: 'AMD Radeon RX 550 Red Dragon',
    imageRef: 'assets/images/videocards/vc_0.png',
    price: 170,
  );
  final List<VideoCard> _videoCardList = [
    VideoCard(
      id: 0,
      name: 'AMD Radeon RX 550 Red Dragon',
      imageRef: 'assets/images/videocards/vc_0.png',
      price: 170,
    ),
    VideoCard(
      id: 1,
      name: 'MSI GeForce GTX 1630 AERO ITX',
      imageRef: 'assets/images/videocards/vc_1.png',
      price: 259,
    ),
    VideoCard(
      id: 2,
      name: 'Palit GeForce GTX 1660 SUPER Gaming Pro',
      imageRef: 'assets/images/videocards/vc_2.png',
      price: 311,
    ),
    VideoCard(
      id: 3,
      name: 'AMD Radeon RX 580 Red Dragon',
      imageRef: 'assets/images/videocards/vc_3.png',
      price: 488,
    ),
    VideoCard(
      id: 4,
      name: 'KFA2 GeForce RTX 3050 CORE',
      imageRef: 'assets/images/videocards/vc_4.png',
      price: 546,
    ),
    VideoCard(
      id: 5,
      name: 'GIGABYTE GeForce RTX 3050 EAGLE',
      imageRef: 'assets/images/videocards/vc_5.png',
      price: 631,
    ),
    VideoCard(
      id: 6,
      name: 'MSI GeForce RTX 2060 Super VENTUS OC',
      imageRef: 'assets/images/videocards/vc_6.png',
      price: 777,
    ),
    VideoCard(
      id: 7,
      name: 'Palit GeForce RTX 3060 DUAL',
      imageRef: 'assets/images/videocards/vc_7.png',
      price: 952,
    ),
    VideoCard(
      id: 8,
      name: 'INNO3D GeForce RTX 3060 Ti TWIN X2',
      imageRef: 'assets/images/videocards/vc_8.png',
      price: 1140,
    ),
    VideoCard(
      id: 9,
      name: 'ASUS TURBO GeForce RTX 3070',
      imageRef: 'assets/images/videocards/vc_9.png',
      price: 1499,
    ),
    VideoCard(
      id: 10,
      name: 'GIGABYTE Radeon RX 7900 XT GAMING',
      imageRef: 'assets/images/videocards/vc_10.png',
      price: 1719,
    ),
    VideoCard(
      id: 11,
      name: 'KFA2 GeForce RTX 4070 Ti ST',
      imageRef: 'assets/images/videocards/vc_11.png',
      price: 2499,
    ),
    VideoCard(
      id: 12,
      name: 'Palit GeForce RTX 4090 GameRock',
      imageRef: 'assets/images/videocards/vc_12.png',
      price: 3599,
    ),
  ];


  void updateScoreOnCardClick() {
    _score = _score + _currentListIndex + 1;
    SharedPreferencesController().setCurrentVideoCardData(_currentVideoCard, _score);
    notifyListeners();
  }


  void updateCard(BuildContext context) {
    if(_currentListIndex != _videoCardList.length - 1 && _score >= _currentVideoCard.price) {
      _currentListIndex++;
      _score = _score - _currentVideoCard.price;
      SharedPreferencesController().setCurrentVideoCardData(_currentVideoCard, _score);
    } else if(_currentListIndex != _videoCardList.length - 1) {
      showSnackBar(context, 'Недостаточно ETH');
    } else {
      showSnackBar(context, 'Вы достигли максимального уровня. Ваш прогресс сброшен.');
      _currentListIndex = 0;
      _score = 0;
    }
    _currentVideoCard = _videoCardList[_currentListIndex];
    notifyListeners();
  }


  VideoCard getCurrentCard() {
    return _currentVideoCard;
  }


  int getScore() {
    return _score;
  }


  Future initScoreData() async {
    VideoCard? videoCardData = await SharedPreferencesController().getCurrentVideoCardData();
    if(videoCardData != null) {
      _currentVideoCard = videoCardData;
      _currentListIndex = videoCardData.id;
    }
    int scoreData = await SharedPreferencesController().getScoreData();
    _score = scoreData;
    notifyListeners();
  }
}