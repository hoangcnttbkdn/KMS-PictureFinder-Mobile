import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/model/image_result.dart';
import 'package:pictures_finder/repo/image_repository.dart';
import 'package:platform_helper/platform_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.imageRepository}) : super(const HomeState());

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
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final imageList = await imageRepository.getYourFaceImagefromGoogleDrive(
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
      log(e.toString());
      rethrow;
    }
  }
}
