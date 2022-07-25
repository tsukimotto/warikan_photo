// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

//余白を簡単に設定できる
class SpaceBox extends SizedBox {
  const SpaceBox({double width = 8, double height = 8})
      : super(width: width, height: height);

  const SpaceBox.width([double value = 8]) : super(width: value);
  const SpaceBox.height([double value = 8]) : super(height: value);
}


//行程コンポーネント
class CompActivity extends StatelessWidget {
  final String activityName;
  final String warikanText;
  final List<String> image;
  final TextEditingController? tokyoController1;
  final TextEditingController? tokyoController2;
  final TextEditingController? tokyoController3;
  final TextEditingController? tokyoController4;
  const CompActivity(
      {Key? key,
      required this.activityName,
      required this.warikanText,
      required this.image,
      required this.tokyoController1,
      required this.tokyoController2,
      required this.tokyoController3,
      required this.tokyoController4,})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SpaceBox.height(20),
          Text(
            activityName,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 24),
          ),
          const SpaceBox.height(10),
          Text(warikanText),
          const SpaceBox.height(10),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: image.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Image.asset("assets/images/${image[index]}"),
                );
              },
            ),
          ),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("写真")),
              const SpaceBox.width(10),
              ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: const Text("支払い入力フォーム"),
                              content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: '支払った人',
                                        hintText: '名前',
                                      ),
                                      autofocus: true,
                                      // keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: '支払ってもらった人',
                                        hintText: '名前',
                                      ),
                                      autofocus: true,
                                      // keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: '用途',
                                        hintText: '例：おみやげ代',
                                      ),
                                      autofocus: true,
                                      // keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: '金額',
                                        hintText: '例：7500円',
                                      ),
                                      autofocus: false,
                                      // keyboardType: TextInputType.number,
                                    ),
                                  ]),
                            ));
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("割り勘"))
            ],
          ),
        ]);
  }
}

class TripDetail extends StatefulWidget {
  @override
  _TripDetailState createState() => _TripDetailState();

}

class _TripDetailState extends State<TripDetail> {
  // var _warikanController = TextEditingController();
  var _graph = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];

  var _tokyodomeController1 = TextEditingController();
  var _tokyodomeController2 = TextEditingController();
  var _tokyodomeController3 = TextEditingController();
  var _tokyodomeController4 = TextEditingController();
  var _keyakiController1 = TextEditingController();
  var _keyakiController2 = TextEditingController();
  var _keyakiController3 = TextEditingController();
  var _keyakiController4 = TextEditingController();
  var _ohanamiController1 = TextEditingController();
  var _ohanamiController2 = TextEditingController();
  var _ohanamiController3 = TextEditingController();
  var _ohanamiController4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("東京"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text("旅行名 : 東京 \n日程　 : 2022/03/30~2022/03/31"),
                CompActivity(
                    activityName: "東京ドーム",
                    warikanText: "Aさん : 入場券   計6,000円 \nBさん : ビール   計2,000円",
                    image: [
                      "hinatansai.jpg",
                    ],
                    tokyoController1: _tokyodomeController1,
                    tokyoController2: _tokyodomeController2,
                    tokyoController3: _tokyodomeController3,
                    tokyoController4: _tokyodomeController4,),
                CompActivity(
                    activityName: "けやき坂",
                    warikanText: "Cさん : 昼食代   計4,500円",
                    image: [
                      "keyakizaka_shibuya.jpg",
                      "keyakizaka_roppongi.jpg",
                    ],
                    tokyoController1: _keyakiController1,
                    tokyoController2: _keyakiController2,
                    tokyoController3: _keyakiController3,
                    tokyoController4: _keyakiController4),
                CompActivity(
                    activityName: "お花見",
                    warikanText: "Dさん : カフェ代   計2,500円",
                    image: [
                      "sakura_shutoko.jpg",
                      "sakura_road.jpg",
                    ],
                    tokyoController1: _ohanamiController1,
                    tokyoController2: _ohanamiController2,
                    tokyoController3: _ohanamiController3,
                    tokyoController4: _ohanamiController4),
                SpaceBox.height(10),
              ],
            ),
          ),
        ));
  }
}
