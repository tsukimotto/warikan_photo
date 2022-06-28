import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warikan_photo/main.dart';

class TripAdd extends StatefulWidget {
  const TripAdd({Key? key}) : super(key: key);
  @override
  State<TripAdd> createState() => _TripAddState();
}

class _TripAddState extends State<TripAdd> {
  final _textEditingController = TextEditingController(text: "カレンダーから選択");
  DateTimeRange? selectedDateRange;

  late String dateStartFormat;
  late String dateEndFormat;

  Future _dateRangePicker(BuildContext context) async {
    final initialDateRange =
        DateTimeRange(start: DateTime.now(), end: DateTime.now());

    final dateRangePicked = await showDateRangePicker(
        locale: const Locale("ja"),
        context: context,
        initialDateRange: initialDateRange,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1));

    if (dateRangePicked != null) {
      setState(() {
        selectedDateRange = dateRangePicked;
        dateStartFormat =
            DateFormat("yyyy/MM/dd").format(selectedDateRange!.start);
        dateEndFormat = DateFormat("yyyy/MM/dd").format(selectedDateRange!.end);
        _textEditingController.text = "$dateStartFormat ～ $dateEndFormat";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("旅行を追加"),
        ),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.lightGreen,
                ),
                labelText: '旅行名',
                floatingLabelStyle: TextStyle(fontSize: 12),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.lightGreen,
                ),
                labelText: '行き先',
                floatingLabelStyle: TextStyle(fontSize: 12),
              ),
            ),
            //
            //
            //
            Center(
              child: Row(children: [
                Flexible(
                  child: TextFormField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.lightGreen,
                      ),
                      labelText: '旅行日程',
                      floatingLabelStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _dateRangePicker(context);
                    },
                    icon: const Icon(Icons.date_range)),
              ]),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()));
                },
                child: const Text("旅行を追加する"))
          ]),
        ));
  }
}
