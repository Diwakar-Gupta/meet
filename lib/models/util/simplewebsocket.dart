import 'dart:async';
import 'dart:html';

class SimpleWebSocket {
  StreamController<Map> _userS;
  StreamController<Map> _messageS;
  StreamController<Map> _pollS;

  WebSocket soc;
  final String url;
  Function(MessageEvent) onmessage;

  SimpleWebSocket(this.url, this.onmessage) {
    soc = null;
    _userS = new StreamController<Map>();
    _messageS = new StreamController<Map>();
  }

  void dispose() {
    if(soc!=null)
      soc.close();
    _userS.close();
    _messageS.close();
    _pollS.close();
  }

  void connect() async {
    while (soc == null ||
        soc.readyState == WebSocket.CLOSED ||
        soc.readyState == WebSocket.CLOSING) {
      try {
        soc = WebSocket(url);

        soc.onMessage.listen(onmessage);
        soc.onClose.listen((event) sync* {
          print('closed' + event.toString());
          soc.close();
          new Future.delayed(Duration(seconds: 2)).then((value) => connect());
        });
        soc.onOpen.listen((event) {
          print('on open ondata ${event.toString()}');
        }, onDone: () {
          print('ondone');
          soc.close();
          new Future.delayed(Duration(seconds: 2)).then((value) => connect());
        });
      } catch (e) {
        print('error $e');
      }
    }
  }

  bool send(text) {
    if (isConnected()) {
      soc.send(text);
      return true;
    }
    return false;
  }

  bool isConnected() {
    return soc != null && soc.readyState == WebSocket.OPEN;
  }

  Stream<Map> userStream() {
    return _userS.stream.asBroadcastStream();
  }

  Stream<Map> messageStream() {
    return _messageS.stream.asBroadcastStream();
  }
}
