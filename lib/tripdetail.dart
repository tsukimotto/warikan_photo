// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:warikan_photo/result.dart';
import 'package:intl/intl.dart';


//余白を簡単に設定できる
class SpaceBox extends SizedBox {
  const SpaceBox({double width = 8, double height = 8})
      : super(width: width, height: height);

  const SpaceBox.width([double value = 8]) : super(width: value);

  const SpaceBox.height([double value = 8]) : super(height: value);
}

class DatabaseAccesscontroller {
  final dbConnection = FirebaseFirestore.instance;
  String curUserDocId = "";
  List<String> ryokoIdList = [];
  List<String> ryokoNameList = [];
  List<String> ryokoDateList = [];

  DatabaseAccesscontroller build() {
    return this;
  }

  Future<String> getNicknameByMail(String mail) async {
    final querySnapshot = await dbConnection
        .collection("user_list")
        .where("mail_addr", isEqualTo: mail)
        .get();

    var b = querySnapshot.docs.first.get("user_nickname");

    return b;
  }

  Future<List<List<String>>> getRyokoList(String mail) async {
    final userQuerySnapshot = await dbConnection
        .collection("user_list")
        .where("mail_addr", isEqualTo: mail)
        .get();

    var userDocId = userQuerySnapshot.docs.first.id;
    curUserDocId = userDocId;
    final ryokoListQuerySnapshot =
        await dbConnection.collection("user_list/$userDocId/ryoko_ids").get();

    for (var element in ryokoListQuerySnapshot.docs) {
      ryokoIdList.add(element.get("id").toString().substring(11));
    }

    for (var value in ryokoIdList) {
      final ryokoQuerysnapshot =
          await dbConnection.doc("ryoko_list/$value").get();

      ryokoNameList.add(ryokoQuerysnapshot.get("destination").toString());
      Timestamp ts_a = ryokoQuerysnapshot.get("start_timestamp");
      Timestamp ts_b = ryokoQuerysnapshot.get("end_timestamp");

      ryokoDateList.add(DateFormat('dd-MMM-yyy').format(ts_a.toDate()) +
          DateFormat('dd-MMM-yyy').format(ts_b.toDate()));
    }

    return [ryokoNameList, ryokoDateList];
  }

  void addNewRyoko(){

  }
}

//行程コンポーネント
class CompActivity extends StatelessWidget {
  final String activityName;
  final String warikanText;
  final List<String> image;

  const CompActivity(
      {Key? key,
      required this.activityName,
      required this.warikanText,
      required this.image})
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

class TripDetail extends StatelessWidget {
  final String title;
  final String date;

  const TripDetail({Key? key, required this.title, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("旅行名 : $title \n日程　 : $date"),
                const CompActivity(
                    activityName: "東京ドーム",
                    warikanText: "Aさん : 入場券   計6,000円 \nBさん : ビール   計2,000円",
                    image: [
                      "hinatansai.jpg",
                    ]),
                const CompActivity(
                    activityName: "けやき坂",
                    warikanText: "Cさん : 昼食代   計4,500円",
                    image: [
                      "keyakizaka_shibuya.jpg",
                      "keyakizaka_roppongi.jpg",
                    ]),
                const CompActivity(
                    activityName: "お花見",
                    warikanText: "Dさん : カフェ代   計2,500円",
                    image: [
                      "sakura_shutoko.jpg",
                      "sakura_road.jpg",
                    ]),
                const SpaceBox.height(10),
                ElevatedButton.icon(
                    onPressed: () {Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Result(result_list:
                          [6000, 2000, 4500, 2500]
                    ,)));},
                    icon: const Icon(Icons.start_sharp),
                    label: const Text("割り勘開始")),
              ],
            ),
          ),
        ));
  }
}
