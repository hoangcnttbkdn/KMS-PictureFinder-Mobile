import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/common/extensions/build_context_extension.dart';
import 'package:pictures_finder/common/extensions/snackbar_extension.dart';
import 'package:pictures_finder/common/gen/assets.gen.dart';
import 'package:pictures_finder/common/widgets/choose_image_button.dart';
import 'package:pictures_finder/common/widgets/picked_image_card.dart';
import 'package:pictures_finder/common/widgets/start_session_button.dart';
import 'package:pictures_finder/ui/drive_session/cubit/google_cubit.dart';
import 'package:platform_helper/platform_helper.dart';

class DriveSessionPage extends StatefulWidget {
  const DriveSessionPage({super.key});

  @override
  State<DriveSessionPage> createState() => _DriveSessionPageState();
}

class _DriveSessionPageState extends State<DriveSessionPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GoogleCubit, GoogleState>(
          listenWhen: (previous, current) =>
              previous.currentSessionId != current.currentSessionId,
          listener: (context, state) {
            context.showSnackBar(
              message: 'You made a session, id ${state.currentSessionId}',
            );
          },
        ),
        BlocListener<GoogleCubit, GoogleState>(
          listenWhen: (previous, current) =>
              previous.loadingStatus != current.loadingStatus,
          listener: (context, state) {
            if (state.loadingStatus == LoadingStatus.error) {
              ToastHelper.showToast('Error has occured, please try again');
            }
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Assets.icons.drive.svg(height: 80),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Builder(
                    builder: (context) {
                      final currentIndex = context.select(
                        (GoogleCubit cubit) => cubit.state.currentIndex,
                      );
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                context.read<GoogleCubit>().changeIndex(0),
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: currentIndex == 0
                                  ? context.colorScheme.primary
                                  : Colors.white,
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Assets.images.face.image(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Face',
                            style: context.textTheme.bodyMedium,
                          )
                        ],
                      );
                    },
                  ),
                  Builder(
                    builder: (context) {
                      final currentIndex = context.select(
                        (GoogleCubit cubit) => cubit.state.currentIndex,
                      );
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                context.read<GoogleCubit>().changeIndex(1),
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: currentIndex == 1
                                  ? context.colorScheme.primary
                                  : Colors.white,
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Assets.images.bib.image(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Bib',
                            style: context.textTheme.bodyMedium,
                          )
                        ],
                      );
                    },
                  ),
                  Builder(
                    builder: (context) {
                      final currentIndex = context.select(
                        (GoogleCubit cubit) => cubit.state.currentIndex,
                      );
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                context.read<GoogleCubit>().changeIndex(2),
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: currentIndex == 2
                                  ? context.colorScheme.primary
                                  : Colors.white,
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Assets.images.clothes.image(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Clothes',
                            style: context.textTheme.bodyMedium,
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Google Drive Folder Url',
                hintText:
                    'https://drive.google.com/drive/u/0/folders/xxxxxxxxxxxx',
              ),
              onChanged: (value) =>
                  context.read<GoogleCubit>().changeFolder(folderPath: value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'abc@gmail.com',
              ),
              onChanged: (value) =>
                  context.read<GoogleCubit>().changeEmail(value),
            ),
            const SizedBox(height: 24),
            Builder(
              builder: (context) {
                final currentPath =
                    context.select((GoogleCubit cubit) => cubit.state.data);
                final imageSize =
                    context.select((GoogleCubit cubit) => cubit.state.fileSize);
                final currentIndex = context
                    .select((GoogleCubit cubit) => cubit.state.currentIndex);
                if (currentIndex == 1) {
                  return TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Bib',
                      hintText: 'Enter bib',
                    ),
                    onChanged: (value) =>
                        context.read<GoogleCubit>().changeBib(value),
                  );
                }
                if (currentPath.isNotEmpty) {
                  return PickedImageCard(
                    currentPath: currentPath,
                    imageSize: imageSize,
                    onRemoveIconPressed: () =>
                        context.read<GoogleCubit>().removeImagePath(),
                  );
                }
                return ChoosePictureButton(
                  onTap: () =>
                      context.read<GoogleCubit>().pickImageFromGallery(),
                );
              },
            ),
            const Spacer(),
            Builder(
              builder: (context) {
                final folderUrl = context.watch<GoogleCubit>().state.folderUrl;
                final imagePath = context.watch<GoogleCubit>().state.data;
                final loadingStatus = context
                    .select((GoogleCubit bloc) => bloc.state.loadingStatus);
                if (loadingStatus == LoadingStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StartSessionButton(
                  onPressed: folderUrl.isEmpty && imagePath.isEmpty
                      ? null
                      : () => context.read<GoogleCubit>().findImages(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
