import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pictures_finder/common/extensions/build_context_extension.dart';
import 'package:pictures_finder/common/extensions/datetime_extension.dart';
import 'package:pictures_finder/model/provider.dart';
import 'package:pictures_finder/model/sent_session.dart';

class SavedSessionCard extends StatelessWidget {
  const SavedSessionCard({
    Key? key,
    required this.session,
    required this.onTap,
  }) : super(key: key);

  final SentSession? session;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 120,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(session!.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Session: ${session!.sessionId}',
                        style: context.textTheme.bodyLarge,
                      ),
                      Text(
                        'Tìm kiếm qua ${session!.type == Provider.drive ? "Drive" : "Facebook"}',
                        style: context.textTheme.bodyMedium,
                      ),
                      Text(
                        'Thực hiện vào lúc: ${session!.createdAt.yMdHm}',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
