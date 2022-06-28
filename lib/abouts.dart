import 'package:flutter/material.dart';

class Abouts extends StatefulWidget {
  const Abouts({Key? key}) : super(key: key);
  @override
  State<Abouts> createState() => _AboutsState();
}

class _AboutsState extends State<Abouts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("このアプリについて"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'このアプリは、',
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("旅行一覧へ戻る"))
          ],
        ),
      ),
    );
  }
}
