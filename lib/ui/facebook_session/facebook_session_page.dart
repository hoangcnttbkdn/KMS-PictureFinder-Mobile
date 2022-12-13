import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
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

class _FacebookSessionPageState extends State<FacebookSessionPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                labelText: 'Email nhận thông báo',
                hintText: 'abc@gmail.com',
              ),
              onChanged: (value) =>
                  context.read<FacebookCubit>().changeEmail(value),
            ),
            const SizedBox(height: 24),
            Builder(
              builder: (context) {
                final currentPath = context
                    .select((FacebookCubit cubit) => cubit.state.imagePath);
                final imageSize = context
                    .select((FacebookCubit cubit) => cubit.state.fileSize);
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
                final imagePath =
                    context.watch<FacebookCubit>().state.imagePath;
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

  @override
  bool get wantKeepAlive => true;
}
