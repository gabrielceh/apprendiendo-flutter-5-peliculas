import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavbar extends StatelessWidget {

  static int getCurrentIndex(BuildContext context){
    final String location = GoRouterState.of(context).uri.toString();
    switch(location){
      case '/':
       return 0;
      case '/categories':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0;
    }
    
  }
  

  const CustomBottomNavbar({super.key});

  void _onItemTapped (BuildContext context, int index) {
    switch(index){
      case 0:
        // home
        context.go('/');
        break;
      case 1:
        // categorias
        break;
      case 2:
        // favoritos
        context.push('/favorites');
        break;
      default:
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: getCurrentIndex(context),
        // value es el indice del item que se ha pulsado
      onTap: (value) => _onItemTapped(context, value),    
      items:const[
        // necesita mas de un item
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home_max),
          icon: Icon(Icons.home_max_outlined),
          label: 'Home',

        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.label),
          icon: Icon(Icons.label_outline),
          label: 'Categorias',
        ),
      
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.favorite),
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
        ),
        
      ]
    );
  }
}