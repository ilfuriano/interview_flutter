# Bookshelf — Flutter Interview Exercise

A debugging exercise for a **30-minute technical interview**.
The application compiles and runs, but contains **3 bugs and 1 missing feature**.

## Getting started

Use Flutter **3.35.4** (Dart **3.9.2**) or a compatible newer stable SDK.
No backend, API key, or additional state management package is required.

```sh
flutter pub get
flutter run -d chrome
```

Android and iOS projects are included. You can also run on an emulator or
device; iOS device builds require your own signing configuration.
Books are held in memory and reset when the app restarts.

## Application behavior

- Search books by title, ignoring case and surrounding whitespace.
- Filter by category. Search and category should apply together.
- Sort by the date a book was added, newest or oldest first.
- Edit a title. Save commits the draft; Cancel discards it.
- Reset search and category filters while keeping the current sort order.

Displayed dates use **MM/DD/YYYY**. The seed data spans two calendar years.

Read [INTERVIEW_BUGS_TO_FIX.md](INTERVIEW_BUGS_TO_FIX.md) for the assignment.

## Project layout

- `lib/controllers/bookshelf_controller.dart`: filtering, sorting, and editing.
- `lib/models/book.dart`: book model, categories, and sort options.
- `lib/screens/bookshelf_screen.dart`: search, controls, and book list.
- `lib/widgets/book_editor.dart`: title-editing form.
- `test/widget_test.dart`: smoke test for rendering and individual filters.

```sh
flutter analyze
flutter test
```

The smoke test should pass on the starting version. It does not cover every
reported issue. Add focused regression tests when fixing defects.

## Interview format

Explain your observations, hypotheses, and verification as you work.
Prioritize the issues in the order you consider most critical.
Suggested timing: 5 minutes to explore, 20 to implement fixes, and 5 to discuss.
A redesign, persistence layer, or new dependency is unnecessary.
