import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'package:meet/models/util/simplewebsocket.dart';

import 'message.dart';
import 'poll.dart';
import 'user.dart';

class Room {
  final String roomId;
  String _url;

  final UserList users = new UserList();
  final List<Poll> polls = [];
  final MessageList messages = new MessageList();

  SimpleWebSocket _simpleWebSocket;

  void onMessage(MessageEvent event) {
    print(event.data);
    final jobj = json.decode(event.data);

    switch (jobj['type']) {
      case 'self':
          User.me = User(jobj['data']['id'], jobj['data']['name'], jobj['data']['picurl']);
        break;
      case 'user':
        var uobj = jobj['data'];
        switch (uobj['type']) {
          case 'add':
            users.addUser(User(uobj['id'], uobj['name'], uobj['picimg']));
            break;
          case 'remove':
            users.remove(uobj['id']);
            break;
          default:
        }
        break;
      case 'message':
        var mobj = jobj['data'];
        messages.addMessage(
            Message(mobj['from'], mobj['to'], mobj['message']));
            break;
      default:
    }
  }

  bool sendMessage(String text) {
    return _simpleWebSocket.send(jsonEncode({'message': text}));
  }

  void start() async {
    _simpleWebSocket = new SimpleWebSocket(this._url, onMessage);
    _simpleWebSocket.connect();
    _simpleWebSocket.userStream().listen((juser) {
      if (juser['type'] == "add") {
        users.addUser(User(juser['id'], juser['name'], juser['picURL']));
      } else {
        users.remove(juser['id']);
      }
    });
  }

  Room(this.roomId) {
    _url = 'ws://127.0.0.1:8000/ws/chat/$roomId/';
    start();
  }
}
