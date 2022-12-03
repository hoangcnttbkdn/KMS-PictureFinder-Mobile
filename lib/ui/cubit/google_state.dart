part of 'google_cubit.dart';



class GoogleState extends Equatable {
  const GoogleState({
    this.loadingStatus = LoadingStatus.initial,
    this.imageResult = const [],
    this.url = '',
    this.imagePath = '',
    this.isFacebook = false,
  });

  final LoadingStatus loadingStatus;
  final List<ImageResult> imageResult;
  final String url;
  final String imagePath;
  final bool isFacebook;

  GoogleState copyWith({
    LoadingStatus? loadingStatus,
    List<ImageResult>? imageResult,
    String? url,
    String? imagePath,
    bool? isFacebook,
  }) {
    return GoogleState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      imageResult: imageResult ?? this.imageResult,
      url: url ?? this.url,
      imagePath: imagePath ?? this.imagePath,
      isFacebook: isFacebook ?? this.isFacebook,
    );
  }

  @override
  List<Object?> get props =>
      [loadingStatus, imageResult, url, imagePath, isFacebook];
}
