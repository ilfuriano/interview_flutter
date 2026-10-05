import 'package:flutter/foundation.dart';

import '../models/book.dart';

class BookshelfController extends ChangeNotifier {
  List<Book> _books = [
    Book(
      id: 1,
      title: 'The Long Journey',
      category: BookCategory.fiction,
      addedAt: DateTime(2024, 12, 20),
    ),
    Book(
      id: 2,
      title: 'Practical Flutter',
      category: BookCategory.technology,
      addedAt: DateTime(2025, 1, 10),
    ),
    Book(
      id: 3,
      title: 'A Weekend in Rome',
      category: BookCategory.travel,
      addedAt: DateTime(2025, 3, 2),
    ),
    Book(
      id: 4,
      title: 'The Quiet Garden',
      category: BookCategory.fiction,
      addedAt: DateTime(2025, 2, 15),
    ),
  ];
  String _query = '';
  BookCategory? _category;
  BookSort _sort = BookSort.newest;
  Book? _draft;

  String get query => _query;
  BookCategory? get category => _category;
  BookSort get sort => _sort;
  Book? get draft => _draft;

  List<Book> get visibleBooks {
    final predicates = <bool Function(Book)>[];
    final normalizedQuery = _query.trim().toLowerCase();
    if (normalizedQuery.isNotEmpty) {
      predicates.add(
        (book) => book.title.toLowerCase().contains(normalizedQuery),
      );
    }
    if (_category != null) {
      predicates.add((book) => book.category == _category);
    }
    final visible = _books
        .where(
          (book) =>
              predicates.isEmpty || predicates.any((matches) => matches(book)),
        )
        .toList();
    visible.sort((a, b) {
      final comparison = a.displayAddedDate.compareTo(b.displayAddedDate);
      return _sort == BookSort.oldest ? comparison : -comparison;
    });
    return List.unmodifiable(visible);
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setCategory(BookCategory? value) {
    _category = value;
    notifyListeners();
  }

  void setSort(BookSort value) {
    _sort = value;
    notifyListeners();
  }

  void startEditing(int id) {
    _draft = _books.firstWhere((book) => book.id == id);
    notifyListeners();
  }

  void updateDraftTitle(String value) {
    _draft?.title = value;
    notifyListeners();
  }

  void saveEditing() {
    final draft = _draft;
    if (draft == null || draft.title.trim().isEmpty) return;
    _books = _books
        .map(
          (book) => book.id == draft.id
              ? draft.copyWith(title: draft.title.trim())
              : book,
        )
        .toList();
    _draft = null;
    notifyListeners();
  }

  void cancelEditing() {
    _draft = null;
    notifyListeners();
  }

  void resetFilters() {}
}
