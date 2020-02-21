import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String baseUrl = 'http://191.168.21.149:8080/transactions';

final client = HttpClientWithInterceptor.build(
    interceptors: [LogginInterceptor()]);