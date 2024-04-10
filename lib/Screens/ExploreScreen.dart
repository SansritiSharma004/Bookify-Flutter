import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Boxes/Boxes.dart';
import '../models/BooksModel.dart';
import '../models/book.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late List<Book> _books;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final box = Boxes.getData();
    final List<BooksModel> bookModels = box.values.toList().cast<BooksModel>();

    _books = bookModels.map((model) {
      return Book(
        title: model.title.toString(),
        author: model.author.toString(),
        imagePath: model.imagePath.toString(),
        genre: model.genre.toString(),
        bookPath: model.epubFilePath.toString(),
      );
    }).toList();

    setState(() {});
  }

  List<String> _getGenres() {
    return _books.map((book) => book.genre).toSet().toList();
  }

  List<Book> _getBooksByGenre(String genre) {
    return _books.where((book) => book.genre == genre).toList();
  }

  Future<void> deleteBookFromHive(String title) async {
    final box = await Hive.openBox<BooksModel>('books');
    final key = box.keys.firstWhere((key) {
      final book = box.get(key);
      return book != null && book.title == title;
    }, orElse: () => null);

    if (key != null) {
      await box.delete(key);
    }
  }

  void delete(Book book) {
    setState(() {
      _books.remove(book);
    });
    deleteBookFromHive(book.title); // Delete the book from the Hive box
  }





  Widget _buildGenreList() {
    final List<String> genres = _getGenres().where((genre) => genre.isNotEmpty).toList();

    return ListView.builder(
      itemCount: genres.length,
      itemBuilder: (context, index) {
        final String genre = genres[index];
        final List<Book> genreBooks = _getBooksByGenre(genre);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                genre,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 278,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: genreBooks.length,
                itemBuilder: (context, index) {
                  final Book book = genreBooks[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (book.imagePath.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Image.file(
                                File(book.imagePath),
                                width: 130,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          Text(book.title, style: TextStyle(fontSize: 14)),
                          SizedBox(height: 5),
                          Text(book.author, style: TextStyle(fontSize: 12)),
                          InkWell(
                              onTap: (){
                                delete(book);
                              },
                              child: Icon(Icons.delete, color: Colors.red,)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" "),
      ),
      body: FutureBuilder(
        future: _loadBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return _buildGenreList();
          }
        },
      ),
    );
  }
}
