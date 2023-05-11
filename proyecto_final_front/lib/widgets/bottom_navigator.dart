import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget{
  final Function targetView;
  const BottomNavigator({Key? key, required this.targetView}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int index = 0;
  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int i){
        setState(() {
          index = i;
          widget.targetView(i);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'HomePage'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile'
        ),
      ],
    );
  }
}