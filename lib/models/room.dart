import 'dart:html';
import 'dart:convert';
import 'message.dart';
import 'poll.dart';
import 'simplewebsocket.dart';
import 'user.dart';

class UserList {
  final List<User> users = [];
  StreamController<Map> _changestream;

  UserList() {
    _changestream = new StreamController<Map>();
  }

  void dispose() {
    _changestream.close();
  }

  Stream<Map> getChangeStream() {
    return _changestream.stream.asBroadcastStream();
  }

  int binarySearch(User user) {
    return 0;
  }

  void addUser(User user) {
    print('adding user: ${user.id} ${user.name} ${user.picURL}');
    int index = binarySearch(user);
    if (index >= 0) {
      return;
    }

    index = index * -1 - 1;
    users.insert(index, user);
    _changestream.add({'type': "add", 'index': index});
  }

  void remove(String id) {
    int index = 0;

    for (User u in users) {
      if (u.id.compareTo(id) == 0) {
        users.removeAt(index);
        _changestream.add({'type': "remove", 'index': index});
      }
      index++;
    }
  }
}

class Room {
  final String roomId;
  String _url;

  final UserList users = new UserList();
  final List<Poll> polls = [];
  final List<Message> messages = [];

  SimpleWebSocket _simpleWebSocket;

  void onMessage(MessageEvent event) {
    print('got message ${event.data}');
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
