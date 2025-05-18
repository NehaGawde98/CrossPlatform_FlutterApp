import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../services/book_service.dart';
import '../services/auth_service.dart';
import 'login.dart';
import 'bookinfo.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final _bookService = BookService();
  final _authService = AuthService();
  List<ParseObject> _books = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  void _loadBooks() async {
    final books = await _bookService.getBooks();
    setState(() {
      _books = books;
      _loading = false;
    });
  }

  void _logout() async {
    await _authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  void _deleteBook(String id) async {
    try {
      await _bookService.deleteBook(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book deleted successfully')),
      );
      _loadBooks();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Delete failed: ${e.toString()}')),
      );
    }
  }

  void _navigateToAddEdit({ParseObject? book}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BookFormScreen(book: book)),
    );
    _loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/appbg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Foreground UI
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Custom AppBar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Books',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.primary),
                        onPressed: _logout,
                      ),
                    ],
                  ),
                ),
                // Book List
                Expanded(
                  child: _loading
                      ? Center(child: CircularProgressIndicator(color: Colors.white))
                      : ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: _books.length,
                          itemBuilder: (context, index) {
                            final book = _books[index];
                            final String title = book.get<String>('title') ?? '';
                            final String author = book.get<String>('author') ?? '';
                            final bool availability = book.get<bool>('availability') ?? false;

                            return Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              color: Colors.white.withOpacity(0.85),
                              elevation: 6,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                title: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      author,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Status: ${availability ? "Available" : "Unavailable"}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: availability ? Colors.green[700] : Colors.red[700],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.blueAccent),
                                      onPressed: () => _navigateToAddEdit(book: book),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.redAccent),
                                      onPressed: () => _deleteBook(book.objectId!),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () => _navigateToAddEdit(),
        child: Icon(Icons.add),
      ),
    );
  }
}
