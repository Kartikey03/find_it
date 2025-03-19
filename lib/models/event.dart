class Event {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String venue;
  final String ec;      // Event Coordinator
  final String ecContact;
  final String oc;      // Organizing Committee
  final String ocContact;
  final String evaluationScheme;
  final String prizes;
  final String fees;
  final String teamSize;
  final String imageAsset;
  final String category;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.venue,
    required this.ec,
    required this.ecContact,
    required this.oc,
    required this.ocContact,
    required this.evaluationScheme,
    required this.prizes,
    required this.fees,
    required this.teamSize,
    required this.category,
    required this.imageAsset,
  });

  // Factory constructor to create an Event from a map
  factory Event.fromMap(String id, Map<String, dynamic> map) {
    return Event(
      id: id,
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      date: map['date']?.toString() ?? '',
      time: map['time']?.toString() ?? '',
      venue: map['venue']?.toString() ?? '',
      ec: map['EC']?.toString() ?? '',
      ecContact: map['ECContact']?.toString() ?? '',
      oc: map['OC']?.toString() ?? '',
      ocContact: map['OCContact']?.toString() ?? '',
      evaluationScheme: map['evaluationScheme']?.toString() ?? '',
      prizes: map['prizes']?.toString() ?? '',
      fees: map['fees']?.toString() ?? '0',
      teamSize: map['teamSize']?.toString() ?? '',
      imageAsset: map['imageAsset']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
    );
  }

  // Convert an Event to a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'venue': venue,
      'EC': ec,
      'ECContact': ecContact,
      'OC': oc,
      'OCContact': ocContact,
      'evaluationScheme': evaluationScheme,
      'prizes': prizes,
      'fees': fees,
      'teamSize': teamSize,
      'imageAsset': imageAsset,
      'category': category,
    };
  }
}