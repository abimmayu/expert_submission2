import 'package:about/about_page.dart';
import 'package:core/data/datasources/ssl/ssl.dart';
import 'package:core/presentations/page/spalsh_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/detail_movie/detail_movie_bloc.dart';
import 'package:movies/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movies/presentation/bloc/popular_movie/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/recommend_movie/recommended_movies_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movie/top_rated_movies_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_movies_bloc.dart';
import 'package:movies/presentation/pages/home_movie_page.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';
import 'package:provider/provider.dart';
import 'package:muse/injection.dart' as di;
import 'package:search/presentation/search.dart';
import 'package:television/presentation/bloc/television_detail/television_detail_bloc.dart';
import 'package:television/presentation/bloc/television_on_air/television_on_air_bloc.dart';
import 'package:television/presentation/bloc/television_popular/television_popular_bloc.dart';
import 'package:television/presentation/bloc/television_recommend/television_recommend_bloc.dart';
import 'package:television/presentation/bloc/television_top_rated/television_top_rated_bloc.dart';
import 'package:television/presentation/bloc/television_watchlist/television_watchlist_bloc.dart';
import 'package:television/presentation/pages/television_detail_page.dart';
import 'package:television/presentation/pages/television_home_page.dart';
import 'package:television/presentation/pages/television_popular_page.dart';
import 'package:television/presentation/pages/television_top_rated_page.dart';
import 'package:television/presentation/pages/television_watchlist_page.dart';
import 'package:core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SslPinnings.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<DetailsMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularsMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedsMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingsMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailsTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularsTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedsTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnAirsTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: SplashScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case '/tv':
              return MaterialPageRoute(builder: (_) => HomeTelevisionPage());
            case PopularTelevisionPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => PopularTelevisionPage());
            case TopRatedTelevisionPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => TopRatedTelevisionPage());
            case TelevisionDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TelevisionDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchTelevisionPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchTelevisionPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTelevisionPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => WatchlistTelevisionPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
