import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:meet_flut/entities/sohu_album_detail_result.dart';
import 'package:meet_flut/entities/sohu_album_result.dart';
import 'package:meet_flut/entities/sohu_video_result.dart';
import 'package:meet_flut/entities/sohu_video_url_result.dart';
import 'package:retrofit/http.dart';

part 'sohu_client.g.dart';

@singleton
@RestApi(baseUrl: "https://api.tv.sohu.com/v4/")
abstract class SohuClient {
  @factoryMethod
  factory SohuClient(Dio dio) = _SohuClient;

  @GET("/search/channel.json")
  Future<SohuAlbumResult> getChannelAlbum(
    @Query("cid") String cid,
    @Query("page") int page,
    @Query("page_size") int pageSize, [
    @Query("o") int o = 1,
    @Query("plat") int plat = 6,
    @Query("poid") int poid = 1,
    @Query("api_key") String apiKey = "9854b2afa779e1a6bff1962447a09dbd",
    @Query("sver") String sVer = "6.2.0",
    @Query("sysver") String sysVer = "4.4.2",
    @Query("partner") int partner = 47,
  ]);

  @GET("/album/info/{albumId}.json")
  Future<SohuAlbumDetailResult> getAlbumDetail(
    @Path("albumId") int albumId, [
    @Query("plat") int plat = 6,
    @Query("poid") int poid = 1,
    @Query("api_key") String apiKey = "9854b2afa779e1a6bff1962447a09dbd",
    @Query("sver") String sVer = "6.2.0",
    @Query("sysver") String sysVer = "4.4.2",
    @Query("partner") int partner = 47,
  ]);

  @GET("/album/videos/{albumId}.json")
  Future<SohuVideoResult> getVideo(
    @Path("albumId") int albumId,
    @Query("page") int page,
    @Query("page_size") int pageSize, [
    @Query("order") int order = 0,
    @Query("site") int site = 1,
    @Query("with_trailer") int withTrailer = 1,
    @Query("plat") int plat = 6,
    @Query("poid") int poid = 1,
    @Query("api_key") String apiKey = "9854b2afa779e1a6bff1962447a09dbd",
    @Query("sver") String sVer = "6.2.0",
    @Query("sysver") String sysVer = "4.4.2",
    @Query("partner") int partner = 47,
  ]);

  @GET("/video/info/{vid}.json")
  Future<SohuVideoUrlResult> getVideoPlayUrl(
    @Path("vid") int vid,
    @Query("aid") int aid, [
    @Query("site") int site = 1,
    @Query("plat") int plat = 6,
    @Query("poid") int poid = 1,
    @Query("api_key") String apiKey = "9854b2afa779e1a6bff1962447a09dbd",
    @Query("sver") String sVer = "6.2.0",
    @Query("sysver") String sysVer = "4.4.2",
    @Query("partner") int partner = 47,
  ]);
}
