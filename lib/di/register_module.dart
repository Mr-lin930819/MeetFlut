import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  Dio get dio => Dio()
    ..interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
      handler.resolve(response);
    }, onRequest: (options, handler) {
      print(options.uri);
      handler.next(options);
    }));
}
