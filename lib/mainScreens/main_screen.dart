import 'package:flutter/material.dart';
import 'package:go_dutch/tabPages/home_tab.dart';
import 'package:go_dutch/tabPages/profile_tab.dart';
import 'package:go_dutch/tabPages/ratings_tab.dart';


class MainScreen extends StatefulWidget {


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{

  TabController? tabController;
  int selectedIndex=0;

  onItemClicked(int index){
    setState(() {
      selectedIndex = index;
      tabController!.index= selectedIndex;
    });
  }


  @override
  void initState(){
    super.initState();

    tabController  = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
      physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [ //const
          Map(),
          ProfileTab(),
          RatingsTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Ratings",
          ),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,


      ),
    );
  }
}
