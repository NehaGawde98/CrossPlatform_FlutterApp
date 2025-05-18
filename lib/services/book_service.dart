import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class BookService {
  Future<List<ParseObject>> getBooks() async {
    final query = QueryBuilder<ParseObject>(ParseObject('Books'));
    final response = await query.query();

    if (response.success && response.results != null) {
      return response.results!.cast<ParseObject>();
    } else {
      return <ParseObject>[];
    }
  }

  Future<void> addBook(String title, String author, String genre, bool availability) async {
    final book = ParseObject('Books')
      ..set('title', title)
      ..set('author', author)
      ..set('genre', genre)
      ..set('availability', availability);

    final response = await book.save();
    if (!response.success) {
      throw Exception(response.error?.message ?? 'Failed to add book');
    }
  }

  Future<void> updateBook(String id, String title, String author, String genre, bool availability) async {
    final book = ParseObject('Books')
      ..objectId = id
      ..set('title', title)
      ..set('author', author)
      ..set('genre', genre)
      ..set('availability', availability);

    final response = await book.save();
    if (!response.success) {
      throw Exception(response.error?.message ?? 'Failed to update book');
    }
  }

  Future<void> deleteBook(String id) async {
    final book = ParseObject('Books')..objectId = id;
    final response = await book.delete();
    if (!response.success) {
      throw Exception(response.error?.message ?? 'Failed to delete book');
    }
  }
}