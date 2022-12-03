
part of 'facebook_cubit.dart';

class FacebookState extends Equatable {
  const FacebookState({
    this.loadingStatus = LoadingStatus.initial,
    this.accessToken = '',
    this.cookie = '',
    this.imageResult = const [],
    this.imagePath = '',
    this.albumUrl = '',
  });

  final LoadingStatus loadingStatus;
  final String accessToken;
  final String cookie;
  final List<ImageResult> imageResult;
  final String imagePath;
  final String albumUrl;

  @override
  List<Object?> get props {
    return [
      loadingStatus,
      accessToken,
      cookie,
      imageResult,
      imagePath,
      albumUrl,
    ];
  }

  FacebookState copyWith({
    LoadingStatus? loadingStatus,
    String? accessToken,
    String? cookie,
    List<ImageResult>? imageResult,
    String? imagePath,
    String? albumUrl,
  }) {
    return FacebookState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      accessToken: accessToken ?? this.accessToken,
      cookie: cookie ?? this.cookie,
      imageResult: imageResult ?? this.imageResult,
      imagePath: imagePath ?? this.imagePath,
      albumUrl: albumUrl ?? this.albumUrl,
    );
  }
}
