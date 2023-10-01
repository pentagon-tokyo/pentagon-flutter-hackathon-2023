import 'package:dio/dio.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../util/secure.dart';
import 'api_interceptor.dart';
import 'dio_repository.dart';

final dioRepositoryProvider = Provider<DioRepository>((ref) {
  return DioDataSource();
});

class DioDataSource extends DioRepository {
  final _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 50000),
      receiveTimeout: const Duration(milliseconds: 50000),
    ),
  )..interceptors.add(ApiInterceptor());

  //////////////////////////////////////////////////////////
  //MARK: - URL
  //////////////////////////////////////////////////////////
  static String get baseUrl =>
      FlavorConfig.instance.variables['baseUrl'] as String;

  /// sampleのポケモンAPIがv2のため本番の場合は変更
  static String get apiUrl => '/api/v2';

  static const int firstPage = 1;
  static const int defaultPerPage = 20;

  //////////////////////////////////////////////////////////
  //MARK: - リクエストヘッダー
  //////////////////////////////////////////////////////////
  static Future<Map<String, dynamic>> get headers async {
    final client = await Secure.client;
    final accessToken = await Secure.accessToken;
    final uid = await Secure.uid;
    return <String, dynamic>{
      'Client': client,
      'Access-Token': accessToken,
      'Uid': uid,
    };
  }

  //////////////////////////////////////////////////////////
  //MARK: - エンドポイント
  //////////////////////////////////////////////////////////
  @override
  String endpoint(String postfix) => DioDataSource.apiUrl + postfix;

  dynamic commonBehavior(Response<dynamic> response) {
    // Error response
    if (response.statusCode! >= 400) {
      throw response.data as Error;
    }
    // Secure.setHttpResponseHeader(response.headers.map);
    return response.data;
  }

  @override
  Future<dynamic> get(String uri, Map<String, dynamic> params) async {
    _dio.options.headers = await headers;
    final response = await _dio.get<dynamic>(uri, queryParameters: params);
    return commonBehavior(response);
  }

  @override
  Future<List<int>?> getByte({
    required String uri,
    bool isUsedBasicAuth = false,
  }) async {
    final authHeaders = await headers;

    // Basic認証
//    if (isUsedBasicAuth) {
//      authHeaders.addAll({
//        'Authorization': 'Basic ' +
//            base64Encode(utf8.encode('admin:pass'))
//      });
//    }
    final dio = Dio(
      BaseOptions(
        responseType: ResponseType.bytes,
        receiveTimeout: const Duration(milliseconds: 1000000),
        sendTimeout: const Duration(milliseconds: 1000000),
        headers: authHeaders,
      ),
    )..interceptors.add(ApiInterceptor());

    final response = await dio.get<List<int>>(uri);
    return response.data;
  }

  @override
  Future<dynamic> post(
    String uri,
    Map<String, dynamic> params, {
    required FormData data,
  }) async {
    _dio.options.headers = await headers;
    final response =
        await _dio.post<dynamic>(uri, queryParameters: params, data: data);
    return commonBehavior(response);
  }

  @override
  Future<dynamic> put(String uri, Map<String, dynamic> params) async {
    _dio.options.headers = await headers;
    final response = await _dio.put<dynamic>(uri, queryParameters: params);
    return commonBehavior(response);
  }

  @override
  Future<dynamic> delete(String uri, Map<String, dynamic> params) async {
    _dio.options.headers = await headers;
    final response = await _dio.delete<dynamic>(uri, queryParameters: params);
    return commonBehavior(response);
  }

  @override
  Future<dynamic> download(
    String url,
    String savePath,
    ProgressCallback onProgress,
  ) async {
    await _dio.download(url, savePath, onReceiveProgress: onProgress);
  }
}
