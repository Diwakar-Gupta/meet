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