import 'package:flutter/material.dart';
import 'package:mpa/themes/app_colors.dart';
import '../../../services/car_service.dart';
import '../models/content_item_model.dart';
import '../widgets/content_card.dart';
import '../widgets/top_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTabIndex = 0;
  int bottomNavIndex = 0;

  final List<String> topTabs = [
    'News Café',
    'Editorial',
    'Media Center',
    'Marketplace',
    'Events',
    'AI',
  ];

  final List<String> bottomNavSections = [
    'Feed',
    'Library',
    'MPA Mag',
    'Settings',
    'Industry Data',
    'Jobs',
  ];

  bool get isShowingHomepage => bottomNavIndex == 0 && selectedTabIndex == 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.account_circle, size: 30,),
              onPressed: () {
                // Navigate to profile
              },
            ),
            Image.asset('assets/images/logo.png', height: 40),
            IconButton(
              icon: const Icon(Icons.search, size: 30,),
              onPressed: () {
                // Open search
              },
            ),
          ],
        ),

        bottom:
            bottomNavIndex == 0
                ? PreferredSize(
                  preferredSize: const Size.fromHeight(48),
                  child: TopTabBar(
                    tabs: topTabs,
                    selectedIndex: selectedTabIndex,
                    onTabSelected: (index) {
                      setState(() => selectedTabIndex = index);
                    },
                  ),
                )
                : null,
      ),

      body: FutureBuilder<List<ContentItem>>(
        future: CarService.loadLocalCarData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No content available.'));
          }

          final allItems = snapshot.data!;
          List<ContentItem> visibleItems;

          if (isShowingHomepage) {
            visibleItems = allItems;
          } else if (bottomNavIndex == 0) {
            visibleItems =
                allItems
                    .where((item) => item.category == topTabs[selectedTabIndex])
                    .toList();
          } else {
            final category = bottomNavSections[bottomNavIndex];
            visibleItems =
                allItems.where((item) => item.category == category).toList();
          }

          final isTablet = MediaQuery.of(context).size.width > 600;

          return Padding(
            padding: const EdgeInsets.all(16),
            child:
                visibleItems.isEmpty
                    ? const Center(child: Text('No matching content.'))
                    : isTablet
                    ? Column(
                      children: [
                        const SizedBox(height: 16),
                        Expanded(
                          child: GridView.builder(
                            itemCount: visibleItems.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.72,
                                ),
                            itemBuilder: (context, index) {
                              return ContentCard(item: visibleItems[index]);
                            },
                          ),
                        ),
                      ],
                    )
                    : ListView.builder(
                      itemCount: visibleItems.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) return const SizedBox(height: 16);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ContentCard(item: visibleItems[index - 1]),
                        );
                      },
                    ),
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        onTap: (index) {
          setState(() {
            bottomNavIndex = index;
            selectedTabIndex = 0;
          });
        },
        backgroundColor: darkColor,
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
