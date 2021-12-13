import 'package:flutter/material.dart';

// TODO: Add BLoC example
class BlocView extends StatelessWidget {
  final String? title;

  const BlocView({required this.title, Key? key}) : super(key: key);

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
