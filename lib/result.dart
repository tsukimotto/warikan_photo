// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

//余白を簡単に設定できる
class SpaceBox extends SizedBox {
  const SpaceBox({double width = 8, double height = 8})
      : super(width: width, height: height);

  const SpaceBox.width([double value = 8]) : super(width: value);
  const SpaceBox.height([double value = 8]) : super(height: value);
}

String getResult(List<int> resultList){
  var sum = resultList.reduce((value, element) => value + element)/4;
  var ans = [sum~/4 - resultList[1], sum~/4 - resultList[2], sum~/4 - resultList[3]];
  return "BさんがAさんに ${ans[0]}円\nCさんがAさんに ${ans[1]}円\nDさんがAさんに ${ans[2]}円";
}
class Result extends StatelessWidget {
  final List<int> result_list;

  const Result({Key? key, required this.result_list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("割り勘結果"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("割り勘結果"),
                Text(getResult(result_list)),
              ],
            ),
          ),
        ));
  }
}
