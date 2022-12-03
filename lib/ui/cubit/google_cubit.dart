import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/model/image_result.dart';
import 'package:pictures_finder/repo/image_repository.dart';
import 'package:platform_helper/platform_helper.dart';

part 'google_state.dart';

class GoogleCubit extends Cubit<GoogleState> {
  GoogleCubit({required this.imageRepository}) : super(const GoogleState());

  final ImageRepository imageRepository;

  void changeFolder({required String folderPath}) {
    emit(state.copyWith(url: folderPath));
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
    }
  }

  Future<void> findImages() async {
    try {
      log(state.imagePath);
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final imageList = await imageRepository.getYourFaceImageFromGoogleDrive(
        folderUrl: state.url,
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
