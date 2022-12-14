import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/common/helpers/file_helper.dart';
import 'package:pictures_finder/model/image_result.dart';
import 'package:pictures_finder/repo/image_repository.dart';
import 'package:platform_helper/platform_helper.dart';

part 'facebook_state.dart';

class FacebookCubit extends Cubit<FacebookState> {
  FacebookCubit({required this.imageRepository}) : super(const FacebookState());

  final ImageRepository imageRepository;

  void changeCookie(String cookie) {
    emit(state.copyWith(cookie: cookie));
  }

  void changeEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void changeAlbumUrl(String albumUrl) {
    emit(state.copyWith(albumUrl: albumUrl));
  }

  void changeAccessToken(String accessToken) {
    emit(state.copyWith(accessToken: accessToken));
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
      rethrow;
    }
  }

  Future<void> findImages() async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final sessionId = await imageRepository.getSessionFromFacebook(
        accessToken: state.accessToken,
        albumUrl: state.albumUrl,
        cookie: state.cookie,
        imagePath: state.imagePath,
        email: state.email.isEmpty ? null : state.email,
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

  void removeImagePath() {
    emit(state.copyWith(imagePath: '', fileSize: ''));
  }
}
