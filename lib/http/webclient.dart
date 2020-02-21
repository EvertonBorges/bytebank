
import 'dart:convert';

import 'package:bytebank/models/Contact.dart';
import 'package:bytebank/models/Transaction.dart';
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

Future<List<Transaction>> findAll() async {
  final client = HttpClientWithInterceptor.build(interceptors: [LogginInterceptor()]);

  final Response response =  await client.get('http://191.168.21.149:8080/transactions').timeout(Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = List();
  for (Map<String, dynamic> element in decodedJson) {
    final Contact contact = Contact(0, element['contact']['name'], element['contact']['accountNumber']);
    final Transaction transaction = Transaction(element['value'], contact);
    transactions.add(transaction);
  }
  print('decoded json $decodedJson');
  return transactions;
}