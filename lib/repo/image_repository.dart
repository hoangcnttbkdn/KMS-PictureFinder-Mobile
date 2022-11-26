import 'package:pictures_finder/data/facebook_datasource.dart';
import 'package:pictures_finder/data/google_datasource.dart';
import 'package:pictures_finder/model/image_result.dart';

class ImageRepository {
  ImageRepository({
    required this.googleDatasource,
    required this.facebookDatasource,
  });

  final GoogleDatasource googleDatasource;
  final FacebookDatasource facebookDatasource;
  
  Future<List<ImageResult>> getYourFaceImagefromGoogleDrive({
    required String folderUrl,
    required String imagePath,
  }) =>
      googleDatasource.getListResult(
        folderUrl: folderUrl,
        imagePath: imagePath,
      );
}
