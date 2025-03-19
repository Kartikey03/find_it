import 'package:find_it/models/maps.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/event.dart';
import '../models/maps.dart';

class EventDetailsPage extends StatelessWidget {

  final List<Maps> mapLinks =
  [
    Maps(
      name: 'Raman Block',
      link: 'https://mappls.com/6w1zhc',
    ),
    Maps(
      name: 'Raman Block (B4) 107',
      link: 'https://mappls.com/6w1zhc',
    ),
    Maps(
      name: 'Audi 4',
      link: 'https://mappls.com/6w1zhc',
    ),
    Maps(
      name: 'Audi 5',
      link: 'https://mappls.com/6w1zhc',
    ),
    Maps(
      name: 'Audi 6',
      link: 'https://mappls.com/6w1zhc',
    ),
    Maps(
      name: 'Raman Block Basement',
      link: 'https://mappls.com/6w1zhc',
    ),
    Maps(
      name: 'AICTE Idea Lab',
      link: 'https://mappls.com/a2zils',
    ),
    Maps(
      name: 'Expo Stalls',
      link: 'http://www.mappls.com/dded9t',
    ),
    Maps(
      name: 'Ground opp. to Boys Hostel 2',
      link: 'http://www.mappls.com/jrh1hb',
    ),
    Maps(
      name: 'Adjacent to Vishveshwarya Block',
      link: 'http://www.mappls.com/pzo36x',
    ),
    Maps(
      name: 'Main Stage',
      link: 'http://www.mappls.com/zysfo8',
    ),
    Maps(
      name: 'College Campus',
      link: 'http://www.mappls.com/85pwur',
    ),
    Maps(
      name: 'Volleyball Ground',
      link: 'http://www.mappls.com/c0twve',
    ),
  ];

  EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    final Event event = args['event'];

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event image
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.asset(
                    'assets/images/${event.title}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event title
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Basic event info
                      _buildInfoItem(Icons.location_on, 'Venue', event.venue),
                      _buildInfoItem(Icons.calendar_today, 'Date', event.date),
                      _buildInfoItem(Icons.access_time, 'Time', event.time),
                      _buildInfoItem(Icons.money, 'Entry Fee', event.fees),
                      _buildInfoItem(Icons.people, 'Team Size', event.teamSize),
                      _buildInfoItem(Icons.emoji_events, 'Prizes', event.prizes),

                      const Divider(height: 32),

                      // Event description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(event.description),

                      const SizedBox(height: 16),
                      const Text(
                        'Evaluation Criteria',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(event.evaluationScheme),

                      const Divider(height: 32),

                      // Contact information
                      const Text(
                        'Contact Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoItem(Icons.person, 'Event Coordinator', event.ec),
                      _buildInfoItem(Icons.phone, 'EC Contact', event.ecContact),
                      _buildInfoItem(Icons.person_outline, 'OC', event.oc),
                      _buildInfoItem(Icons.phone_outlined, 'OC Contact', event.ocContact),

                      // Add padding at the bottom to ensure content doesn't get hidden behind the fixed buttons
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Fixed buttons at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Register button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        _launchURL('https://kolaahal.vercel.app/events/${event.category.toLowerCase()}/${event.title}/');
                      },
                      child: const Text('Register'),
                    ),
                  ),

                  const SizedBox(width: 12), // Space between buttons

                  // Directions button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        _launchMaps(event.venue);
                      },
                      child: const Text('Directions'),
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

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchMaps(String venue) async {
    // Find the appropriate map link based on the venue
    String mapUrl = '';

    // Look for an exact match first
    for (var map in mapLinks) {
      if (map.name == venue) {
        mapUrl = map.link;
        break;
      }
    }

    // If no exact match, check if the venue contains any of the map names
    if (mapUrl.isEmpty) {
      for (var map in mapLinks) {
        if (venue.contains(map.name)) {
          mapUrl = map.link;
          break;
        }
      }
    }

    // If still no match, use a default map link
    if (mapUrl.isEmpty) {
      // Use a default map - you can decide which one
      mapUrl = 'https://mappls.com/85pwur'; // College Campus as default
    }

    // Launch the URL
    final Uri uri = Uri.parse(mapUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch map at $mapUrl');
    }
  }
}