import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token = '',
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String token = '',
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}

// Dio For News APP 
// class DioHelper {
//   static Dio? dio;

//   static init() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: 'https://newsapi.org/',
//         receiveDataWhenStatusError: true,
//       ),
//     );
//   }

//   static Future<Response> getData({
//     required String url,
//     required Map<String, dynamic> query,
//   }) async {
//     return await dio!.get(url, queryParameters: query);
//   }
// }