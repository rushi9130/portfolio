class ProjectInfoModel {
  String? id;
  String projectName;
  String projectDis;
  bool? isMobile;
  String gitHubLink;
  List<String> technoloty;
  List<MediaAsset> mediaAssets;

  ProjectInfoModel({
    this.id,
    required this.projectName,
    this.isMobile = true,
    required this.projectDis,
    required this.technoloty,
    required this.gitHubLink,
    this.mediaAssets = const [],
  });
}

class MediaAsset {
  final String url;
  final String type;

  const MediaAsset({required this.url, required this.type});
}
