import 'UserProfile.dart';

class Comment {
  final String id;
  final String content;
  final UserProfile author;
  final DateTime timestamp;

  Comment(this.id, this.content, this.author, this.timestamp);
}