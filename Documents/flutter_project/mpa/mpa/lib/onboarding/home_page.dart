import 'package:flutter/material.dart';
import '../../../models/content_item_model.dart';
import '../../../services/car_service.dart';
import '../widgets/content_card.dart';
import '../widgets/top_tab_bar.dart';
import '../../../themes/app_colors.dart';
import '../widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTabIndex = 0;
  int bottomNavIndex = 0;
  String searchQuery = '';

  final List<String> topTabs = [
    'News Café',
    'Editorial',
    'Media Center',
    'Market Place',
    'Events',
  ];

  final List<String> bottomNavSections = [
    'Feed',
    'Library',
    'MPA Mag',
    'Settings',
    'Industry Data',
    'Jobs',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
        resizeToAvoidBottomInset: true,
      backgroundColor: darkColor,
      appBar: CustomAppBar(
        onSearchChanged: (value) {
          setState(() {
            searchQuery = value.toLowerCase();
          });
        },
      ),
      body:
          SafeArea(
            child: bottomNavIndex == 0
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: isTablet ? 60 : 48,
                      child: TopTabBar(
                        tabs: topTabs,
                        selectedIndex: selectedTabIndex,
                        onTabSelected: (index) {
                          setState(() {
                            selectedTabIndex = index;
                            searchQuery = '';
                          });
                        },
                      ),
                    ),
                    SizedBox(height: isTablet ? 24 : 16),
                    Expanded(
                      child:
                          selectedTabIndex == 0
                              ? FutureBuilder<List<ContentItem>>(
                                future: CarService.loadLocalCarData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Center(
                                      child: Text('No content available.'),
                                    );
                                  }
            
                                  final filteredItems =
                                      snapshot.data!
                                          .where(
                                            (item) =>
                                                searchQuery.isEmpty ||
                                                item.title.toLowerCase().contains(
                                                  searchQuery,
                                                ) ||
                                                item.subtitle
                                                    .toLowerCase()
                                                    .contains(searchQuery),
                                          )
                                          .toList();
            
                                  if (filteredItems.isEmpty) {
                                    return const Center(
                                      child: Text('No results found.'),
                                    );
                                  }
            
                                  // Tablet uses grid, phone uses list
                                  if (isTablet) {
                                    return GridView.builder(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 8,
                                      ),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 16,
                                            mainAxisSpacing: 16,
                                            childAspectRatio: 3 / 2,
                                          ),
                                      itemCount: filteredItems.length,
                                      itemBuilder: (context, index) {
                                        return ContentCard(
                                          item: filteredItems[index],
                                        );
                                      },
                                    );
                                  } else {
                                    return ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      itemCount: filteredItems.length,
                                      itemBuilder: (context, index) {
                                        return ContentCard(
                                          item: filteredItems[index],
                                        );
                                      },
                                    );
                                  }
                                },
                              )
                              : Center(
                                child: Text(
                                  'No content available for "${topTabs[selectedTabIndex]}"',
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                    ),
                  ],
                )
                : Center(
                  child: Text(
                    'No content available for "${bottomNavSections[bottomNavIndex]}"',
                    style: const TextStyle(color: Colors.white54, fontSize: 18),
                  ),
                ),
          ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        onTap: (index) {
          setState(() {
            bottomNavIndex = index;
            selectedTabIndex = 0;
            searchQuery = '';
          });
        },
        backgroundColor: const Color(0xFF1C1C1E),
        selectedItemColor: Colors.white,
        unselectedItemColor: greyColor,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: 'Feed'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'MPA Mag',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Industry Data',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
        ],
      ),
    );
  }
}
