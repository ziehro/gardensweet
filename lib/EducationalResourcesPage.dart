import 'package:flutter/material.dart';
import 'EducationalResource.dart';
import 'package:url_launcher/url_launcher.dart';


class EducationalResourcesPage extends StatelessWidget {
  final List<EducationalResource> resources;

  EducationalResourcesPage(this.resources);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Resources'),
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          final resource = resources[index];
          return ListTile(
            title: Text(resource.title),
            subtitle: Text(resource.description),
            trailing: Icon(resource.type == ResourceType.Video
                ? Icons.video_library
                : Icons.article),
            onTap: () => _openResource(resource),
          );
        },
      ),
    );
  }

  void _openResource(EducationalResource resource) async {
    if (await canLaunch(resource.url)) {
      await launch(resource.url);
    } else {
      // Handle the error
    }
  }
}