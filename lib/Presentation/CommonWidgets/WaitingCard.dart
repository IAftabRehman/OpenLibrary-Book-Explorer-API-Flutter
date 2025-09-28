import 'package:flutter/material.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomText.dart';

/// Custom Waiting Card Widget
MyContainer waitingCard(String text) {
  return MyContainer(
    color: Colors.red.withValues(alpha: 0.7),
    borderRadius: BorderRadius.circular(10),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        const Center(child: CircularProgressIndicator()),
        const SizedBox(height: 20),
        MyText(
          text: text,
          size: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
