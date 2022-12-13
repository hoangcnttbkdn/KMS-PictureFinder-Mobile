import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/model/sent_session.dart';
import 'package:pictures_finder/model/session_result.dart';
import 'package:pictures_finder/model/wrapper.dart';
import 'package:pictures_finder/repo/image_repository.dart';

part 'check_session_state.dart';

class CheckSessionCubit extends Cubit<CheckSessionState> {
  CheckSessionCubit({
    required SentSession session,
    required this.imageRepository,
  }) : super(CheckSessionState(session: session)) {
    checkSessionResult();
  }

  final ImageRepository imageRepository;

  Future<void> checkSessionResult() async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final result = await imageRepository.getSessionResultById(
        sessionId: 83,
      );
      emit(
        state.copyWith(
          result: Wrapper(result),
          loadingStatus: LoadingStatus.done,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
      rethrow;
    }
  }
}
