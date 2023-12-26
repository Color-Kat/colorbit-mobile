import 'package:colorbitmining/data/entities/video_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/controllers/shared_preferences_controller.dart';


class GetDataFromSharedPreferences extends SharedPreferencesControllerInterface {
  SharedPreferences? _sharedPreferences;


  Future<SharedPreferences> get sharedPreferences async {
    if(_sharedPreferences != null) {
      return _sharedPreferences!;
    } else {
      _sharedPreferences = await SharedPreferences.getInstance();
      return _sharedPreferences!;
    }
  }


  @override
  setCurrentVideoCardData(VideoCard currentVideoCard, int score) async {
    SharedPreferences sherPref = await sharedPreferences;
    await sherPref.setInt('id', currentVideoCard.id);
    await sherPref.setString('name', currentVideoCard.name);
    await sherPref.setString('imageRef', currentVideoCard.imageRef);
    await sherPref.setInt('price', currentVideoCard.price);
    await sherPref.setInt('score', score);
    print('сохранение данных');
  }


  @override
  Future getCurrentVideoCardData() async {
    SharedPreferences sherPref = await sharedPreferences;

    if(sherPref.getInt('id') == null) {
      return null;
    } else {
      print('id: ${sherPref.getInt('id').toString()}');
      return VideoCard(
        id: sherPref.getInt('id')!,
        name: sherPref.getString('name')!,
        imageRef: sherPref.getString('imageRef')!,
        price: sherPref.getInt('price')!,
      );
    }
  }


  @override
  Future getScoreData() async {
    SharedPreferences sherPref = await sharedPreferences;

    return sherPref.getInt('score') ?? 0;
  }

}