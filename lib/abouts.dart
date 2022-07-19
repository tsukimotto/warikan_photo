import 'package:flutter/material.dart';

class Abouts extends StatefulWidget {
  const Abouts({Key? key}) : super(key: key);
  @override
  State<Abouts> createState() => _AboutsState();
}

class _AboutsState extends State<Abouts> {
  get width => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("このアプリについて"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
                width:300,
                height:230,
                child: Image.asset('assets/images/about_image1.jpg',
                fit:BoxFit.contain)),
            const Text(
              '多人数旅行での割り勘計算を',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const Text(
            '共に決済履歴・写真等を組み合わせ',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const Text(
                '旅行の時系列を容易に追うことができます',
              style: TextStyle(
                color: Colors.black,
              ),
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
