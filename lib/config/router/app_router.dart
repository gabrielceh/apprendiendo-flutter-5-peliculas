import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes:[
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.routeName,
      builder: (context, state){
        // hay que tenr cuidado de que el valor sea un int y que sea menor al tamaño del array que esta en el screen
        final pageIndex = state.pathParameters['page'] ?? '0';
        return HomeScreen(pageIndex: int.parse(pageIndex),);
      },
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

    GoRoute(path: '/', redirect: (_, _) => '/home/0'), // redireccionamos desde / a /home/0 (HomeView)

  ]
);