import 'dart:io';
import 'package:bookify/Services/GlobalVars.dart';
import 'package:http/http.dart' as http;

class UploadService{
  Future<int> uploadbook(String _coverImagePath, String _epubFilePath, String _bookName, String _authorName, String _description, String _genre, int _userid) async{

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse("http://" + localhost + "/books/upload"));

    // Add EPUB file
    var epubFile = await http.MultipartFile.fromPath('epubFile', _epubFilePath);
    request.files.add(epubFile);

    // Add cover image
    var coverImageFile = await http.MultipartFile.fromPath('imageFile', _coverImagePath);
    request.files.add(coverImageFile);

    // Add other fields as text fields
    request.fields['bookName'] = _bookName;
    request.fields['authorName'] = _authorName;
    request.fields['description'] = _description;
    request.fields['category'] = _genre;
    request.fields['user_id'] = _userid.toString();


    // Send the request
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {
      print("Book Uploaded");
      // Successfully uploaded
      return 200; // You can return any meaningful code here
    } else {
      print("Failed");
      // Failed to upload
      print('Failed to upload book: ${response.reasonPhrase}');
      return response.statusCode;
    }
  }
}