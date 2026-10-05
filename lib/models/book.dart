class Book {
  Book({
    required this.id,
    required this.title,
    required this.category,
    required this.addedAt,
  });

  final int id;
  String title;
  final BookCategory category;
  final DateTime addedAt;

  String get displayAddedDate =>
      '${addedAt.month.toString().padLeft(2, '0')}/${addedAt.day.toString().padLeft(2, '0')}/${addedAt.year}';

  Book copyWith({String? title}) => Book(
    id: id,
    title: title ?? this.title,
    category: category,
    addedAt: addedAt,
  );
}

enum BookCategory {
  fiction('Fiction'),
  technology('Technology'),
  travel('Travel');

  const BookCategory(this.label);
  final String label;
}

enum BookSort {
  newest('Newest first'),
  oldest('Oldest first');

  const BookSort(this.label);
  final String label;
}
