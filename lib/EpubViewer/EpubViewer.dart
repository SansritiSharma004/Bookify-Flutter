import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:epub_view/epub_view.dart';
class EpubViewer extends StatefulWidget {
  const EpubViewer({Key? key}) : super(key: key);

  @override
  State<EpubViewer> createState() => _EpubViewerState();
}

class _EpubViewerState extends State<EpubViewer> {
  late EpubController _epubController;


  @override
  void initState() {
    super.initState();
    _epubController = EpubController(
      // Load document
      document: EpubDocument.openAsset('assets/13ReasonWhy.epub'),
      // Set start point
      epubCfi: 'epubcfi(/6/6[chapter-2]!/4/2/1612)',
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      // Show actual chapter name
      title: EpubViewActualChapter(
          controller: _epubController,
          builder: (chapterValue) => Text(
            'Chapter: ' + (chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? ''),
            textAlign: TextAlign.start,
          )
      ),
    ),
    // Show table of contents
    drawer: Drawer(
      child: EpubViewTableOfContents(
        controller: _epubController,
      ),
    ),
    // Show epub document
    body: EpubView(
      controller: _epubController,
    ),
  );
}


