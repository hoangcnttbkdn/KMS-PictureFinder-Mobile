import 'dart:io';

import 'package:dartx/dartx_io.dart';
import 'package:flutter/material.dart';
import 'package:pictures_finder/common/extensions/build_context_extension.dart';


class PickedImageCard extends StatelessWidget {
  const PickedImageCard({
    Key? key,
    required this.currentPath,
    required this.imageSize,
    required this.onRemoveIconPressed,
  }) : super(key: key);

  final String currentPath;
  final String imageSize;
  final VoidCallback onRemoveIconPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ảnh đã chọn',
          style: context.textTheme.titleLarge
              ?.copyWith(color: context.colorScheme.onSurface),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                bottom: 8,
                top: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () => context.pushToViewImage(currentPath),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Hero(
                          tag: currentPath,
                          child: Image.file(
                            File(currentPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            File(currentPath).name,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              imageSize,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text('|'),
                            const SizedBox(width: 4),
                            Text(
                              File(currentPath).extension,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onSurface,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: onRemoveIconPressed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
