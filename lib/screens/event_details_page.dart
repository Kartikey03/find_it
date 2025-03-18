import 'package:flutter/material.dart';
import '../models/event.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    final Event event = args['event'];

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                'assets/images/kolaahal_banenr.png',
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

                  ...[
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
                ],

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

                  const SizedBox(height: 24),

                  // Register button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        // Add registration logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registration feature coming soon!')),
                        );
                      },
                      child: const Text('Register Now'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
}