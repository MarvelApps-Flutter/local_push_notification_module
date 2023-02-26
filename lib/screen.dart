import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  String text;
  Screen({
    Key? key,
    required this.text,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
      title: const Text('Screen'),
      centerTitle: true,
    ),
      body: Center(
        child: Text(text)
      ),
    );
  }
}
