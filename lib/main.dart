// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:warikan_photo/tripdetail.dart';
import 'package:warikan_photo/tripadd.dart';
import 'package:warikan_photo/friends.dart';
import 'package:warikan_photo/profile.dart';
import 'package:warikan_photo/abouts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return MaterialApp(
        title: 'Warikan Photo',
        theme: ThemeData(
            primarySwatch: Colors.lightGreen,
            textTheme: Theme
                .of(context)
                .textTheme
                .apply(
              fontSizeFactor: 1.1,
              fontSizeDelta: 2.0,
            )),
        home: const MyHomePage(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      );
    } else {
      return MaterialApp(
        title: 'Warikan Photo',
        theme: ThemeData(
            primarySwatch: Colors.lightGreen,
            textTheme: Theme
                .of(context)
                .textTheme
                .apply(
              fontSizeFactor: 1.1,
              fontSizeDelta: 2.0,
            )),
        home: const Login(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      );
    }
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> nameList = [
    "東京",
    "北海道",
    "ハワイ",
  ];
  List<String> dateList = [
    "2022/03/30～2022/03/31",
    "2022/09/15～2022/09/20",
    "2023/02/03～2022/02/07",
  ];

  @override
  Widget build(BuildContext context) {
    final dbConnector = DatabaseAccesscontroller();
    String usermail = FirebaseAuth.instance.currentUser != null
        ? FirebaseAuth.instance.currentUser!.email.toString()
        : "";


    return Scaffold(
      appBar: AppBar(
        title: Text("旅行一覧"),
      ),
      drawer: Drawer(
        child: ListView(children: <Widget>[
          SizedBox(
            height: 200,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
              accountName: FutureBuilder<String>(
                future: dbConnector.getNicknameByMail(usermail),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // 请求已结束
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      // 请求失败，显示错误
                      return Text("Error: ${snapshot.error}");
                    } else {
                      // 请求成功，显示数据
                      return Text("${snapshot.data}");
                    }
                  } else {
                    // 请求未结束，显示loading
                    return CircularProgressIndicator();
                  }
                },
              ),
              accountEmail: Text(usermail),
            ),
          ),
          ListTile(
            title: Text("ログイン"),
            leading: Icon(Icons.card_travel),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
          ListTile(
            title: Text("旅行一覧"),
            leading: Icon(Icons.card_travel),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            title: Text("友だち一覧"),
            leading: Icon(Icons.people),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Friends()),
              );
            },
          ),
          ListTile(
            title: Text("プロフィール"),
            leading: Icon(Icons.account_circle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          ),
          ListTile(
            title: Text("このアプリについて"),
            leading: Icon(Icons.feedback),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Abouts()),
              );
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text("ログアウト"),
              leading: Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }),
        ]),
      ),
      //
      //
      //
      body: Center(
          child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: FutureBuilder<List<List<String>>>(
                future: dbConnector.getRyokoList(usermail),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SizedBox(
                      width: double.infinity,
                      child: ListView.separated(
                          itemCount: snapshot.data[0].length,
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                                color: Colors.black,
                              ),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    Text("${snapshot.data[0][index]}"),
                                    Text(
                                      "${snapshot.data[1][index]}",
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 16),
                                    )
                                  ]),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TripDetail(
                                              title: snapshot.data[0][index],
                                              date: snapshot.data[1][index])),
                                );
                              },
                            );
                          }),
                    );

                  }else{
                  return CircularProgressIndicator();
                  }
                },
              )
          )),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TripAdd()));
          },
          shape: StadiumBorder(),
          icon: Icon(Icons.add),
          label: Text("旅行を追加"),
        ),
      ),
    );
  }
}

/*GitHub command

git checkout -b "branch-name" //ブランチを作る
git checkout branch-name //ブランチに行く
git branch //現在のブランチを確認


git add .
git commit -m "message"
git push


git checkout main
git pull
*/
