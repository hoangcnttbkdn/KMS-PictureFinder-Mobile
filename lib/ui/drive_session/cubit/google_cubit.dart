import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/common/helpers/file_helper.dart';
import 'package:pictures_finder/repo/google_repository.dart';
import 'package:pictures_finder/repo/session_repository.dart';
import 'package:platform_helper/platform_helper.dart';

part 'google_state.dart';

class GoogleCubit extends Cubit<GoogleState> {
  GoogleCubit({required this.sessionRepository, required this.googleRepository})
      : super(const GoogleState());

  final SessionRepository sessionRepository;
  final GoogleRepository googleRepository;

  void changeFolder({required String folderPath}) {
    emit(state.copyWith(folderUrl: folderPath));
  }

  void changeEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void removeImagePath() {
    emit(state.copyWith(data: '', fileSize: ''));
  }

  void changeIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void changeBib(String bib) {
    emit(state.copyWith(data: bib));
  }

  Future<void> pickImageFromGallery() async {
    try {
      final imagePath = await ImagePickerHelper.pickImageFromSource(
        ImageSource.gallery,
        imageQuality: 40,
      );
      if (imagePath != null) {
        final imageSize = await getFileSize(filepath: imagePath, decimals: 2);
        emit(state.copyWith(data: imagePath, fileSize: imageSize));
        return;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> findImages() async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      if (state.currentIndex == 0) {
        final sessionId = await googleRepository.getFaceSession(
          folderUrl: state.folderUrl,
          imagePath: state.data,
          email: state.email.isEmpty ? null : state.email,
        );
        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.done,
            currentSessionId: sessionId,
          ),
        );
        return;
      }
      if (state.currentIndex == 1) {
        final sessionId = await googleRepository.getBidSession(
          folderUrl: state.folderUrl,
          bib: state.data,
          email: state.email.isEmpty ? null : state.email,
        );
        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.done,
            currentSessionId: sessionId,
          ),
        );
        return;
      }
      if (state.currentIndex == 2) {
        final sessionId = await googleRepository.getClothesSession(
          folderUrl: state.folderUrl,
          imagePath: state.data,
          email: state.email.isEmpty ? null : state.email,
        );
        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.done,
            currentSessionId: sessionId,
          ),
        );
        return;
      }
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
