import 'package:flutter/material.dart';

import '../models/book.dart';

class BookEditor extends StatefulWidget {
  const BookEditor({
    super.key,
    required this.draft,
    required this.onChanged,
    required this.onSave,
    required this.onCancel,
  });

  final Book draft;
  final ValueChanged<String> onChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  State<BookEditor> createState() => _BookEditorState();
}

class _BookEditorState extends State<BookEditor> {
  late final _title = TextEditingController(text: widget.draft.title);

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Edit book title'),
          const SizedBox(height: 8),
          TextField(
            key: const ValueKey('edit-title'),
            controller: _title,
            onChanged: widget.onChanged,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: widget.onCancel,
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: widget.draft.title.trim().isEmpty
                    ? null
                    : widget.onSave,
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
