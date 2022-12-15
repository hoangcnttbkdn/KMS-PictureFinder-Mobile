import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/common/extensions/build_context_extension.dart';
import 'package:pictures_finder/common/extensions/snackbar_extension.dart';
import 'package:pictures_finder/common/gen/assets.gen.dart';
import 'package:pictures_finder/common/widgets/choose_image_button.dart';
import 'package:pictures_finder/common/widgets/picked_image_card.dart';
import 'package:pictures_finder/common/widgets/start_session_button.dart';
import 'package:pictures_finder/ui/facebook_session/cubit/facebook_cubit.dart';
import 'package:platform_helper/platform_helper.dart';

class FacebookSessionPage extends StatefulWidget {
  const FacebookSessionPage({super.key});

  @override
  State<FacebookSessionPage> createState() => _FacebookSessionPageState();
}

class _FacebookSessionPageState extends State<FacebookSessionPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FacebookCubit, FacebookState>(
          listenWhen: (previous, current) =>
              previous.currentSessionId != current.currentSessionId,
          listener: (context, state) {
            context.showSnackBar(
              message:
                  'Bạn đã thực hiện một session có id là ${state.currentSessionId}',
            );
          },
        ),
        BlocListener<FacebookCubit, FacebookState>(
          listenWhen: (previous, current) =>
              previous.loadingStatus != current.loadingStatus,
          listener: (context, state) {
            if (state.loadingStatus == LoadingStatus.error) {
              ToastHelper.showToast('Thực hiện không thành công, xin thử lại');
            }
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            Assets.icons.facebook.svg(height: 68),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Builder(
                    builder: (context) {
                      final currentIndex = context.select(
                        (FacebookCubit cubit) => cubit.state.currentIndex,
                      );
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                context.read<FacebookCubit>().changeIndex(0),
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
                        (FacebookCubit cubit) => cubit.state.currentIndex,
                      );
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                context.read<FacebookCubit>().changeIndex(1),
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
                        (FacebookCubit cubit) => cubit.state.currentIndex,
                      );
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                context.read<FacebookCubit>().changeIndex(2),
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
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Access Token',
                hintText: 'xxxxx',
              ),
              onChanged: (value) =>
                  context.read<FacebookCubit>().changeAccessToken(value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cookie',
                hintText: 'cookiexxxx',
              ),
              onChanged: (value) =>
                  context.read<FacebookCubit>().changeCookie(value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Facebook AlbumUrl',
                hintText: 'https://www.facebook.com/media/set/?set=',
              ),
              onChanged: (value) =>
                  context.read<FacebookCubit>().changeAlbumUrl(value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'abc@gmail.com',
              ),
              onChanged: (value) =>
                  context.read<FacebookCubit>().changeEmail(value),
            ),
            const SizedBox(height: 24),
            Builder(
              builder: (context) {
                final currentPath =
                    context.select((FacebookCubit cubit) => cubit.state.data);
                final imageSize = context
                    .select((FacebookCubit cubit) => cubit.state.fileSize);
                final currentIndex = context
                    .select((FacebookCubit cubit) => cubit.state.currentIndex);
                if (currentIndex == 1) {
                  return TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Bib',
                      hintText: 'Enter bib',
                    ),
                    onChanged: (value) =>
                        context.read<FacebookCubit>().changeBib(value),
                  );
                }
                if (currentPath.isNotEmpty) {
                  return PickedImageCard(
                    currentPath: currentPath,
                    imageSize: imageSize,
                    onRemoveIconPressed: () =>
                        context.read<FacebookCubit>().removeImagePath(),
                  );
                }
                return ChoosePictureButton(
                  onTap: () =>
                      context.read<FacebookCubit>().pickImageFromGallery(),
                );
              },
            ),
            const Spacer(),
            Builder(
              builder: (context) {
                final accessToken =
                    context.watch<FacebookCubit>().state.accessToken;
                final cookie = context.watch<FacebookCubit>().state.cookie;

                final albumUrl = context.watch<FacebookCubit>().state.albumUrl;
                final imagePath = context.watch<FacebookCubit>().state.data;
                final loadingStatus = context
                    .select((FacebookCubit bloc) => bloc.state.loadingStatus);
                if (loadingStatus == LoadingStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StartSessionButton(
                  onPressed: accessToken.isEmpty &&
                          imagePath.isEmpty &&
                          albumUrl.isEmpty &&
                          cookie.isEmpty
                      ? null
                      : () => context.read<FacebookCubit>().findImages(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
