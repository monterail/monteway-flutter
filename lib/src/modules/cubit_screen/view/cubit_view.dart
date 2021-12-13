import 'package:flutter/material.dart';

// TODO: Add cubit example
class CubitView extends StatelessWidget {
  final String? title;

  const CubitView({this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(title ?? ''),
      ),
    );
  }
}
