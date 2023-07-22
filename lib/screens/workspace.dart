import 'package:flutter/material.dart';
import 'package:redis/redis.dart';

import '../common/redisHelper.dart';

class WorkSpace extends StatefulWidget {
  final List keys;
  final Command cmd;
  const WorkSpace({super.key, required this.keys, required this.cmd});

  @override
  State<WorkSpace> createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpace> {
  Future<List<Widget>> getKeyWidget() async {
    List<Widget> widgets = [];
    for (var key in widget.keys) {
      String keyType = await type(widget.cmd, key);
      widgets.add(
        GestureDetector(
          onTap: () {
            print('key: $key');
            print('keyType: $keyType');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.teal.shade50,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                margin: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: Text(
                  keyType,
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                key,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Roboto",
                  color: Colors.grey.shade700,
                ),
              )
            ],
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: FutureBuilder<List<Widget>>(
              future: getKeyWidget(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(children: [
                    TextButton(onPressed: () {}, child: Text('Query')),
                    SizedBox(height: 10),
                    Text('KeyList: ${widget.keys.length}'),
                    ...snapshot.data!
                  ]);
                }
              },
            ),
          ),
          Expanded(
              flex: 5,
              child: Container(
                color: Colors.blue.shade100,
                child: Text(""),
              )),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.green.shade50,
              )),
        ],
      ),
    );
  }
}
