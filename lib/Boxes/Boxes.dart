import 'package:bookify/models/BooksModel.dart';
import 'package:hive/hive.dart';



class Boxes{
  static Box<BooksModel> getData() => Hive.box<BooksModel>('books');
}