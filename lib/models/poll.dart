enum PollChoose { ONE, MANY }

class Poll {
  final String question;
  final PollChoose choose;
  final List<String> choices;

  Poll(this.question, this.choose, this.choices);
}