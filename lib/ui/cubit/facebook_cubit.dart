import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/model/image_result.dart';
import 'package:pictures_finder/repo/image_repository.dart';
import 'package:platform_helper/platform_helper.dart';

part 'facebook_state.dart';

class FacebookCubit extends Cubit<FacebookState> {
  FacebookCubit(this.imageRepository) : super(const FacebookState());

  final ImageRepository imageRepository;

  void changeCookie(String cookie) {
    emit(state.copyWith(cookie: cookie));
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
        emit(state.copyWith(imagePath: imagePath));
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
      final imageList = await imageRepository.getYourFaceImageFromFacebook(
        accessToken: state.accessToken,
        albumUrl: state.albumUrl,
        cookie: state.cookie,
        imagePath: state.imagePath,
      );
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.done,
          imageResult: imageList,
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
