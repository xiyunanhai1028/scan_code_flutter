/*
 * @Author: dfh
 * @Date: 2024-11-01 08:32:57
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';

class SocketUtils {
  factory SocketUtils() => _socketUtils;
  static final SocketUtils _socketUtils = SocketUtils._internal();
  IOWebSocketChannel? channel;
  Timer? _timer;
  String? _url;
  Function? _callback;

  SocketUtils._internal() {}

  void initSocket(String url, Function callback) {
    _url = url;
    _callback = callback;
    channel = IOWebSocketChannel.connect(url);
    channel!.stream.listen(onData, onError: onError, onDone: onDone);
    startCountdownTimer();
  }

  //心跳检测
  void startCountdownTimer() {
    if (_timer != null) _timer!.cancel();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (channel == null) {
        initSocket(_url!, _callback!);
      } else {
        channel!.sink.add('heartCheck');
      }
    });
  }

  onData(event) {
    var bean = json.decode(event);
    if (bean == "连接成功") {
      print('连接成功');
      return;
    }
    if (bean['type'] == 'heartCheck') {
      print('心跳检测');
      return;
    }
    _callback!(event);
  }

  onError(err) {
    print('消息错误${err}');
    if (channel != null) {
      channel!.sink.close();
      channel = null;
    }
  }

  onDone() {
    print('消息关闭');
    if (channel != null) {
      channel!.sink.close();
      channel = null;
    }
  }

  void dispose() {
    if (channel != null) {
      channel!.sink.close();
      print('socket通道关闭');
      channel = null;
    }
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }
}
