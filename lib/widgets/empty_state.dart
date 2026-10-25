import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onClearSearch;

  const EmptyStateWidget({
    Key? key,
    required this.message,
    this.onClearSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            if (onClearSearch != null) ...[
              const SizedBox(height: 12),
              TextButton(
                onPressed: onClearSearch,
                child: const Text('Clear Search / Filters'),
              ),
            ]
          ],
        ),
      ),
    );
  }
}