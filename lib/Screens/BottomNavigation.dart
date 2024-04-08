import 'dart:io';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {

  final int pageIndex;
  final Function(int) onTap;
  const BottomNavigation({super.key, required this.pageIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: 20, left: 80, right: 80
      ),
      child: BottomAppBar(
        elevation: 0.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.black26, // Choose your border color
                width: 2, // Choose your border width
              ),
              color: Colors.white,
            ),

            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  navItem(
                      AssetImage('assets/compass.png'),
                      'Explore',
                      pageIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  Spacer(),
                  navItem(
                    AssetImage('assets/book.png'),
                    'My Books',
                    pageIndex == 1,
                    onTap: () => onTap(1),
                  ),

                ],
              ),
            ),
          ),

        ),
      ),
    );
  }


  Widget navItem(ImageProvider<Object> icon, String text, bool selected, {Function()? onTap}){
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            ImageIcon(
              icon ,
              color: selected ? Color.fromRGBO(128, 159, 255, 1) : Colors.black ,
              size: 30,
            ),
            SizedBox(height: 1,),
            Text(
              text,
              style: TextStyle(
                fontSize: 11,
                color: selected ? Color.fromRGBO(128, 159, 255, 1) : Colors.black ,),
            )
          ],
        ),


      ),
    );
  }
}
