import 'package:flutter/material.dart';
import 'cancelled_screen.dart';
import 'comletedtask_screen.dart';
import 'inprogress_screen.dart';
import 'newtask_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({Key? key}) : super(key: key);

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _selectedScreen = [
    NewTaskScreen(),
    InProgress_Screen(),
    Completed_screen(),
    cancell_screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.replay_circle_filled_outlined), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Cancelled'),
        ],
      ),
    );
  }
}
