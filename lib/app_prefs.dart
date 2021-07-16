import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AppPrefs {
  Future<SharedPreferences> get _pref => GetIt.I.getAsync();

  AppPrefs();

  Future<bool> showVideoGuide() =>
      _pref.then((value) => value.getBool("show_video_guide") ?? true);

  void setShowVideoGuide(bool value) async{
    (await _pref).setBool("show_video_guide", value);
  }
}
