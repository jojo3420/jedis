import 'package:flutter/material.dart';
import 'package:redis/redis.dart';
import 'package:udemy_flutter_bootcamp/common/redisHelper.dart';
import 'package:udemy_flutter_bootcamp/screens/workspace.dart';

import 'common/routeHelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jedis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _connectionName = '';
  String _username = '';
  String _host = '';
  String _password = '';
  int _port = 6379;

  connectRedis() async {
    print('Host: $_host');
    print('Port: $_port');
    print('Password: $_password');
    print('Name: $_username');
    Command cmd = await connectRedisServer(host: _host, port: _port);
    print('cmd: $cmd');
    var keys = await getKeys(cmd);
    moveScreen(context, WorkSpace(keys: keys, cmd: cmd));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _connectionName = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'connection name',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _host = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'host',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _port = int.parse(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'port',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'User name',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'password',
              ),
            ),
            TextButton(
              onPressed: () {
                connectRedis();
              },
              child: Text('Connect'),
            ),
            TextButton(
              onPressed: () {
                connectRedis();
              },
              child: Text('Save'),
            ),
          ],
        ),
      )),
    );
  }
}
