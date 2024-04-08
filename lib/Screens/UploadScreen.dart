import 'package:bookify/models/BooksModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';


class UploadScreen extends StatefulWidget {
  UploadScreen({Key? key}) : super(key: key);




  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {


  List<String> genre = [
    'Romance',
    'Thriller',
    'Self Help',
    'Sci Fi',
    'Fiction'
  ];

  String dropdownvalue = 'Romance';
  var fileName;
  var result;


  late bool _loading;


  //controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController bookPathController = TextEditingController();
  final TextEditingController imagePathController = TextEditingController();
  final TextEditingController genreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  //pick image
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(()  {
        this.image = imageTemp;
        imagePathController.text = imageTemp.path;
      });
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text(" "),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // UploadBook text
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Upload Book",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),

                // Upload Cover
                InkWell(
                  onTap: pickImage,
                  child:
                  Container(
                    width: 130,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: const Color.fromRGBO(191, 207, 255, 1),
                    ),
                    child: image != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Icon(Icons.camera_alt_outlined),
                  ),

                ),
                const SizedBox(height: 10,),

                // Text: Cover
                const Text('Cover', style: TextStyle(fontSize: 14),),

                // ElevatedButton : Add Epub File
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _loading = true; // Start showing the linear progress indicator
                    });

                    result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['epub'],
                    );

                    setState(() {
                      _loading = false; // Stop showing the linear progress indicator
                    });

                    if(result == null || result.files.isEmpty) {
                      return; // No file selected, just return
                    } else {
                      setState(() {
                        // Extracting file name from path
                        fileName = result.files.single.name ?? "Unknown";
                      });
                    }
                  },
                  child: const Text(
                    'Add Epub File',
                    style: TextStyle(fontSize: 12, color: Color.fromRGBO(191, 207, 255, 1)),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: const BorderSide(width: 1, color: Color.fromRGBO(128, 159, 255, 1)),
                      ),
                    ),
                  ),
                ),

                //Linear Progress Indicator

                Container(
                    padding: EdgeInsets.all(12.0),
                    child: _loading
                        ? LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Color.fromRGBO(191, 207, 255, 1)),
                    )
                        : SizedBox()
                ),

                //Uploaded File

                Container(
                  padding: EdgeInsets.all(12.0),
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color.fromRGBO(128, 159, 255, 1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: fileName != null
                      ? Row(
                    children: [
                      Icon(Icons.file_copy_outlined, color: Color.fromRGBO(128, 159, 255, 1),),
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            fileName!,
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),

                    ],
                  )
                      : SizedBox(), // If fileName is null, show an empty SizedBox
                ),





                const SizedBox(height: 20),




                // Form
                Column(
                  children: [


                    // enter title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: const Text("Title :"),
                        ),
                        const SizedBox(width: 9),
                        SizedBox(
                          width: 281,
                          child: TextField(
                            controller: titleController,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(191, 207, 255, 1),
                            ),
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Book Title',
                              hintStyle: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(191, 207, 255, 1),
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.all(10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 1),)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 1))
                              ),
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),



                    // enter author name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Author :"),
                        const SizedBox(width: 9),
                        SizedBox(
                          width: 280,
                          child: TextField(
                            controller: authorController,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(191, 207, 255, 1),
                            ),
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Author Name',
                              hintStyle: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(191, 207, 255, 1),
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.all(10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 1),)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 1))
                              ),
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),


                    //Description
                    Padding(
                      padding: const EdgeInsets.only(left: 19.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Description :"),
                          const SizedBox(width: 11),
                          SizedBox(
                            width: 281,
                            child: TextField(
                              controller: descriptionController,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(191, 207, 255, 1),
                              ),
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: 'Book Description',
                                hintStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(191, 207, 255, 1),
                                ),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(10.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 1),)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 1))
                                ),
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),



                //Text: Genre
                const Text("Genre" , style: TextStyle(fontSize: 14),),
                const SizedBox(height: 20,),




                //DropDown
                SizedBox(
                  width: 150,
                  height: 27,
                  child: DropdownButtonFormField<String>(
                    //menuMaxHeight: 200,
                      itemHeight: null,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          //<-- SEE HERE
                            borderRadius: BorderRadius.circular(20.5),
                            borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 10))


                        ),
                        focusedBorder: OutlineInputBorder(
                          //<-- SEE HERE
                            borderRadius: BorderRadius.circular(20.5),
                            borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 10))
                        ),
                        border: InputBorder.none,
                        filled: true,
                        contentPadding: const EdgeInsets.all(8),
                        fillColor: Colors.white,
                      ),
                      dropdownColor: Colors.white,
                      value: dropdownvalue,
                      // isExpanded: true,
                      // elevation: 20,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          genreController.text = newValue;

                        });
                      },
                      items: genre.map((String genres) {
                        return DropdownMenuItem(
                          value: genres,
                          child: Text(
                            genres,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Orbitron',
                                color: Color.fromRGBO(191, 207, 255, 10)),
                          ),
                        );
                      }).toList(),
                      icon: const Icon(Icons.keyboard_arrow_down_sharp, size: 14,)
                  ),
                ),
                const SizedBox(height: 20,),



                //IconButton
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 0, 179, 1),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          width: 2,
                          color: Color.fromRGBO(191, 207, 255, 10)
                      )
                  ),
                  child: IconButton(
                      onPressed: (){
                        final data = BooksModel(
                            title: titleController.text,
                            author: authorController.text,
                            description: descriptionController.text,
                            epubFilePath: bookPathController.text,
                            imagePath: imagePathController.text,
                            genre: genreController.text
                        );


                        final box = Hive.box<BooksModel>('books');
                        box.add(data);

                        titleController.clear();
                        authorController.clear();
                        descriptionController.clear();
                        bookPathController.clear();
                        imagePathController.clear();
                        genreController.clear();

                        Navigator.pop(context, data);

                      },
                      icon: const ImageIcon(AssetImage('assets/cloud-computing.png'), size: 40, color: Colors.white,)
                  ),
                )
              ],
            ),
          ),
        )

    );
  }
}
