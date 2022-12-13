part of 'view_result_cubit.dart';

class ViewResultState extends Equatable {
  const ViewResultState({
     this.imageResults = const <ImageResult>[],
     this.loadingStatus = LoadingStatus.initial,
    required this.sentSession,
  });

  final List<ImageResult> imageResults;
  final LoadingStatus loadingStatus;
  final SentSession sentSession;

  @override
  List<Object> get props => [imageResults, loadingStatus, sentSession];

  ViewResultState copyWith({
    List<ImageResult>? imageResults,
    LoadingStatus? loadingStatus,
    SentSession? sentSession,
  }) {
    return ViewResultState(
      imageResults: imageResults ?? this.imageResults,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      sentSession: sentSession ?? this.sentSession,
    );
  }
}
