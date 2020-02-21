import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/Contact.dart';
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
    for (Map<String, dynamic> element in decodedJson) {
      final Contact contact = Contact(
          0, element['contact']['name'], element['contact']['accountNumber']);
      final Transaction transaction = Transaction(element['value'], contact);
      transactions.add(transaction);
    }
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    Map<String, dynamic> transactionMap = _toMap(transaction);
    final String transactionJson = jsonEncode(transactionMap);

    final Response response = await client.post(baseUrl, headers: {
      'Content-type': 'application/json',
      'password': '1000'}, body: transactionJson).timeout(Duration(seconds: 5));

    return _toTransaction(response);
  }

  Transaction _toTransaction(Response response) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    final Contact contact = Contact(0, json['contact']['name'], json['contact']['accountNumber']);
    return Transaction(json['value'], contact);
  }

  Map<String, dynamic> _toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber
      }
    };
    return transactionMap;
  }
}