import 'package:flutter/material.dart';
import 'package:mpa/themes/app_colors.dart';
import '../models/content_item_model.dart';

class ContentCard extends StatelessWidget {
  final ContentItem item;

  const ContentCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Container(
        // Only apply bottom margin for non-tablet (ListView) layout
        margin: isTablet ? EdgeInsets.zero : const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: darkColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                item.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.category,
                    style: TextStyle(fontSize: 12, color: greyColor),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.dateRead,
                    style: TextStyle(fontSize: 12, color: greyColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
