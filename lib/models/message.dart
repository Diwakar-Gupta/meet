import 'dart:async';

enum MessageType { TXT, FILE, IMAGE }

class Message {
  final String from;
  final MessageType type = MessageType.TXT;
  final String to;
  final String message;

  Message(this.from, this.to, this.message);
}

class MessageList {
  final List<Message> messages = [];
  StreamController<Map> _changestream;
  Stream<Map> stream;
  MessageList() {
    _changestream = new StreamController<Map>(sync: true);
    stream = _changestream.stream.asBroadcastStream();
  }

  void dispose() {
    _changestream.close();
  }

  Stream<Map> getChangeStream() {
    return stream;
  }

  // Iterable<int>
  void addMessage(Message message) {
    print(
        'adding ${message.from} ${message.to} ${message.type} ${message.message}');
    messages.add(message);
    _changestream.add({'type': "add", 'index': messages.length - 1});
    // yield messages.length - 1;
  }
}
