class ProjectModel {
  final String name;
  final String imageUrl;
  final String duration;
  final String uploader;
  final String description;
  final int likes;
  final int comments;
  final String category;

  ProjectModel({
    required this.name,
    required this.imageUrl,
    required this.duration,
    required this.uploader,
    required this.description,
    required this.likes,
    required this.comments,
    required this.category,
  });
}
