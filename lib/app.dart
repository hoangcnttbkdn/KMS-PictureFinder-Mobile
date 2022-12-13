import 'package:flutter/material.dart';
import 'package:pictures_finder/common/gen/fonts.gen.dart';
import 'package:pictures_finder/common/resources/app_color.dart';
import 'package:pictures_finder/common/resources/app_text_theme.dart';
import 'package:pictures_finder/ui/home_page/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PictureFinder',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: FontFamily.nunito,
        textTheme: AppTextTheme().textTheme,
        scaffoldBackgroundColor: lightColorScheme.background,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: FontFamily.nunito,
        textTheme: AppTextTheme().textTheme,
        scaffoldBackgroundColor: darkColorScheme.background,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      locale: const Locale('vi'),
    );
  }
}
