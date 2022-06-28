import 'package:flutter/material.dart';

//余白を簡単に設定できる
class SpaceBox extends SizedBox {
  const SpaceBox({double width = 8, double height = 8})
      : super(width: width, height: height);

  const SpaceBox.width([double value = 8]) : super(width: value);
  const SpaceBox.height([double value = 8]) : super(height: value);
}

class TripDetail extends StatelessWidget {
  final String name;
  final String date;

  const TripDetail({Key? key, required this.name, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("旅行名 : $name \n日程　 : $date"),
            const SpaceBox.height(20),
            const Text(
              "東京ドーム",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            const SpaceBox.height(10),
            const Text("松本 : 入場券   計6,000円 \n加茂 : ビール   計2,000円"),
            const SpaceBox.height(10),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Card(child: Image.asset("image/sakura_shutoko.jpg")),
                  Card(child: Image.asset("image/sakura_road.jpg")),
                  Card(child: Image.asset("image/keyakizaka_shibuya.jpg")),
                  Card(child: Image.asset("image/keyakizaka_roppongi.jpg")),
                  Card(child: Image.asset("image/hinatansai.jpg")),
                ],
              ),
            ),
            const SpaceBox.height(10),
            Row(
              children: <Widget>[
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text("写真")),
                const SpaceBox.width(10),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text("割り勘"))
              ],
            ),
            const SpaceBox.height(300),
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
