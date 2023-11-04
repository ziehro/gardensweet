class EducationalResource {
  final String id;
  final String title;
  final String description;
  final String url;
  final ResourceType type;

  EducationalResource(this.id, this.title, this.description, this.url, this.type);
}

enum ResourceType { Article, Video, Tutorial }
