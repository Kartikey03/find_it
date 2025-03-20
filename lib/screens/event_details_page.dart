import 'package:find_it/models/maps.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/event.dart';
import '../models/maps.dart';

class EventDetailsPage extends StatelessWidget {
  final List<Maps> mapLinks = [
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
      name: 'Adjacent to Vishveshwarya block',
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

    // Get screen size
    final Size screenSize = MediaQuery.of(context).size;
    final bool isLargeScreen = screenSize.width > 600;
    final double padding = screenSize.width > 600 ? 24.0 : 16.0;
    final double imageHeight = isLargeScreen ? screenSize.height * 0.4 : screenSize.width;

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
                // Event image with responsive height
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/${event.title}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),

                // Responsive layout for event details
                if (isLargeScreen)
                  _buildLargeScreenLayout(context, event, padding)
                else
                  _buildSmallScreenLayout(context, event, padding),

                // Add padding at the bottom to ensure content doesn't get hidden behind the fixed buttons
                SizedBox(height: MediaQuery.of(context).padding.bottom + 80),
              ],
            ),
          ),

          // Fixed buttons at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                  left: padding,
                  right: padding,
                  top: 16,
                  bottom: 16 + MediaQuery.of(context).padding.bottom
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Register button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 20 : 16),
                      ),
                      onPressed: () {
                        _launchURL('https://kolaahal.vercel.app/events/${event.category.toLowerCase()}/${event.title}/');
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: isLargeScreen ? 16 : 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: isLargeScreen ? 20 : 12), // Space between buttons

                  // Directions button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 20 : 16),
                      ),
                      onPressed: () {
                        _launchMaps(event.venue);
                      },
                      child: Text(
                        'Directions',
                        style: TextStyle(
                          fontSize: isLargeScreen ? 16 : 14,
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

  // Layout for large screens (tablets and desktops)
  Widget _buildLargeScreenLayout(BuildContext context, Event event, double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column - Basic info
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoItem(Icons.location_on, 'Venue', event.venue),
                _buildInfoItem(Icons.calendar_today, 'Date', event.date),
                _buildInfoItem(Icons.access_time, 'Time', event.time),
                _buildInfoItem(Icons.money, 'Entry Fee', event.fees),
                _buildInfoItem(Icons.people, 'Team Size', event.teamSize),
                _buildInfoItem(Icons.emoji_events, 'Prizes', event.prizes),
                const SizedBox(height: 20),
                const Text(
                  'Contact Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoItem(Icons.person, 'Event Coordinator', event.ec),
                _buildInfoItem(Icons.phone, 'EC Contact', event.ecContact),
                _buildInfoItem(Icons.person_outline, 'OC', event.oc),
                _buildInfoItem(Icons.phone_outlined, 'OC Contact', event.ocContact),
              ],
            ),
          ),

          const SizedBox(width: 32),

          // Right column - Description and evaluation
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  event.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Evaluation Criteria',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  event.evaluationScheme,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Layout for small screens (phones)
  Widget _buildSmallScreenLayout(BuildContext context, Event event, double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
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
      mapUrl = 'https://mappls.com/85pwur'; // College Campus as default
    }

    // Launch the URL
    final Uri uri = Uri.parse(mapUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch map at $mapUrl');
    }
  }
}