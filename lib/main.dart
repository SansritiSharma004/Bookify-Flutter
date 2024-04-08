
import 'package:bookify/EpubViewer/EpubViewer.dart';
import 'package:bookify/EpubViewer/EpubViewerII.dart';
import 'package:bookify/Screens/MainScreen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'models/BooksModel.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(BooksModelAdapter());

  await Hive.openBox<BooksModel>('books');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.encodeSansTextTheme(),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Color.fromRGBO(191, 207, 255, 1)),
          color: Color.fromRGBO(250, 250, 250, 1),
          elevation: 0
        )
      ),

        home: EpubViewerWidget(),
    );
  }
}

