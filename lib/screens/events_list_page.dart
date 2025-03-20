import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';
import '../services/firebase_service.dart';

class EventsListPage extends StatefulWidget {
  const EventsListPage({super.key});

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  final FirebaseService _firebaseService = FirebaseService();
  late Future<List<Event>> _eventsFuture;
  late String _categoryName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get arguments passed from previous screen
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    _categoryName = args['category'];

    // Fetch events for the selected category
    _eventsFuture = _firebaseService.getEventsByCategory(_categoryName);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width >= 600;
    final bool isDesktop = screenSize.width >= 900;

    // Determine number of grid columns based on screen width
    int crossAxisCount = 1;
    if (isDesktop) {
      crossAxisCount = 3;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('$_categoryName Events'),
      ),
      body: FutureBuilder<List<Event>>(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No events found'));
          } else {
            final events = snapshot.data!;

            // Use different layouts based on screen size
            if (isTablet || isDesktop) {
              // Grid layout for tablets and desktops
              return GridView.builder(
                padding: EdgeInsets.all(isDesktop ? 24 : 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: isDesktop ? 1.5 : 1.3,
                  crossAxisSpacing: isDesktop ? 20 : 16,
                  mainAxisSpacing: isDesktop ? 20 : 16,
                ),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return EventCard(event: events[index]);
                },
              );
            } else {
              // List layout for phones
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: EventCard(event: events[index]),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}

// Responsive loading indicator
class ResponsiveLoadingIndicator extends StatelessWidget {
  const ResponsiveLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Center(
      child: SizedBox(
        width: isLargeScreen ? 60.0 : 40.0,
        height: isLargeScreen ? 60.0 : 40.0,
        child: CircularProgressIndicator(
          strokeWidth: isLargeScreen ? 5.0 : 4.0,
        ),
      ),
    );
  }
}

// Responsive error message
class ResponsiveErrorMessage extends StatelessWidget {
  final String message;

  const ResponsiveErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: isLargeScreen ? 64.0 : 48.0,
              color: Colors.red,
            ),
            SizedBox(height: isLargeScreen ? 24.0 : 16.0),
            Text(
              message,
              style: TextStyle(
                fontSize: isLargeScreen ? 18.0 : 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}