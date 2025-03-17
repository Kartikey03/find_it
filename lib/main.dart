import 'package:flutter/material.dart';

void main() {
  runApp(const FestApp());
}

class FestApp extends StatelessWidget {
  const FestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Fest App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
      routes: {
        '/eventsList': (context) => const EventsListPage(),
        '/eventDetails': (context) => const EventDetailsPage(),
      },
    );
  }
}

class Category {
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  Category({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class Event {
  final String name;
  final String description;
  final String location;
  final String date;
  final String time;
  final String imageUrl;
  final String category;

  Event({
    required this.name,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
    required this.imageUrl,
    required this.category,
  });
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample categories
    final List<Category> categories = [
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
        name: 'Creative',
        description: 'Art, photography, and other creative events',
        icon: Icons.brush,
        color: Colors.green,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('College Fest 2025'),
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
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade700, Colors.blue.shade900],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'COLLEGE FEST 2025',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'March 20-22, 2025',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore Events by Category',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
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

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Navigate to events listing for this category
          Navigator.pushNamed(
            context,
            '/eventsList',
            arguments: {'category': category.name},
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                category.icon,
                size: 32,
                color: category.color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                category.description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventsListPage extends StatelessWidget {
  const EventsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String categoryName = args['category'];

    // Generate sample events for the selected category
    final List<Event> events = _getEventsByCategory(categoryName);

    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName Events'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventCard(event: events[index]);
        },
      ),
    );
  }

  List<Event> _getEventsByCategory(String category) {
    // Sample events for each category
    if (category == 'Cultural') {
      return [
        Event(
          name: 'Dance Competition',
          description: 'Showcase your dancing skills and win exciting prizes!',
          location: 'Main Auditorium',
          date: 'March 20, 2025',
          time: '2:00 PM - 5:00 PM',
          imageUrl: 'assets/images/dance.jpg',
          category: 'Cultural',
        ),
        Event(
          name: 'Singing Contest',
          description: 'Show your vocal talent and captivate the audience!',
          location: 'Open Air Theatre',
          date: 'March 21, 2025',
          time: '4:00 PM - 7:00 PM',
          imageUrl: 'assets/images/singing.jpg',
          category: 'Cultural',
        ),
        Event(
          name: 'Drama Competition',
          description: 'Express yourself through acting and storytelling!',
          location: 'Mini Auditorium',
          date: 'March 22, 2025',
          time: '3:00 PM - 6:00 PM',
          imageUrl: 'assets/images/drama.jpg',
          category: 'Cultural',
        ),
      ];
    } else if (category == 'Technical') {
      return [
        Event(
          name: 'Hackathon',
          description: 'Code your way to solving real-world problems!',
          location: 'CS Department',
          date: 'March 20-21, 2025',
          time: '9:00 AM - 9:00 PM',
          imageUrl: 'assets/images/hackathon.jpg',
          category: 'Technical',
        ),
        Event(
          name: 'Robotics Workshop',
          description: 'Learn to build and program robots!',
          location: 'Robotics Lab',
          date: 'March 21, 2025',
          time: '10:00 AM - 2:00 PM',
          imageUrl: 'assets/images/robotics.jpg',
          category: 'Technical',
        ),
        Event(
          name: 'Tech Quiz',
          description: 'Test your technical knowledge and win prizes!',
          location: 'Lecture Hall 5',
          date: 'March 22, 2025',
          time: '11:00 AM - 1:00 PM',
          imageUrl: 'assets/images/techquiz.jpg',
          category: 'Technical',
        ),
      ];
    } else if (category == 'Management') {
      return [
        Event(
          name: 'Case Study Competition',
          description: 'Analyze and solve business problems!',
          location: 'Management Block',
          date: 'March 20, 2025',
          time: '10:00 AM - 4:00 PM',
          imageUrl: 'assets/images/casestudy.jpg',
          category: 'Management',
        ),
        Event(
          name: 'Business Plan Pitch',
          description: 'Present your innovative business ideas!',
          location: 'Conference Hall',
          date: 'March 21, 2025',
          time: '2:00 PM - 6:00 PM',
          imageUrl: 'assets/images/businessplan.jpg',
          category: 'Management',
        ),
        Event(
          name: 'Marketing Strategy Contest',
          description: 'Develop marketing strategies for real brands!',
          location: 'Seminar Hall',
          date: 'March 22, 2025',
          time: '12:00 PM - 4:00 PM',
          imageUrl: 'assets/images/marketing.jpg',
          category: 'Management',
        ),
      ];
    } else if (category == 'Creative') {
      return [
        Event(
          name: 'Art Exhibition',
          description: 'Showcase your artistic talents!',
          location: 'Art Gallery',
          date: 'March 20-22, 2025',
          time: '10:00 AM - 6:00 PM',
          imageUrl: 'assets/images/art.jpg',
          category: 'Creative',
        ),
        Event(
          name: 'Photography Contest',
          description: 'Capture moments and tell stories through your lens!',
          location: 'Exhibition Hall',
          date: 'March 21, 2025',
          time: '9:00 AM - 5:00 PM',
          imageUrl: 'assets/images/photography.jpg',
          category: 'Creative',
        ),
        Event(
          name: 'Creative Writing Workshop',
          description: 'Explore your writing skills and creativity!',
          location: 'Library Hall',
          date: 'March 22, 2025',
          time: '11:00 AM - 3:00 PM',
          imageUrl: 'assets/images/writing.jpg',
          category: 'Creative',
        ),
      ];
    }
    return [];
  }
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/eventDetails',
            arguments: {'event': event},
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image placeholder
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        event.date,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        event.time,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/eventDetails',
                        arguments: {'event': event},
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text('View Details'),
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

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Event event = args['event'];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with image
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                event.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Color.fromARGB(150, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Image placeholder
                  Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  // Gradient overlay for better text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Event details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event category badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(event.category),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      event.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Event details
                  const Text(
                    'Event Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Event information
                  _buildInfoRow(Icons.location_on, 'Location', event.location),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.calendar_today, 'Date', event.date),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.access_time, 'Time', event.time),
                  const SizedBox(height: 24),
                  // Registration section
                  const Text(
                    'Registration',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Register early to secure your spot. Limited seats available!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Registration coming soon!'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Get Directions for the Event',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.blue,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Cultural':
        return Colors.purple;
      case 'Technical':
        return Colors.blue;
      case 'Management':
        return Colors.orange;
      case 'Creative':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}