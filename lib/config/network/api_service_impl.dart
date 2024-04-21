import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:getx_clean_arch/config/config.dart';
import 'package:getx_clean_arch/data/datasources/appLocalData/app_local_data_impl.dart';
import 'api_exception.dart';
import 'api_service.dart';
import 'resource.dart';
import 'status.dart';

class ApiServiceImpl extends ApiService {
  static final _options = BaseOptions(
    baseUrl: Config.baseAPIUrl,
    connectTimeout: const Duration(seconds: 90),
    receiveTimeout: const Duration(seconds: 90),
  );

  // dio instance
  final Dio _dio = Dio(_options)
    ..interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      return handler.next(options);
    }))
    ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  @override
  Future<Resource> postRequest({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool withToken = true,
  }) async {
    try {
      if (withToken) {
        final String token = await AppLocalDataImpl.getInstance().getToken() ?? "";
        _dio.options.headers["Authorization"] = "Bearer $token";
      }
      var response = await _dio.post(url, data: data != null ? jsonEncode(data) : null, options: options);

      return Resource(status: STATUS.SUCCESS, data: response.data, message: response.data['message']);
    } on SocketException {
      return Resource(status: STATUS.ERROR, message: 'No Internet connection');
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      return Resource(status: STATUS.ERROR, message: apiException.toString(), statusCode: e.response?.statusCode);
    } on Exception {
      return Resource(status: STATUS.ERROR, message: 'Something went wrong');
    }
  }

  @override
  Future<Resource> getRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool withToken = true,
  }) async {
    try {
      if (withToken) {
        final String token = await AppLocalDataImpl.getInstance().getToken() ?? "";
        _dio.options.headers["Authorization"] = "Bearer $token";
      }
      var response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return Resource(status: STATUS.SUCCESS, data: response.data, message: response.data['message']);
    } on SocketException {
      return Resource(status: STATUS.ERROR, message: 'No Internet connection');
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      return Resource(status: STATUS.ERROR, message: apiException.toString(), statusCode: e.response?.statusCode);
    } on Exception {
      return Resource(status: STATUS.ERROR, message: 'Something went wrong');
    }
  }
}
