import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<String> onSearchChanged;

  const CustomAppBar({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min, // size to content, avoid overflow
        children: [
          Container(
            height: kToolbarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [
                Center(
                  child: Image.asset('assets/images/logo.png', height: 40),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.person_outline,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Profile action
                    },
                  ),
                ),
              ],
            ),
          ),
          // Search bar below the app bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: _SearchBar(onChanged: onSearchChanged),
          ),
          const SizedBox(height: 12), // <-- added space below search bar
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(132);
}

// Private SearchBar widget inside the same file
class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(color: greyColor),
        prefixIcon: const Icon(Icons.search, color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF2C2C2E),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
