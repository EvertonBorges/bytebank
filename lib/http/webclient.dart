
import 'package:http/http.dart';

void findAll() async {
  final Response response =  await get('http://191.168.21.149:8080/transactions');
  print(response.body);
}