import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';


class EpubViewerWidget extends StatefulWidget {
  @override
  _EpubViewerWidgetState createState() => _EpubViewerWidgetState();
}

class _EpubViewerWidgetState extends State<EpubViewerWidget> {
  bool _loading = false;
  String _filePath = "";




  void _openEpub() async{
    VocsyEpub.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "iosBook",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      nightMode: true,
    );

    /**
     * @bookPath
     * @lastLocation (optional and only android)
     */
    await VocsyEpub.openAsset('assets/13ReasonWhy.epub',
      lastLocation: EpubLocator.fromJson({
        "bookId": "2239",
        "href": "/OEBPS/ch06.xhtml",
        "created": 1539934158390,
        "locations": {
          "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
        }
      }), // first page will open up if the value is null
    );

// Get locator which you can save in your database

    VocsyEpub.locatorStream.listen((locator) {
      print('LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
      // convert locator from string to json and save to your database to be retrieved later
    });
    VocsyEpub.open(_filePath);
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: _loading
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text('Downloading.... E-pub'),
        ],
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {

                _openEpub();

            },
            child: Text('Open E-pub'),
          ),
        ],
      ),
    );
  }
}