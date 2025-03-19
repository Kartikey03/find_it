import 'package:flutter/material.dart';
import '../models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.1,
            child: Image.asset(
              'assets/images/${event.title}.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event name
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 20, // Increased font size for prominence
                    fontWeight: FontWeight.bold,
                     // Added color to match the tech theme
                  ),
                ),
                const SizedBox(height: 6),

                // Event details with more compact layout
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Expanded(child: Text(event.venue)),
                  ],
                ),
                const SizedBox(height: 3),

                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 4),
                    Text(event.date),
                  ],
                ),
                const SizedBox(height: 3),

                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 4),
                    Text(event.time),
                  ],
                ),

                if (event.fees.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.money, size: 16),
                      const SizedBox(width: 4),
                      Text('Fee: ${event.fees}'),
                    ],
                  ),
                ],

                // View details button
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () {
                      // Navigate to event details page
                      Navigator.pushNamed(
                        context,
                        '/eventDetails',
                        arguments: {'event': event},
                      );
                    },
                    child: const Text(
                      'View Details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}