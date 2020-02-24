import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String message;

  const Progress({this.message = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(message, style: TextStyle(fontSize: 16.0),),
          ),
        ],
      ),
    );
  }
}
