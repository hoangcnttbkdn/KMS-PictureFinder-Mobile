part of 'facebook_cubit.dart';

class FacebookState extends Equatable {
  const FacebookState({
    this.loadingStatus = LoadingStatus.initial,
    this.accessToken = '',
    this.cookie = '',
    this.imageResult = const [],
    this.imagePath = '',
    this.fileSize = '',
    this.email = '',
    this.albumUrl = '',
    this.currentSessionId = 0,
  });

  final LoadingStatus loadingStatus;
  final String accessToken;
  final String cookie;
  final List<ImageResult> imageResult;
  final String imagePath;
  final String email;
  final String fileSize;
  final String albumUrl;
  final int currentSessionId;

  @override
  List<Object> get props {
    return [
      loadingStatus,
      accessToken,
      cookie,
      imageResult,
      imagePath,
      email,
      fileSize,
      albumUrl,
      currentSessionId,
    ];
  }

  FacebookState copyWith({
    LoadingStatus? loadingStatus,
    String? accessToken,
    String? cookie,
    List<ImageResult>? imageResult,
    String? imagePath,
    String? email,
    String? fileSize,
    String? albumUrl,
    int? currentSessionId,
  }) {
    return FacebookState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      accessToken: accessToken ?? this.accessToken,
      cookie: cookie ?? this.cookie,
      imageResult: imageResult ?? this.imageResult,
      imagePath: imagePath ?? this.imagePath,
      email: email ?? this.email,
      fileSize: fileSize ?? this.fileSize,
      albumUrl: albumUrl ?? this.albumUrl,
      currentSessionId: currentSessionId ?? this.currentSessionId,
    );
  }
}
