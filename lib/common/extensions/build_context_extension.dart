import 'package:flutter/material.dart';
import 'package:pictures_finder/ui/view_result/full_image_view.dart';

extension SizeExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;
}

extension EdgeInsetsExtension on BuildContext {
  EdgeInsets get padding => MediaQuery.of(this).padding;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;
}

extension NavigatorToViewFullImageExtension on BuildContext {
  void pushToViewImage(String imageUrl) {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (_) => FullImageView(imageUrl: imageUrl),
      ),
    );
  }
}
