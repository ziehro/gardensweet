import 'package:flutter/material.dart';
import 'models/UserProfile.dart';
import 'models/Post.dart';



class CommunityPage extends StatefulWidget {

    @override

  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final List<Post> posts = [
    Post(
        '1',
        'First Post',
        'I like Permaculture.',
        UserProfile('1', 'Alice', 'avatar_url'),
        DateTime.now(),
        []
    ),
    Post(
        '2',
        'Second Post',
        'Trees are neat.',
        UserProfile('2', 'Bob', 'avatar_url'),
        DateTime.now(),
        []
    ),
    // ... add more posts as needed
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return ListTile(
            title: Text(post.title),
            subtitle: Text('by ${post.author.name}'),
            onTap: () => _viewPost(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createPost,
        child: Icon(Icons.add),
      ),
    );
  }

  void _viewPost(int index) {
    // Navigate to a page to view the selected post
  }

  void _createPost() {
    // Navigate to a page to create a new post
  }
}
