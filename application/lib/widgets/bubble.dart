import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  const Bubble({
    Key? key,
    required this.message,
    required this.timestamp,
    required this.isWrittenByHuman,
  }) : super(key: key);
  final String message;
  final String timestamp;
  final bool isWrittenByHuman;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          if (isWrittenByHuman) const Spacer(),
          Column(
            crossAxisAlignment: isWrittenByHuman ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: isWrittenByHuman ? Colors.blue[200] : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                      topRight: const Radius.circular(40.0),
                      bottomRight: Radius.circular(isWrittenByHuman ? 0 : 40.0),
                      topLeft: const Radius.circular(40.0),
                      bottomLeft: Radius.circular(isWrittenByHuman ? 40.0 : 0)),
                ),
                child: Text(message),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(timestamp),
            ],
          ),
          if (!isWrittenByHuman) const Spacer(),
        ],
      ),
    );
  }
}
