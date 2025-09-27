import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactProvider with ChangeNotifier {
  // 📞 Launch Phone
  Future<void> launchPhone(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint("❌ Could not launch phone: $phoneNumber. Maybe no dialer app?");
    }
  }

  // 📧 Launch Email
  Future<void> launchEmail(String email) async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Hello Aftab&body=I want to connect with you',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint("❌ Could not launch email: $email");
    }
  }

  // 🌐 Launch LinkedIn
  Future<void> launchLinkedIn(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("❌ Could not launch LinkedIn: $urlString");
    }
  }
}
