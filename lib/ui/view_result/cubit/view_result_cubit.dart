import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/model/image_result.dart';
import 'package:pictures_finder/model/sent_session.dart';
import 'package:pictures_finder/repo/session_repository.dart';

part 'view_result_state.dart';

class ViewResultCubit extends Cubit<ViewResultState> {
  ViewResultCubit({
    required SentSession sentSession,
    required SessionRepository imageRepository,
  })  : _imageRepository = imageRepository,
        super(ViewResultState(sentSession: sentSession)) {
    getImageResultFromSessionId();
  }

  final SessionRepository _imageRepository;

  Future<void> getImageResultFromSessionId() async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final imageResults = await _imageRepository.getImageResultById(
        sessionId: state.sentSession.sessionId,
      );
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.done,
          imageResults: imageResults,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
        ),
      );
      rethrow;
    }
  }
}
