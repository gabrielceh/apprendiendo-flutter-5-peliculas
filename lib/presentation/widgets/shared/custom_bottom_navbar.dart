import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavbar extends StatelessWidget {
  
  final int currentIndex;
  const CustomBottomNavbar({super.key, required this.currentIndex});

  void onTabTapped( BuildContext context, index) {
    context.go('/home/$index');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentIndex,
      onTap: (value) => onTabTapped(context, value),    
      items:const[
        // necesita mas de un item
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categorias',
          activeIcon: Icon(Icons.label)
        ),
      
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
          activeIcon: Icon(Icons.favorite)
        ),
        
      ]
    );
  }
}