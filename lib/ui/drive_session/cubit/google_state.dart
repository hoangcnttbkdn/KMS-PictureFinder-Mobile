
part of 'google_cubit.dart';

class GoogleState extends Equatable {
  const GoogleState({
    this.loadingStatus = LoadingStatus.initial,
    this.folderUrl = '',
    this.imagePath = '', this.fileSize = '', 
    this.currentSessionId = 0,
  });

  final LoadingStatus loadingStatus;
  final String imagePath;
  final String fileSize;
  final String folderUrl;
  final int currentSessionId;

  @override
  List<Object> get props {
    return [
      loadingStatus,
      imagePath,
      fileSize,
      folderUrl,
      currentSessionId,
    ];
  }

  GoogleState copyWith({
    LoadingStatus? loadingStatus,
    String? imagePath,
    String? fileSize,
    String? folderUrl,
    int? currentSessionId,
  }) {
    return GoogleState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      imagePath: imagePath ?? this.imagePath,
      fileSize: fileSize ?? this.fileSize,
      folderUrl: folderUrl ?? this.folderUrl,
      currentSessionId: currentSessionId ?? this.currentSessionId,
    );
  }
}
