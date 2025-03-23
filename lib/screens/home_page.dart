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

    // Only keep the Cultural category
    final Category culturalCategory = Category(
      name: 'Cultural',
      description: 'Dance, music, drama and other cultural events',
      icon: Icons.music_note,
      color: Colors.red.shade700,
    );

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
                        'Explore cultural events and register now!',
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

          // Section title - updated for cultural focus
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(standardPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cultural Events',
                    style: TextStyle(
                      fontSize: isTablet ? 22 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Single category - centered to look good
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: standardPadding * 2,
                vertical: standardPadding,
              ),
              child: Center(
                child: SizedBox(
                  width: isTablet ? screenSize.width * 0.5 : screenSize.width * 0.7,
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: CategoryCard(category: culturalCategory),
                  ),
                ),
              ),
            ),
          ),

          // Optional: Additional content to fill space
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(standardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: standardPadding),
                  Text(
                    'Upcoming Cultural Highlights',
                    style: TextStyle(
                      fontSize: isTablet ? 20 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: standardPadding / 2),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(standardPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'The Cultural Category features exciting events including:',
                            style: TextStyle(
                              fontSize: isTablet ? 16 : 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: standardPadding / 2),
                          _buildHighlightItem(Icons.music_note, 'Dance competitions', colorScheme),
                          _buildHighlightItem(Icons.theater_comedy, 'Drama performances', colorScheme),
                          _buildHighlightItem(Icons.mic, 'Singing contests', colorScheme),
                          _buildHighlightItem(Icons.palette, 'Cultural exhibitions', colorScheme),
                          SizedBox(height: standardPadding / 2),
                          Text(
                            'Tap on the Cultural category card above to explore all events!',
                            style: TextStyle(
                              fontSize: isTablet ? 14 : 12,
                              fontStyle: FontStyle.italic,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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

  // Helper method to build highlight items
  Widget _buildHighlightItem(IconData icon, String text, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.red.shade700),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}