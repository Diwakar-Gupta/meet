enum MessageType { TXT, FILE, IMAGE }

class Message {
  final String from;
  final MessageType type;
  final String to;
  final String message;

  Message(this.from, this.type, this.to, this.message);
}