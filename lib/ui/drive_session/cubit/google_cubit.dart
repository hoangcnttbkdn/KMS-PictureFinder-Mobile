import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/common/helpers/file_helper.dart';
import 'package:pictures_finder/repo/image_repository.dart';
import 'package:platform_helper/platform_helper.dart';

part 'google_state.dart';

class GoogleCubit extends Cubit<GoogleState> {
  GoogleCubit({required this.imageRepository}) : super(const GoogleState());

  final ImageRepository imageRepository;

  void changeFolder({required String folderPath}) {
    emit(state.copyWith(folderUrl: folderPath));
  }

  void removeImagePath() {
    emit(state.copyWith(imagePath: '', fileSize: ''));
  }

  Future<void> pickImageFromGallery() async {
    try {
      final imagePath = await ImagePickerHelper.pickImageFromSource(
        ImageSource.gallery,
        imageQuality: 40,
      );
      if (imagePath != null) {
        final imageSize = await getFileSize(filepath: imagePath, decimals: 2);
        emit(state.copyWith(imagePath: imagePath, fileSize: imageSize));
        return;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> findImages() async {
    try {
      log(state.imagePath);
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final sessionId = await imageRepository.getSessionFromGoogle(
        folderUrl: state.folderUrl,
        imagePath: state.imagePath,
      );
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.done,
          currentSessionId: sessionId,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
        ),
      );
      log(e.toString());
      rethrow;
    }
  }
}
