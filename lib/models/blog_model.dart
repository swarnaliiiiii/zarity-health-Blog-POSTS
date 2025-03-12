class BlogModel {
  final String id;
  final String imageURL;
  final String title;
  final String summary;
  final String content;
  final String deeplink;

  BlogModel({
    required this.id,
    required this.imageURL,
    required this.title,
    required this.summary,
    required this.content,
    required this.deeplink,
  });

  factory BlogModel.fromMap(String id, Map<String, dynamic> map) {
    return BlogModel(
      id: id,
      imageURL: map['imageURL'] ?? '',
      title: map['title'] ?? '',
      summary: map['summary'] ?? '',
      content: map['content'] ?? '',
      deeplink: map['deeplink'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageURL': imageURL,
      'title': title,
      'summary': summary,
      'content': content,
      'deeplink': deeplink,
    };
  }
}
