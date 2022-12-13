part of 'saved_session_cubit.dart';

class SavedSessionState extends Equatable {
  const SavedSessionState({this.savedSessionLiveData});

  final Wrapper<ValueListenable<Box<SentSession>>?>? savedSessionLiveData;

  @override
  List<Object?> get props => [savedSessionLiveData];

  SavedSessionState copyWith({
    Wrapper<ValueListenable<Box<SentSession>>?>? savedSessionLiveData,
  }) {
    return SavedSessionState(
      savedSessionLiveData: savedSessionLiveData ?? this.savedSessionLiveData,
    );
  }
}
