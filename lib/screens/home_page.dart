import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import '../models/event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    // Get device dimensions for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;
    final double paddingScale = screenSize.width * 0.04;
    final double standardPadding = paddingScale.clamp(12.0, 24.0);

    // Theme colors for consistent styling
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final List<Category> categories = [
      Category(
        name: 'Cultural',
        description: 'Dance, music, drama and other cultural events',
        icon: Icons.music_note,
        color: Colors.purple.shade600,
      ),
      Category(
        name: 'Technical',
        description: 'Coding, robotics, and other technical events',
        icon: Icons.code,
        color: Colors.blue.shade600,
      ),
      Category(
        name: 'Management',
        description: 'Case studies, business plans and management events',
        icon: Icons.business,
        color: Colors.orange.shade600,
      ),
      Category(
        name: 'Creativity',
        description: 'Art, photography, and other creative events',
        icon: Icons.brush,
        color: Colors.green.shade600,
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header with college fest banner
          SliverToBoxAdapter(
            child: Stack(
              children: [
                // Banner image with gradient overlay
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(Rect.fromLTRB(0, 180, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    height: screenSize.height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/kolaahal_banenr.png'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(isTablet ? 30.0 : 20.0),
                        bottomRight: Radius.circular(isTablet ? 30.0 : 20.0),
                      ),
                    ),
                  ),
                ),
                // Overlay text for banner
                Positioned(
                  bottom: 20,
                  left: standardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: standardPadding / 1.5,
                          vertical: standardPadding / 3,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'MAR 26-28',
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: standardPadding / 2),
                      Text(
                        'Annual Fest',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isTablet ? 24 : 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: const Offset(1, 1),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: standardPadding / 4),
                      Text(
                        'Explore events and register now!',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: isTablet ? 16 : 14,
                          shadows: [
                            Shadow(
                              offset: const Offset(1, 1),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Section title
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(standardPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Event Categories',
                    style: TextStyle(
                      fontSize: isTablet ? 22 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Category grid
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: standardPadding),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet ? 3 : 2,
                crossAxisSpacing: standardPadding,
                mainAxisSpacing: standardPadding,
                childAspectRatio: isTablet ? 1.2 : 1.05,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return CategoryCard(category: categories[index]);
                },
                childCount: categories.length,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Show "Coming soon" snackbar when any tab is pressed
          if (index != 0) { // Only show for non-home tabs
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Coming soon'),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.fixed,
              ),
            );
          }
        },
      ),
    );
  }
}