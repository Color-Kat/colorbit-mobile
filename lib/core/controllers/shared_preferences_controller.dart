import '../../data/entities/video_card.dart';
import '../../data/get_data/from_device/from_shared_preferences.dart';


abstract class SharedPreferencesControllerInterface {
  setCurrentVideoCardData(VideoCard currentVideoCard, int score);
  getCurrentVideoCardData();
  getScoreData();
}


class SharedPreferencesController {
  final SharedPreferencesControllerInterface _controller = GetDataFromSharedPreferences();


  void setCurrentVideoCardData(VideoCard currentVideoCard, int score) {
    _controller.setCurrentVideoCardData(currentVideoCard, score);
  }


  Future getCurrentVideoCardData() async {
    return _controller.getCurrentVideoCardData();
  }


  Future getScoreData() async {
    return _controller.getScoreData();
  }
}