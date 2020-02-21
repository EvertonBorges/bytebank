
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LogginInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

}

void findAll() async {
  final client = HttpClientWithInterceptor.build(interceptors: [LogginInterceptor()]);

  final Response response =  await client.get('http://191.168.21.149:8080/transactions');
  print(response.body);
}