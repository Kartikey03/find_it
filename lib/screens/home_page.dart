import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List categories = [
      Category(
        name: 'Cultural',
        description: 'Dance, music, drama and other cultural events',
        icon: Icons.music_note,
        color: Colors.purple,
      ),
      Category(
        name: 'Technical',
        description: 'Coding, robotics, and other technical events',
        icon: Icons.code,
        color: Colors.blue,
      ),
      Category(
        name: 'Management',
        description: 'Case studies, business plans and management events',
        icon: Icons.business,
        color: Colors.orange,
      ),
      Category(
        name: 'Creativity',
        description: 'Art, photography, and other creative events',
        icon: Icons.brush,
        color: Colors.green,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kolaahal 2025'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              // Show campus map or location services
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Campus Map Coming Soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Show notifications
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications Coming Soon!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with college fest banner
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset('assets/images/kolaahal_banenr.png')
          ),
          // Category grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(category: categories[index]);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
          // Handle navigation bar tap
        },
      ),
    );
  }
}