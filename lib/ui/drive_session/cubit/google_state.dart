part of 'google_cubit.dart';

class GoogleState extends Equatable {
  const GoogleState({
    this.loadingStatus = LoadingStatus.initial,
    this.folderUrl = '',
    this.currentIndex = 0,
    this.data = '',
    this.email = '',
    this.fileSize = '',
    this.currentSessionId = 0,
  });

  final LoadingStatus loadingStatus;
  final String data;
  final String fileSize;
  final String folderUrl;
  final String email;
  final int currentIndex;
  final int currentSessionId;

  @override
  List<Object> get props {
    return [
      loadingStatus,
      data,
      fileSize,
      folderUrl,
      email,
      currentIndex,
      currentSessionId,
    ];
  }

  GoogleState copyWith({
    LoadingStatus? loadingStatus,
    String? data,
    String? fileSize,
    String? folderUrl,
    String? email,
    int? currentIndex,
    int? currentSessionId,
  }) {
    return GoogleState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      data: data ?? this.data,
      fileSize: fileSize ?? this.fileSize,
      folderUrl: folderUrl ?? this.folderUrl,
      email: email ?? this.email,
      currentIndex: currentIndex ?? this.currentIndex,
      currentSessionId: currentSessionId ?? this.currentSessionId,
    );
  }
}
