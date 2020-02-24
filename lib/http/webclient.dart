import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String baseUrl = 'http://192.168.0.19:8080/transactions';

final client = HttpClientWithInterceptor.build(
  interceptors: [LogginInterceptor()],
  requestTimeout: Duration(seconds: 5)
);