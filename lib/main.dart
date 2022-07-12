import 'package:muse/common/constants.dart';
import 'package:muse/common/utils.dart';
import 'package:muse/presentation/pages/about_page.dart';
import 'package:muse/presentation/pages/movie/movie_detail_page.dart';
import 'package:muse/presentation/pages/movie/home_movie_page.dart';
import 'package:muse/presentation/pages/movie/popular_movies_page.dart';
import 'package:muse/presentation/pages/movie/search_page.dart';
import 'package:muse/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:muse/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:muse/presentation/pages/tv/home_tv_page.dart';
import 'package:muse/presentation/pages/tv/tv_detail_page.dart';
import 'package:muse/presentation/pages/tv/tv_popular_page.dart';
import 'package:muse/presentation/pages/tv/tv_search_page.dart';
import 'package:muse/presentation/pages/tv/tv_top_rated.dart';
import 'package:muse/presentation/pages/tv/tv_watchlist_page.dart';
import 'package:muse/presentation/provider/movie_detail_notifier.dart';
import 'package:muse/presentation/provider/movie_list_notifier.dart';
import 'package:muse/presentation/provider/movie_search_notifier.dart';
import 'package:muse/presentation/provider/popular_movies_notifier.dart';
import 'package:muse/presentation/provider/top_rated_movies_notifier.dart';
import 'package:muse/presentation/provider/tv_detail_notifier.dart';
import 'package:muse/presentation/provider/tv_list_notifier.dart';
import 'package:muse/presentation/provider/tv_popular_notifier.dart';
import 'package:muse/presentation/provider/tv_search_notifier.dart';
import 'package:muse/presentation/provider/tv_top_rated_notifier.dart';
import 'package:muse/presentation/provider/tv_watchlist_notifier.dart';
import 'package:muse/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:muse/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
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
        home: HomeTelevisionPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeTelevisionPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTelevisionPage());
            case PopularTelevisionPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => PopularTelevisionPage());
            case TopRatedTelevisionPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => TopRatedTelevisionPage());
            case TelevisionDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TelevisionDetailPage(id: id),
                settings: settings,
              );
            case SearchTelevisionPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTelevisionPage());
            case TvWatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvWatchlistPage());
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
