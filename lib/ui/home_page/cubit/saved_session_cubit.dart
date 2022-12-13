import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pictures_finder/model/sent_session.dart';
import 'package:pictures_finder/model/wrapper.dart';
import 'package:pictures_finder/repo/image_repository.dart';

part 'saved_session_state.dart';

class SavedSessionCubit extends Cubit<SavedSessionState> {
  SavedSessionCubit({required this.imageRepository})
      : super(const SavedSessionState()) {
    getSessionLiveData();
  }

  final ImageRepository imageRepository;

  void getSessionLiveData() {
    final listenable = imageRepository.getLiveSavedSessions();
    log(listenable.toString());
    emit(
      state.copyWith(
        savedSessionLiveData:
            Wrapper<ValueListenable<Box<SentSession>>>(listenable),
      ),
    );
  }
}
