import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:pictures_finder/common/extensions/build_context_extension.dart';

class ChoosePictureButton extends StatelessWidget {
  const ChoosePictureButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        dashPattern: const [10, 4],
        strokeCap: StrokeCap.round,
        color: context.colorScheme.primary,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.upload_file_rounded,
                size: 32,
                color: context.colorScheme.onSurface,
              ),
              const SizedBox(height: 16),
              Text(
                'Chọn ảnh của bạn',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

