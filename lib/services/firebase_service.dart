import 'package:firebase_database/firebase_database.dart';
import '../models/event.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Get events from a specific category
  Future<List<Event>> getEventsByCategory(String category) async {
    try {
      // Reference to the specific category under 'activities' node
      final eventSnapshot = await _database.child('activities/${category.toLowerCase()}').get();

      if (!eventSnapshot.exists) {
        return [];
      }

      // Parse the data
      Map<dynamic, dynamic> eventsMap = eventSnapshot.value as Map<dynamic, dynamic>;
      List<Event> events = [];

      eventsMap.forEach((key, value) {
        // Print the data for debugging
        print('Event ID: $key, Data Type: ${value.runtimeType}');

        if (value is Map<dynamic, dynamic>) {
          try {
            // Based on your database structure, create an Event object
            Event event = Event(
              id: key.toString(),
              title: value['title']?.toString() ?? '',
              description: value['description']?.toString() ?? '',
              date: value['date']?.toString() ?? '',
              time: value['time']?.toString() ?? '',
              venue: value['venue']?.toString() ?? '',
              ec: value['EC']?.toString() ?? '',
              ecContact: value['ECContact']?.toString() ?? '',
              oc: value['OC']?.toString() ?? '',
              ocContact: value['OCContact']?.toString() ?? '',
              evaluationScheme: value['evaluationScheme']?.toString() ?? '',
              prizes: value['prizes']?.toString() ?? '',
              fees: value['fees']?.toString() ?? '0',
              teamSize: value['teamSize']?.toString() ?? '',
              category: category,
            );

            events.add(event);
          } catch (e) {
            print('Error parsing event $key: $e');
          }
        }
      });

      return events;
    } catch (e) {
      print('Error fetching events from category $category: $e');
      return [];
    }
  }

  // Get all events from all categories
  Future<Map<String, List<Event>>> getAllActivities() async {
    try {
      // Reference to the 'activities' node
      final activitiesSnapshot = await _database.child('activities').get();

      if (!activitiesSnapshot.exists) {
        return {};
      }

      // Parse the data
      Map<dynamic, dynamic> categoriesMap = activitiesSnapshot.value as Map<dynamic, dynamic>;
      Map<String, List<Event>> allActivities = {};

      // Iterate through each category
      categoriesMap.forEach((category, categoryData) {
        if (categoryData is Map<dynamic, dynamic>) {
          List<Event> categoryEvents = [];

          // Iterate through events in this category
          categoryData.forEach((eventId, eventData) {
            if (eventData is Map<dynamic, dynamic>) {
              try {
                // Create Event object using the same structure as above
                Event event = Event(
                  id: eventId.toString(),
                  title: eventData['title']?.toString() ?? '',
                  description: eventData['description']?.toString() ?? '',
                  date: eventData['date']?.toString() ?? '',
                  time: eventData['time']?.toString() ?? '',
                  venue: eventData['venue']?.toString() ?? '',
                  ec: eventData['EC']?.toString() ?? '',
                  ecContact: eventData['ECContact']?.toString() ?? '',
                  oc: eventData['OC']?.toString() ?? '',
                  ocContact: eventData['OCContact']?.toString() ?? '',
                  evaluationScheme: eventData['evaluationScheme']?.toString() ?? '',
                  prizes: eventData['prizes']?.toString() ?? '',
                  fees: eventData['fees']?.toString() ?? '0',
                  teamSize: eventData['teamSize']?.toString() ?? '',
                  category: category.toString(),
                );

                categoryEvents.add(event);
              } catch (e) {
                print('Error parsing event $eventId: $e');
              }
            }
          });

          allActivities[category.toString()] = categoryEvents;
        }
      });

      return allActivities;
    } catch (e) {
      print('Error fetching all activities: $e');
      return {};
    }
  }

  // Get list of all activity categories
  Future<List<String>> getActivityCategories() async {
    try {
      final snapshot = await _database.child('activities').get();

      if (!snapshot.exists) {
        return [];
      }

      Map<dynamic, dynamic> categoriesMap = snapshot.value as Map<dynamic, dynamic>;
      return categoriesMap.keys.map((key) => key.toString()).toList();
    } catch (e) {
      print('Error fetching activity categories: $e');
      return [];
    }
  }
}