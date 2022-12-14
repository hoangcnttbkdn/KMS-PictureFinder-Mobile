import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
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

class _DriveSessionPageState extends State<DriveSessionPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<GoogleCubit, GoogleState>(
          listenWhen: (previous, current) =>
              previous.currentSessionId != current.currentSessionId,
          listener: (context, state) {
            context.showSnackBar(
              message:
                  'Bạn đã thực hiện một session có id là ${state.currentSessionId}',
            );
          },
        ),
        BlocListener<GoogleCubit, GoogleState>(
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Assets.icons.drive.svg(height: 120),
            ),
            const SizedBox(height: 24),
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
            const SizedBox(height: 24),
            Builder(
              builder: (context) {
                final currentPath = context
                    .select((GoogleCubit cubit) => cubit.state.imagePath);
                final imageSize =
                    context.select((GoogleCubit cubit) => cubit.state.fileSize);
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
                final imagePath = context.watch<GoogleCubit>().state.imagePath;
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

  @override
  bool get wantKeepAlive => true;
}
