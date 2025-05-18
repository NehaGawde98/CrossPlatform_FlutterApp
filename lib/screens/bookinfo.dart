import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../services/book_service.dart';

class BookFormScreen extends StatefulWidget {
  final ParseObject? book;

  BookFormScreen({this.book});

  @override
  _BookFormScreenState createState() => _BookFormScreenState();
}

class _BookFormScreenState extends State<BookFormScreen> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _genreController = TextEditingController();
  bool _availability = true;
  final _bookService = BookService();

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _titleController.text = widget.book!.get<String>('title') ?? '';
      _authorController.text = widget.book!.get<String>('author') ?? '';
      _genreController.text = widget.book!.get<String>('genre') ?? '';
      _availability = widget.book!.get<bool>('availability') ?? true;
    }
  }

  void _save() async {
    if (_titleController.text.trim().isEmpty || _authorController.text.trim().isEmpty) return;

    final title = _titleController.text.trim();
    final author = _authorController.text.trim();
    final genre = _genreController.text.trim();
    final availability = _availability;

    try {
      if (widget.book == null) {
        await _bookService.addBook(title, author, genre, availability);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Book added successfully')),
        );
      } else {
        await _bookService.updateBook(widget.book!.objectId!, title, author, genre, availability);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Book updated successfully')),
        );
      }
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }


   @override
    Widget build(BuildContext context) {
      final isEditing = widget.book != null;

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(isEditing ? 'Edit Book' : 'Add Book',
                 style: TextStyle(
                       color: Theme.of(context).colorScheme.primary,
                       fontWeight: FontWeight.bold,
                     ),),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.primary, // back arrow color
            ),
        ),

        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/appbg.png',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _authorController,
                        decoration: InputDecoration(
                          labelText: 'Author',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _genreController,
                        decoration: InputDecoration(
                          labelText: 'Genre',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Text(
                            'Available',
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Switch(
                            value: _availability,
                            activeColor: Colors.deepPurple,
                            onChanged: (value) {
                              setState(() {
                                _availability = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      Center(
                        child: ElevatedButton(
                          onPressed: _save,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            widget.book != null ? 'Update' : 'Add',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        );
      }
}