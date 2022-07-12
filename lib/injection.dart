import 'package:muse/data/datasources/db/database_helper.dart';
import 'package:muse/data/datasources/movie_local_data_source.dart';
import 'package:muse/data/datasources/movie_remote_data_source.dart';
import 'package:muse/data/repositories/movie_repository_impl.dart';
import 'package:muse/data/repositories/tv_repository.dart';
import 'package:muse/domain/repositories/movie_repository.dart';
import 'package:muse/domain/usecases/get_movie_detail.dart';
import 'package:muse/domain/usecases/get_movie_recommendations.dart';
import 'package:muse/domain/usecases/get_now_playing_movies.dart';
import 'package:muse/domain/usecases/get_popular_movies.dart';
import 'package:muse/domain/usecases/get_top_rated_movies.dart';
import 'package:muse/domain/usecases/get_tv_now_playing.dart';
import 'package:muse/domain/usecases/get_watchlist_movies.dart';
import 'package:muse/domain/usecases/get_watchlist_status.dart';
import 'package:muse/domain/usecases/remove_watchlist.dart';
import 'package:muse/domain/usecases/save_tv_watchlist.dart';
import 'package:muse/domain/usecases/save_watchlist.dart';
import 'package:muse/domain/usecases/search_movies.dart';
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
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'data/datasources/tv_local_datasource.dart';
import 'data/datasources/tv_remote_datasource.dart';
import 'domain/repositories/tv_repository.dart';
import 'domain/usecases/get_recomendation_tv.dart';
import 'domain/usecases/get_tv_detail.dart';
import 'domain/usecases/get_tv_popular.dart';
import 'domain/usecases/get_tv_top_rate.dart';
import 'domain/usecases/get_tv_watchlist.dart';
import 'domain/usecases/get_tv_watchlist_status.dart';
import 'domain/usecases/remove_tv_watchlist.dart';
import 'domain/usecases/search_tv.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvListNotifier(
      getNowPlayingTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatusTv: locator(),
      saveWatchlistTv: locator(),
      removeWatchlistTv: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvNotifier(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TelevisionRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TelevisionLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelpertv: locator()));

  // helper
  locator
      .registerLazySingleton<DatabaseHelperMovie>(() => DatabaseHelperMovie());
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());

  // external
  locator.registerLazySingleton(() => http.Client());
}
