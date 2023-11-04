import 'UserProfile.dart';
import 'Comment.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final UserProfile author;
  final DateTime timestamp;
  final List<Comment> comments;

  Post(this.id, this.title, this.content, this.author, this.timestamp, this.comments);
}