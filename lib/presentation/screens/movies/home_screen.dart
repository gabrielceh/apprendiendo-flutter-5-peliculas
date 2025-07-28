import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/views/views.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = 'home-screen';
  final int pageIndex;
  

  const HomeScreen({
    super.key,
    required this.pageIndex,
  });

  final viewRoutes = const <Widget>[
    HomeView(),
    Placeholder(), // categorias
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: pageIndex,
          children: viewRoutes,
        ),
      ),

      bottomNavigationBar: CustomBottomNavbar(currentIndex: pageIndex),
    );
  }
}

