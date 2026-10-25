import '../models/event.dart';

List<Event> getInitialEvents() {
  return [
    Event(
      id: 'e1',
      title: 'AI & Robotics Tech Talk',
      category: 'Technology',
      dateTime: DateTime(2026, 11, 5, 14, 0),
      venue: 'Engineering Auditorium A',
      description: 'Join leading experts to discuss recent breakthroughs in AI and robotics.',
      imagePath: 'assets/images/tech.png',
      totalCapacity: 50,
      availablePlaces: 12,
    ),
    Event(
      id: 'e2',
      title: 'Annual Campus Art Exhibition',
      category: 'Arts',
      dateTime: DateTime(2026, 11, 10, 10, 0),
      venue: 'Student Center Gallery',
      description: 'Explore visual artworks created by talented students across campus.',
      imagePath: 'assets/images/art.png',
      totalCapacity: 30,
      availablePlaces: 0, // Initially FULL[cite: 1]
    ),
    Event(
      id: 'e3',
      title: 'Inter-Department Football Final',
      category: 'Sports',
      dateTime: DateTime(2026, 11, 12, 16, 30),
      venue: 'Main Sports Complex Stadium',
      description: 'Cheer for your team in the ultimate campus football championship.',
      imagePath: 'assets/images/sports.png',
      totalCapacity: 100,
      availablePlaces: 1, // Exactly ONE place available[cite: 1]
    ),
    Event(
      id: 'e4',
      title: 'Flutter Mobile App Hackathon',
      category: 'Technology',
      dateTime: DateTime(2026, 11, 18, 09, 0),
      venue: 'Computer Lab 3',
      description: 'A 24-hour hackathon building cross-platform mobile apps.',
      imagePath: 'assets/images/tech.png',
      totalCapacity: 25,
      availablePlaces: 8,
    ),
    Event(
      id: 'e5',
      title: 'Acoustic Guitar Night',
      category: 'Arts',
      dateTime: DateTime(2026, 11, 20, 19, 0),
      venue: 'Open Air Amphitheater',
      description: 'An evening of live acoustic melodies under the stars.',
      imagePath: 'assets/images/art.png',
      totalCapacity: 40,
      availablePlaces: 15,
    ),
    Event(
      id: 'e6',
      title: '3v3 Basketball Tournament',
      category: 'Sports',
      dateTime: DateTime(2026, 11, 25, 15, 0),
      venue: 'Outdoor Basketball Courts',
      description: 'Fast-paced streetball competition with exciting prizes.',
      imagePath: 'assets/images/sports.png',
      totalCapacity: 16,
      availablePlaces: 5,
    ),
  ];
}