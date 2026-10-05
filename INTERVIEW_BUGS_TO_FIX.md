# Exercise — Bookshelf App (30 minutes)

The application contains **3 bugs and 1 missing feature**.
Fix them in the order you consider most critical and explain your reasoning.

## Bug #1 — Combining search and category shows unrelated books

**File:** `lib/controllers/bookshelf_controller.dart` → `visibleBooks`

Search for “Flutter”, then select Fiction. The list includes books that do not
satisfy both criteria. Expected: no results, because the Flutter book belongs
to Technology. Searching for “garden” with Fiction should return one book.
Each filter should continue to work independently too.

## Bug #2 — Cancel does not discard an edited title

**File:** `lib/controllers/bookshelf_controller.dart` → editing methods

With no filters, edit “Practical Flutter”, type a different title, then press
Cancel. The book keeps the new title even though Save was never pressed.
Keep changes isolated while editing; only Save should update the library.
Cancel must leave the original title intact.

## Bug #3 — Sorting is incorrect across calendar years

**File:** `lib/controllers/bookshelf_controller.dart` → `visibleBooks`

With Newest first selected, a book added in December 2024 appears ahead of
books added in 2025. Fix chronological sorting in both directions.
Keep the display format MM/DD/YYYY and preserve the stored book data.

## TODO #1 — Reset filters

**Files:** `lib/controllers/bookshelf_controller.dart` and `lib/screens/bookshelf_screen.dart`

The Reset filters button currently does nothing. Implement it so it clears
the search field and query, selects All categories, and restores all books.
Keep the current sort option and any in-progress title edit unchanged.

## Guidelines

- Explain the cause of each issue and how your fix addresses it.
- Add targeted tests where useful.
- Keep the existing features and seed data.
- Do not add dependencies, networking, or persistence.
