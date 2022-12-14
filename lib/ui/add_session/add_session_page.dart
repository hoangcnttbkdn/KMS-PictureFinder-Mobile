import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/widgets/dismiss_keyboard.dart';
import 'package:pictures_finder/repo/image_repository.dart';
import 'package:pictures_finder/ui/drive_session/cubit/google_cubit.dart';
import 'package:pictures_finder/ui/drive_session/driver_session_page.dart';
import 'package:pictures_finder/ui/facebook_session/cubit/facebook_cubit.dart';
import 'package:pictures_finder/ui/facebook_session/facebook_session_page.dart';

class AddSessionPage extends StatelessWidget {
  const AddSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Tìm kiếm hình ảnh có mặt bạn',
          ),
        ),
        body: PageView(
          children: [
            BlocProvider(
              create: (context) =>
                  GoogleCubit(imageRepository: context.read<ImageRepository>()),
              child: const DriveSessionPage(),
            ),
            BlocProvider(
              create: (context) => FacebookCubit(
                imageRepository: context.read<ImageRepository>(),
              ),
              child: const FacebookSessionPage(),
            ),
          ],
        ),
      ),
    );
  }
}
