import 'package:flutter/material.dart';

class AuthorDetails extends StatelessWidget {
  final Map<String, dynamic> authorDetails;

  const AuthorDetails({super.key, required this.authorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(authorDetails["name"] ?? "Author Details"),
      ),
      body: authorDetails.isEmpty
          ? const Center(child: Text("No details available"))
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${authorDetails["name"] ?? "Unknown"}"),
            Text("Birth Date: ${authorDetails["birth_date"] ?? "N/A"}"),
            Text(
              "Bio: ${authorDetails["bio"] is String ? authorDetails["bio"] : authorDetails["bio"]?["value"] ?? "N/A"}",
            ),
          ],
        ),
      ),
    );
  }
}
