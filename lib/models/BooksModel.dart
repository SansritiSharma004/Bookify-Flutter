import 'package:hive/hive.dart';
part 'BooksModel.g.dart';

@HiveType(typeId: 0)
class BooksModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String author;


  @HiveField(2)
  String description;

  @HiveField(3)
  String epubFilePath;

  @HiveField(4)
  String imagePath;

  @HiveField(5)
  String genre;



  BooksModel({
    required this.title,
    required this.author,
    required this.description,
    required this.epubFilePath,
    required this.imagePath,
    required this.genre,

  });
}
