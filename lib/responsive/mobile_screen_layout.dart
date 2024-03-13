// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_instagram_clone/models/user.dart' as model;
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void NavigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children:homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            icon: Icon(
              Icons.home,
              color: _page == 0 ? blueColor : secondaryColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            icon: Icon(Icons.search,
                color: _page == 1 ? blueColor : secondaryColor),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            icon: Icon(Icons.add_circle,
                color: _page == 2 ? blueColor : secondaryColor),
            label: 'post',
          ),
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            icon: Icon(Icons.favorite,
                color: _page == 3 ? blueColor : secondaryColor),
            label: 'liked',
          ),
          BottomNavigationBarItem(
            backgroundColor: primaryColor,
            icon: Icon(Icons.person,
                color: _page == 4 ? blueColor : secondaryColor),
            label: 'profile',
          ),
        ],
        onTap: NavigationTapped,
      ),
    );
  }
}
  // String username = "";

  // @override
  // void initState() {
  //   super.initState();
  //   getUserName();
  // }

  // void getUserName() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  // }
