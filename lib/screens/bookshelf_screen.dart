import 'package:flutter/material.dart';

import '../controllers/bookshelf_controller.dart';
import '../models/book.dart';
import '../widgets/book_editor.dart';

class BookshelfScreen extends StatefulWidget {
  const BookshelfScreen({super.key});

  @override
  State<BookshelfScreen> createState() => _BookshelfScreenState();
}

class _BookshelfScreenState extends State<BookshelfScreen> {
  final _controller = BookshelfController();
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Bookshelf')),
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, _) {
                final books = _controller.visibleBooks;
                final draft = _controller.draft;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      key: const ValueKey('search'),
                      controller: _search,
                      onChanged: _controller.setQuery,
                      decoration: const InputDecoration(
                        labelText: 'Search titles',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(
                          label: const Text('All categories'),
                          selected: _controller.category == null,
                          onSelected: (_) => _controller.setCategory(null),
                        ),
                        for (final category in BookCategory.values)
                          FilterChip(
                            label: Text(category.label),
                            selected: _controller.category == category,
                            onSelected: (_) =>
                                _controller.setCategory(category),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton<BookSort>(
                            value: _controller.sort,
                            isExpanded: true,
                            items: BookSort.values
                                .map(
                                  (sort) => DropdownMenuItem(
                                    value: sort,
                                    child: Text(sort.label),
                                  ),
                                )
                                .toList(),
                            onChanged: (sort) {
                              if (sort != null) _controller.setSort(sort);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: _controller.resetFilters,
                          child: const Text('Reset filters'),
                        ),
                      ],
                    ),
                    Text('${books.length} ${books.length == 1 ? 'book' : 'books'}'),
                    const SizedBox(height: 8),
                    if (draft != null) ...[
                      BookEditor(
                        key: ValueKey(draft.id),
                        draft: draft,
                        onChanged: _controller.updateDraftTitle,
                        onSave: _controller.saveEditing,
                        onCancel: _controller.cancelEditing,
                      ),
                      const SizedBox(height: 8),
                    ],
                    Expanded(
                      child: books.isEmpty
                          ? const Center(
                              child: Text('No books match your filters.'),
                            )
                          : ListView(
                              children: [
                                for (final book in books)
                                  Card(
                                    key: ValueKey(book.id),
                                    child: ListTile(
                                      title: Text(book.title),
                                      subtitle: Text(
                                        '${book.category.label} • Added ${book.displayAddedDate}',
                                      ),
                                      trailing: IconButton(
                                        tooltip: 'Edit title',
                                        onPressed: draft == null
                                            ? () => _controller.startEditing(
                                                book.id,
                                              )
                                            : null,
                                        icon: const Icon(Icons.edit),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}
