import 'package:flutter/material.dart';

class AuthorDetails extends StatelessWidget {
  final Map<String, dynamic> authorDetails;

  const AuthorDetails({super.key, required this.authorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(authorDetails["name"] ?? "Author Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${authorDetails["name"] ?? "Unknown"}"),
            const SizedBox(height: 10),
            Text("Birth Date: ${authorDetails["birth_date"] ?? "N/A"}"),
            const SizedBox(height: 10),
            Text("Bio: ${authorDetails["bio"] is String ? authorDetails["bio"] : authorDetails["bio"]?["value"] ?? "N/A"}"),
          ],
        ),
      ),
    );
  }
}
