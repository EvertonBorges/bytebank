import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/Transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseUrl).timeout(
        Duration(seconds: 5));
    List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions = List();
    for (Map<String, dynamic> transactionJson in decodedJson) {
      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toString());

    final Response response = await client.post(baseUrl, headers: {
      'Content-type': 'application/json',
      'password': '1000'}, body: transactionJson).timeout(Duration(seconds: 5));

    return _toTransaction(response);
  }

  Transaction _toTransaction(Response response) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }

}