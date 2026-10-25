import 'package:flutter/material.dart';
import '../data/mock_events.dart';
import '../models/event.dart';
import '../widgets/empty_state.dart';
import '../widgets/event_card.dart';
import 'event_detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Event> _events;
  int _selectedIndex = 0;

  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Technology', 'Arts', 'Sports'];

  @override
  void initState() {
    super.initState();
    _events = getInitialEvents();
  }

  List<Event> _getFilteredEvents(List<Event> baseList) {
    final query = _searchController.text.trim().toLowerCase();
    return baseList.where((event) {
      final matchesQuery = query.isEmpty || event.title.toLowerCase().contains(query);
      final matchesCategory = _selectedCategory == 'All' || event.category == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedCategory = 'All';
    });
  }

  void _navigateToDetail(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailScreen(
          event: event,
          onStateChanged: () => setState(() {}),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilterBar() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[100],
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by title...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedCategory = cat);
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEventList(List<Event> filteredEvents, String emptyMessage) {
    if (filteredEvents.isEmpty) {
      return EmptyStateWidget(
        message: emptyMessage,
        onClearSearch: (_searchController.text.isNotEmpty || _selectedCategory != 'All')
            ? _clearFilters
            : null,
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Showing ${filteredEvents.length} event(s)',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredEvents.length,
            itemBuilder: (ctx, idx) {
              final event = filteredEvents[idx];
              return EventCard(
                event: event,
                onTap: () => _navigateToDetail(event),
                onFavoriteToggle: () => setState(() => event.isFavorite = !event.isFavorite),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Event> baseEvents;
    String emptyMessage;

    if (_selectedIndex == 0) {
      baseEvents = _events;
      emptyMessage = 'No events match your search or filter criteria.';
    } else if (_selectedIndex == 1) {
      baseEvents = _events.where((e) => e.isFavorite).toList();
      emptyMessage = 'No favorite events match your search/filters.';
    } else {
      baseEvents = _events.where((e) => e.isJoined).toList();
      emptyMessage = 'You have not joined any events matching this criteria.';
    }

    final displayedEvents = _getFilteredEvents(baseEvents);
    final totalJoinedCount = _events.where((e) => e.isJoined).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Event Explorer'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: _buildSearchAndFilterBar(),
        ),
      ),
      body: _buildEventList(displayedEvents, emptyMessage),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('$totalJoinedCount'),
              child: const Icon(Icons.event_available),
            ),
            label: 'My Events',
          ),
        ],
      ),
    );
  }
}