import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.hearing//FontAwesomeIcons.handPaper
            , size: 30),
          ],
        ),
        Spacer(),
        Row(
          children: [
            Icon(
              Icons.mic,
              size: 30,
            ),
            Icon(Icons.videocam, size: 30)
          ],
        ),
        Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            BottomWidget(
              child: Column(
                children: [
                  Spacer(),
                  Icon(Icons.present_to_all),
                  Text('Present Now'),
                  Spacer(),
                ],
              ),
            ),
            PopupMenuButton(
              onSelected: (d) {},
              itemBuilder: (_) => [
                PopupMenuItem(value: "1", child: Text('item 1')),
                PopupMenuItem(value: "2", child: Text('item 1')),
                PopupMenuItem(value: "1", child: Text('item 1')),
                PopupMenuItem(value: "2", child: Text('item 1')),
              ],
              child: Icon(Icons.more_vert),
            ),
          ],
        )
      ],
    );
  }
}

class BottomWidget extends StatefulWidget {
  const BottomWidget({Key key, this.child}) : super(key: key);

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
  final Widget child;
}

class _BottomWidgetState extends State<BottomWidget> {
  bool focus = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) {
        setState(() {
          focus = focus == false;
        });
      },
      onExit: (e) {
        setState(() {
          focus = focus == false;
        });
      },
      child: Container(
          color: focus
              ? Theme.of(context).focusColor
              : Theme.of(context).scaffoldBackgroundColor,
          child: widget.child),
    );
  }
}
