import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes:[

    /**Rutas padre-hijo */
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.routeName,
    //   builder: (context, state) => HomeScreen(childView: HomeView()),
    //   // rutas hijas o deep links
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:movieId',
    //       name: MovieScreen.routeName,
    //       builder: (context, state){
    //         final movieId = state.pathParameters['movieId'] ?? 'no-id';
    //         return MovieScreen(movieId: movieId);
    //       }
    //       ,
    //     )

    //   ]
    // ),

    ShellRoute(
      builder: (context, state, child){
        return HomeScreen(childView: child,);
      },

      routes: [
        GoRoute(
          path: '/',
          builder: (context, state){
            return HomeView();
          },
          routes: [
             GoRoute(
              path: 'movie/:movieId',
              name: MovieScreen.routeName,
              builder: (context, state){
                final movieId = state.pathParameters['movieId'] ?? 'no-id';
                return MovieScreen(movieId: movieId);
              },
            )
          ]
        ),
        
        GoRoute(
          path: '/favorites',
          builder: (context, state){
            return FavoritesView();
          }
        ),
      ]
    )

  ]
);