import 'package:flutter/material.dart';
import 'package:meet/models/message.dart';
import 'package:meet/models/room.dart';
import 'package:meet/models/user.dart';
import 'package:meet/util/notification.dart';

class PeoplesChats extends StatelessWidget {
  final Room room;
  final bool showpeople;

  PeoplesChats(this.room, {this.showpeople = true});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: showpeople ? 0 : 1,
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
                onPressed: () {
                  CloseMe().dispatch(context);
                })
          ],
          bottom: TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(icon: Icon(Icons.people)),
              Tab(icon: Icon(Icons.message)),
            ],
          ),
        ),
        body: TabBarView(children: [
          ElementPeople(userlist: room.users),
          ElementChat(messageList: room.messages),
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
                      print(room.sendMessage(text));
                    }),
              ),
              IconButton(icon: Icon(Icons.send), onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

class ElementPeople extends StatefulWidget {
  final UserList userlist;

  const ElementPeople({Key key, this.userlist}) : super(key: key);

  @override
  _ElementPeopleState createState() => _ElementPeopleState();
}

class _ElementPeopleState extends State<ElementPeople> {
  final GlobalKey<AnimatedListState> _peoplelistkey =
      GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();

    widget.userlist.getStream().listen((event) {
      switch (event['type']) {
        case 'add':
          _peoplelistkey.currentState.insertItem(event['index']);
          break;
        case 'remove':
          _peoplelistkey.currentState
              .removeItem(event['index'], (context, animation) => Container());
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: _peoplelistkey,
        initialItemCount: widget.userlist.users.length,
        itemBuilder: (c, index, animation) {
          final user = widget.userlist.users[index];
          return SizeTransition(
            sizeFactor: animation,
            child: ListTile(
              title: Text('${user.id} ${user.name} ${user.picURL}'),
            ),
          );
        });
  }
}
























class ElementChat extends StatefulWidget {
  final MessageList messageList;

  const ElementChat({Key key, this.messageList}) : super(key: key);

  @override
  _ElementChatState createState() => _ElementChatState();
}

class _ElementChatState extends State<ElementChat> {
  final GlobalKey<AnimatedListState> _messagelistkey =
      GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    widget.messageList.getChangeStream().listen((event) {
      switch (event['type']) {
        case 'add':
          _messagelistkey.currentState.insertItem(event['index']);
          break;
        case 'remove':
          _messagelistkey.currentState
              .removeItem(event['index'], (context, animation) => Container());
          break;
        default:
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: _messagelistkey,
        initialItemCount: widget.messageList.messages.length,
        itemBuilder: (c, index, animation) {
          final message = widget.messageList.messages[index];
          return SizeTransition(
            sizeFactor: animation,
            child: ListTile(
              title: Text(
                  '${message.from} ${message.to} ${message.type} ${message.message}'),
            ),
          );
        });
  }
}
