import 'package:bookify/Screens/ExploreScreen.dart';
import 'package:bookify/Screens/UploadScreen.dart';
import 'package:flutter/material.dart';
import 'BottomNavigation.dart';
import 'NavModel.dart';
import 'DownloadsScreen.dart';


class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final exploreNavKey = GlobalKey<NavigatorState>();
  final booksNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<NavModel> items = [];

  void initState(){
    super.initState();
    items = [
      NavModel(
          page: const ExploreScreen(),
          navKey: exploreNavKey
      ),
      NavModel(
          page: const DownloadsScreen(),
          navKey: booksNavKey
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if(items[selectedTab].navKey.currentState?.canPop() ?? false){
            items[selectedTab].navKey.currentState?.pop();
            return Future.value(false);
          }
          else{
            return Future.value(true);
          }
        },
      child: Scaffold(
        body: IndexedStack(
          index: selectedTab,
          children: items.map((page) => Navigator(
            key: page.navKey,
            onGenerateInitialRoutes: (navigator, initialRoute){
              return[
                MaterialPageRoute(builder: (context) => page.page)
              ];
            },
          )).toList(),

        ),

        //FloatingActionButton
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Stack(
          children: [Positioned(
            bottom: kBottomNavigationBarHeight / 2 - 10, // Adjust this value according to your layout
            left: MediaQuery.of(context).size.width / 2 - 35, // Adjust this value according to your layout
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: 74,
              height: 74,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UploadScreen() ));
                },
                backgroundColor: const Color.fromRGBO(0, 0, 179, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(width: 2, color: Color.fromRGBO(191, 207, 255, 10)),
                ),
                child: const ImageIcon(AssetImage('assets/cloud-computing.png'), size: 40, color: Colors.white,),
              ),
            ),
          ),]
        ),




        bottomNavigationBar: BottomNavigation(
          pageIndex: selectedTab,
          onTap: (index) {
            if(index == selectedTab){
              items[index]
                  .navKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            }
            else{
              setState(() {
                selectedTab = index;
              });
            }
          },
        ),
      ) ,
    );
  }
}
