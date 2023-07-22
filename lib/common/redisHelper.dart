import 'package:redis/redis.dart';

void main() {
  connectRedisServer(host: '127.0.0.1', port: 6379);
}

Future<List> getKeys(cmd) async {
  List keys = await cmd.send_object(["keys", "*"]);
  return keys;
}

Future<Command> connectRedisServer(
    {required String host, required int port}) async {
  final conn = RedisConnection();
  Command cmd = await conn.connect(host, port);

  await ping(cmd);
  return cmd;
}

void connectSecureRedisServer(
    {required String host,
    required int port,
    required String username,
    required String password}) async {
  final conn = RedisConnection();
  Command cmd = await conn.connectSecure(host, port);
  var res = await cmd.send_object(["AUTH", username, password]);
  print('res: ${res}');

  await ping(cmd);
}

Future<String> type(Command cmd, String key) async {
  return await cmd.send_object(["TYPE", key]);
}

Future<void> ping(Command cmd) async {
  var pong = await cmd.send_object(["ping"]);
  print('ping: $pong');
  assert(pong == "PONG");
}
