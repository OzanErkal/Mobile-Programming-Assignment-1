import 'package:flutter/material.dart';
import '../models/event.dart';
import 'image_viewer_screen.dart';

class EventDetailScreen extends StatefulWidget {
  final Event event;
  final VoidCallback onStateChanged;

  const EventDetailScreen({
    Key? key,
    required this.event,
    required this.onStateChanged,
  }) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  void _toggleFavorite() {
    setState(() {
      widget.event.isFavorite = !widget.event.isFavorite;
    });
    widget.onStateChanged();
  }

  void _showJoinDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Participation'),
        content: Text(
          'Do you want to join "${widget.event.title}"?\n\n'
          'Date: ${widget.event.dateTime.day}/${widget.event.dateTime.month}/${widget.event.dateTime.year}\n'
          'Venue: ${widget.event.venue}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                widget.event.isJoined = true;
                widget.event.availablePlaces--;
              });
              widget.onStateChanged();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Successfully joined the event!')),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Participation'),
        content: Text('Are you sure you want to cancel your participation in "${widget.event.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                widget.event.isJoined = false;
                widget.event.availablePlaces++;
              });
              widget.onStateChanged();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Participation canceled.')),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        actions: [
          IconButton(
            icon: Icon(
              event.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: event.isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageViewerScreen(
                      imagePath: event.imagePath,
                      title: event.title,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Image.asset(
                    event.imagePath,
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      color: Colors.black54,
                      child: const Row(
                        children: [
                          Icon(Icons.touch_app, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text('Double tap to enlarge', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(label: Text(event.category)),
                  const SizedBox(height: 8),
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, color: Colors.indigo),
                      const SizedBox(width: 8),
                      Text(
                        '${event.dateTime.day}/${event.dateTime.month}/${event.dateTime.year} at ${event.dateTime.hour}:${event.dateTime.minute.toString().padLeft(2, '0')}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.indigo),
                      const SizedBox(width: 8),
                      Text(event.venue),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.people, color: Colors.indigo),
                      const SizedBox(width: 8),
                      Text('${event.availablePlaces} available / ${event.totalCapacity} total capacity'),
                    ],
                  ),
                  const Divider(height: 32),
                  const Text('About Event', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(event.description, style: const TextStyle(fontSize: 15, height: 1.4)),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Builder(
                      builder: (context) {
                        if (event.isJoined) {
                          return ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: _showCancelDialog,
                            icon: const Icon(Icons.cancel, color: Colors.white),
                            label: const Text('Cancel Participation', style: TextStyle(color: Colors.white)),
                          );
                        } else if (event.isFull) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                            onPressed: null,
                            child: const Text('Full (No Places Available)'),
                          );
                        } else {
                          return ElevatedButton.icon(
                            onPressed: _showJoinDialog,
                            icon: const Icon(Icons.check_circle),
                            label: const Text('Join Event'),
                          );
                        }
                      },
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
}