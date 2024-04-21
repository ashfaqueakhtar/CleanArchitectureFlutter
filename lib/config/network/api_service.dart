import 'package:dio/dio.dart';

import 'resource.dart';

abstract class ApiService {
  Future<Resource> getRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool withToken = true,
  });

  Future<Resource> postRequest({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool withToken = true,
  });
}
