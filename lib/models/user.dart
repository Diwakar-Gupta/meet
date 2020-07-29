import 'dart:async';

class User extends Comparable<User> {
  final String name;
  final String picURL;
  final String id;
  bool handup = false;
  bool mic = false;
  bool talking = false;

  static User me;

  User(this.id, this.name, this.picURL);

  @override
  int compareTo(User b) {
    if (mic == b.mic)
      return name.compareTo(b.name);
    else if (mic)
      return -1;
    else
      return 1;
  }
}

class UserList {
  final List<User> users = [];
  StreamController<Map> _changestream;
  Stream<Map> stream;

  UserList() {
    _changestream = new StreamController<Map>(sync: true);
    stream = _changestream.stream.asBroadcastStream();
  }

  void dispose() {
    _changestream.close();
  }

  Stream<Map> getStream() {
    return stream;
  }

  int binarySearch(User user) {
    return -1;
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
