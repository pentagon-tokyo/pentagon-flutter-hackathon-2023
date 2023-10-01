import 'package:dio/dio.dart';

abstract class DioRepository {
  String endpoint(String postfix);
  Future<dynamic> get(String uri, Map<String, dynamic> params);
  Future<List<int>?> getByte({
    required String uri,
    bool isUsedBasicAuth = false,
  });
  Future<dynamic> post(
    String uri,
    Map<String, dynamic> params, {
    required FormData data,
  });
  Future<dynamic> put(String uri, Map<String, dynamic> params);
  Future<dynamic> delete(String uri, Map<String, dynamic> params);
  Future<dynamic> download(
    String url,
    String savePath,
    ProgressCallback onProgress,
  );
}
