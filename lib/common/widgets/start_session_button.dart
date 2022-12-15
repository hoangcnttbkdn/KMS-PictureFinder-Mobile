import 'package:flutter/material.dart';
import 'package:pictures_finder/common/extensions/build_context_extension.dart';
import 'package:pictures_finder/common/widgets/fill_button.dart';

class StartSessionButton extends StatelessWidget {
  const StartSessionButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: context.width,
        height: 56,
        child: FilledButtonWithIcon(
          onPressed: onPressed,
          label: const Text('Start'),
          icon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
