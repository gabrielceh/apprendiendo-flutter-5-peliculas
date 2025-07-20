import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes:[
    GoRoute(
      path: '/',
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
      // rutas hijas o deep links
      routes: [
        GoRoute(
          path: 'movie/:movieId',
          name: MovieScreen.routeName,
          builder: (context, state){
            final movieId = state.pathParameters['movieId'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          }
          ,
        )

      ]
    ),

  ]
);