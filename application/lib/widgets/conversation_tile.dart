import 'package:flutter/material.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    Key? key,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.onTap,
  }) : super(key: key);

  final String? title;
  final String? content;
  final String? timestamp;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 130,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title ?? '',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    timestamp ?? '',
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                  child: Text(
                content ?? '',
                maxLines: 4,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
