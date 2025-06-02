import 'package:flutter/material.dart';
import 'package:mpa/themes/app_colors.dart';
import '../models/content_item_model.dart';

class ContentCard extends StatelessWidget {
  final ContentItem item;

  const ContentCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              item.image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Text content
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.category.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      item.category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: greyColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),

                if (item.subtitle.isNotEmpty) ...[
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                if (item.meta.isNotEmpty)
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: greyColor),
                      const SizedBox(width: 4),
                      Text(
                        item.meta,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
