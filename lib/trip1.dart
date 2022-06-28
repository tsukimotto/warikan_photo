import 'package:flutter/material.dart';

class Trip1 extends StatelessWidget {
  final String name;
  final String date;

  const Trip1({Key? key, required this.name, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("旅行名： $name \n 日程： $date"),
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
