import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meet/models/room.dart';
import 'package:meet/src/class/people.dart';
import 'package:meet/util/notification.dart';

import 'bottom.dart';

class Class extends StatefulWidget {
  final Room room;

  const Class({Key key, this.room}) : super(key: key);
  @override
  _ClassState createState() => _ClassState();
}

class _ClassState extends State<Class> {
  bool bardisplayed = true;
  bool peopledisplay = true;

  void toggleSideBar() {
    setState(() {
      bardisplayed = bardisplayed == false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var bottom = Bottom();
  @override
  Widget build(BuildContext context) {
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
                                  peopledisplay = true;
                                  bardisplayed = true;
                                });
                              }),
                          IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {
                                setState(() {
                                  peopledisplay = false;
                                  bardisplayed = true;
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
              child: NotificationListener<CloseMe>(
                  onNotification: (CloseMe no) {
                    setState(() {
                      bardisplayed = false;
                    });
                    return true;
                  },
                  child: Container(
                    child: PeoplesChats(widget.room, showpeople: peopledisplay),
                  )),
            )
        ],
      ),
    );
  }
}
