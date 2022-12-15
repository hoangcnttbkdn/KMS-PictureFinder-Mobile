import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/widgets/dismiss_keyboard.dart';
import 'package:pictures_finder/repo/facebook_repository.dart';
import 'package:pictures_finder/repo/google_repository.dart';
import 'package:pictures_finder/repo/session_repository.dart';
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
            'Find image by',
          ),
        ),
        body: PageView(
          children: [
            BlocProvider(
              create: (context) => GoogleCubit(
                sessionRepository: context.read<SessionRepository>(),
                googleRepository: context.read<GoogleRepository>(),
              ),
              child: const DriveSessionPage(),
            ),
            BlocProvider(
              create: (context) => FacebookCubit(
                sessionRepository: context.read<SessionRepository>(),
                facebookRepository: context.read<FacebookRepository>(),
              ),
              child: const FacebookSessionPage(),
            ),
          ],
        ),
      ),
    );
  }
}
