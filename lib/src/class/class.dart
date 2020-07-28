import 'package:flutter/material.dart';
import 'package:obaka/models/room.dart';

import 'bottom.dart';

class Class extends StatefulWidget {
  final Room room;

  const Class({Key key, this.room}) : super(key: key);
  @override
  _ClassState createState() => _ClassState();
}

class _ClassState extends State<Class> {
  bool bardisplayed = true;

  void toggleSideBar() {
    setState(() {
      bardisplayed = bardisplayed == false;
    });
  }

  var bottom = Bottom();
  @override
  Widget build(BuildContext context) {
    var personchats = Container(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:
              Text('Meeting details', style: TextStyle(color: Colors.white70)),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white70,
                ),
                onPressed: toggleSideBar)
          ],
          bottom: TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(icon: Icon(Icons.people)),
              Tab(icon: Icon(Icons.message)),
              // Tab(child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [Icon(Icons.people),Text('People')])),
              // Tab(child: Row(children: [Icon(Icons.message),Text('Chat')])),
            ],
          ),
        ),
        body: TabBarView(children: [
          Container(child: Text('People')),
          Container(child: Text('Chats')),
        ]),
        bottomNavigationBar: Container(
          height: 70,
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                    decoration: InputDecoration(),
                    onSubmitted: (text) {
                      print(widget.room.sendMessage(text));
                    }),
              ),
              IconButton(icon: Icon(Icons.send), onPressed: () {})
            ],
          ),
        ),
      ),
    ));

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  color: Colors.black,
                ),
                if (bardisplayed == false)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10))),
                      child: Wrap(
                        spacing: 30,
                        children: [
                          IconButton(
                              icon: Icon(Icons.people),
                              onPressed: () {
                                setState(() {
                                  bardisplayed = bardisplayed == false;
                                });
                              }),
                          IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {
                                setState(() {
                                  bardisplayed = bardisplayed == false;
                                });
                              }),
                          Container(
                            width: 40,
                            height: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset('images/user.jpg',
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 70,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: bottom,
                  ),
                )
              ],
            ),
          ),
          if (bardisplayed)
            Flexible(
              flex: 1,
              child: personchats,
            )
        ],
      ),
    );
  }
}
