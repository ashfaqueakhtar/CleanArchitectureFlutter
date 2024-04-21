import 'status.dart';

class Resource<T> {
  STATUS? status;
  T? data;
  String? message;
  int? statusCode;

  Resource({this.status, this.data, this.message, this.statusCode});

  static Resource success({data, message}) => Resource(status: STATUS.SUCCESS, data: data, message: message);

  static Resource error({data, message, statusCode}) => Resource(status: STATUS.ERROR, data: data, message: message, statusCode: statusCode);

  static Resource loading({data}) => Resource(status: STATUS.LOADING, data: data, message: null);

  @override
  String toString() {
    return 'Resource{status: $status, data: $data, message: $message}';
  }

  Resource copyWith({STATUS? status, T? data, String? message}) {
    return Resource(status: status ?? this.status, data: data ?? this.data, message: message ?? this.message);
  }
}
