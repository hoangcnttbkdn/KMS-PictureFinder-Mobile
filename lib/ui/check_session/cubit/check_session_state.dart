part of 'check_session_cubit.dart';

class CheckSessionState extends Equatable {
  const CheckSessionState({
    required this.session,
    this.loadingStatus = LoadingStatus.initial,
    this.result,
  });

  final SentSession session;
  final LoadingStatus loadingStatus;
  final Wrapper<SessionResult>? result;

  @override
  List<Object?> get props => [session, loadingStatus, result];

  CheckSessionState copyWith({
    SentSession? session,
    LoadingStatus? loadingStatus,
    Wrapper<SessionResult>? result,
  }) {
    return CheckSessionState(
      session: session ?? this.session,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      result: result ?? this.result,
    );
  }
}
