
part of 'facebook_cubit.dart';

class FacebookState extends Equatable {
  const FacebookState({
    this.loadingStatus = LoadingStatus.initial,
    this.accessToken = '',
    this.cookie = '',
    this.imageResult = const [],
    this.data = '',
    this.fileSize = '',
    this.email = '',
    this.currentIndex = 0,
    this.albumUrl = '',
    this.currentSessionId = 0,
  });

  final LoadingStatus loadingStatus;
  final String accessToken;
  final String cookie;
  final List<ImageResult> imageResult;
  final String data;
  final String email;
  final String fileSize;
  final int currentIndex;
  final String albumUrl;
  final int currentSessionId;

  @override
  List<Object> get props {
    return [
      loadingStatus,
      accessToken,
      cookie,
      imageResult,
      data,
      email,
      fileSize,
      currentIndex,
      albumUrl,
      currentSessionId,
    ];
  }

  FacebookState copyWith({
    LoadingStatus? loadingStatus,
    String? accessToken,
    String? cookie,
    List<ImageResult>? imageResult,
    String? data,
    String? email,
    String? fileSize,
    int? currentIndex,
    String? albumUrl,
    int? currentSessionId,
  }) {
    return FacebookState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      accessToken: accessToken ?? this.accessToken,
      cookie: cookie ?? this.cookie,
      imageResult: imageResult ?? this.imageResult,
      data: data ?? this.data,
      email: email ?? this.email,
      fileSize: fileSize ?? this.fileSize,
      currentIndex: currentIndex ?? this.currentIndex,
      albumUrl: albumUrl ?? this.albumUrl,
      currentSessionId: currentSessionId ?? this.currentSessionId,
    );
  }
}
