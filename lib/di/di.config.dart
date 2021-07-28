// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../app_prefs.dart' as _i3;
import '../datasource/sohu_client.dart' as _i7;
import '../entry/video/album/sohu_album_detail_bloc.dart' as _i6;
import '../entry/video/channel/sohu_channel_bloc.dart' as _i8;
import 'register_module.dart' as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.AppPrefs>(() => _i3.AppPrefs());
  gh.factory<_i4.Dio>(() => registerModule.dio);
  gh.factoryAsync<_i5.SharedPreferences>(() => registerModule.prefs);
  gh.factory<_i6.SohuAlbumDetailBloc>(
      () => _i6.SohuAlbumDetailBloc(get<_i7.SohuClient>()));
  gh.factory<_i8.SohuChannelBloc>(
      () => _i8.SohuChannelBloc(get<_i7.SohuClient>()));
  gh.singleton<_i7.SohuClient>(_i7.SohuClient(get<_i4.Dio>()));
  return get;
}

class _$RegisterModule extends _i9.RegisterModule {}
