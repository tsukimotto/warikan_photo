import 'package:flutter/material.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);
  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  final List<String> friendList = [
    "Aさん",
    "Bさん",
    "Cさん",
    "Dさん",
    "Eさん",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("友達一覧"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView.separated(
              itemCount: friendList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Colors.black,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(friendList[index]),
                      ]),
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => TripDetail(
                  //             title: nameList[index], date: dateList[index])),
                  //   );
                  // },
                );
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
