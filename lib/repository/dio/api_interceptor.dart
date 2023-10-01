import 'package:dio/dio.dart';

/// logging
class ApiInterceptor extends Interceptor {
//  @override
//  Future<dynamic> onRequest(RequestOptions options) async {
//    log.d('###################################');
//    log.d(
//        '--> ${options.method != null ?
//        options.method.toUpperCase() : 'METHOD'}
//        ${'' + (options.baseUrl ?? '') + (options.path ?? '')}');
//    log.d('Headers:');
//    options.headers.forEach((k, v) => log.d('$k: $v'));
//    if (options.queryParameters != null) {
//      log.d('queryParameters:');
//      options.queryParameters.forEach((k, v) => log.d('$k: $v'));
//    }
//    if (options.data != null) {
//      log.d('Body: ${options.data}');
//    }
//    log.d(
//        '--> END ${options.method != null ?
//        options.method.toUpperCase() : 'METHOD'}');
//    log.d('###################################');
//    return options;
//  }
//
//  @override
//  Future<dynamic> onResponse(Response response) async {
//    log.d('###################################');
//    log.d(
//        '<-- ${response.statusCode} ${response.request != null ?
//        (response.request.baseUrl + response.request.path) : 'URL'}');
//    log.d('Headers:');
//    response.headers?.forEach((k, v) => log.d('$k: $v'));
//    log.d('Response: ${response.data}');
//    log.d('<-- END HTTP');
//    log.d('###################################');
//    return response;
//  }
//
//  @override
//  // ignore: avoid_renaming_method_parameters
//  Future onError(DioError dioError) async {
//    log.d('###################################');
//    log.d('<-- End Error');
//    log.d('<-- ${dioError.error}');
//    log.d('Error:');
//    log.d('Response: ${dioError.response}');
//    log.d('RequestPath: ${dioError.request.path}');
//    log.d(
//        '<-- ${dioError.message} ${dioError.response?.request != null ?
//        (dioError.response.request.baseUrl +
//        dioError.response.request.path +
//        ' Method: ${dioError.request.method}')
//        : 'URL'}');
//    log.d(
//        '${dioError.response != null ?
//        dioError.response.data : 'Unknown Error'}');
//    log.d('<-- End Error');
//    log.d('###################################');
//
//    // サーバーからエラーメッセージが送信されていた時
//    if (dioError.response != null &&
//        dioError.response.data.runtimeType != String) {
//      final errors = (dioError.response.data as Map<String, dynamic>)
//      ['errors'];
//      if (errors != null) {
//        dioError.error = (errors as List).map((e) => e.toString()).join(' ');
//        return dioError;
//      }
//      final error = (dioError.response.data as Map<String, dynamic>)['error'];
//      if (error != null) {
//        dioError.error = error;
//        return dioError;
//      }
//    }
//
//    switch (dioError.type) {
//      case DioErrorType.CANCEL:
//        dioError.error = 'リクエストがキャンセルされました';
//        break;
//      case DioErrorType.CONNECT_TIMEOUT:
//        dioError.error = '通信に失敗しました。恐れ入りますが、しばらくしてから再度お試しください。';
//        break;
//      case DioErrorType.DEFAULT:
//        dioError.error = '通信環境に問題が発生しました。恐れ入りますが、しばらくしてから再度お試しください。';
//        break;
//      case DioErrorType.RECEIVE_TIMEOUT:
//        dioError.error = '通信に失敗しました。恐れ入りますが、しばらくしてから再度お試しください。';
//        break;
//      case DioErrorType.RESPONSE:
//        dioError.error = 'サーバーエラーが発生しました。恐れ入りますが、しばらくしてから再度お試しください。';
//        break;
//      default:
//        dioError.error = '予期せぬエラーが発生しました。恐れ入りますが、しばらくしてから再度お試しください。';
//    }
//
//    return dioError;
//  }
}
