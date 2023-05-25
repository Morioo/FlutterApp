const _textKey = 'text';
const _isWrittenByHumanKey = 'isWrittenByHuman';
const _timestampKey = 'timestamp';

class Message {
  Message({
    required this.text,
    required this.isWrittenByHuman,
    required this.timestamp,
  });

  final String text;
  final bool isWrittenByHuman;
  final DateTime timestamp;

  Message.fromJson(Map<String, dynamic> json)
      : text = json[_textKey],
        timestamp = DateTime.parse(json[_timestampKey]),
        isWrittenByHuman = json[_isWrittenByHumanKey];

  Map<String, dynamic> toJson() => {
        _textKey: text,
        _timestampKey: timestamp.toIso8601String(),
        _isWrittenByHumanKey: isWrittenByHuman,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          other.text == text &&
          other.isWrittenByHuman == isWrittenByHuman &&
          other.timestamp.compareTo(timestamp) == 0;

  @override
  int get hashCode => Object.hash(text, isWrittenByHuman, timestamp);
}
