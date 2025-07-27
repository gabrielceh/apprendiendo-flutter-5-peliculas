
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = 'home-screen';

  final Widget childView; // vista que va a renderizarse
  

  const HomeScreen({
     super.key,
     required this.childView,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: CustomBottomNavbar(),

    );
  }
}

// nuestra clase ahoa exttiende de ConsumerStatefulWidget
