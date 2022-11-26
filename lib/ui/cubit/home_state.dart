part of 'home_cubit.dart';

enum LoadingStatus { initial, loading, error, done }

class HomeState extends Equatable {
  const HomeState({
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

  HomeState copyWith({
    LoadingStatus? loadingStatus,
    List<ImageResult>? imageResult,
    String? url,
    String? imagePath,
    bool? isFacebook,
  }) {
    return HomeState(
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
