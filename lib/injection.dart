import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:search/search.dart';
import 'package:television/television.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => DetailsMoviesBloc(
        locator(),
      ));
  locator.registerFactory(
    () => NowPlayingsMoviesBloc(locator()),
  );
  locator.registerFactory(
    () => PopularsMoviesBloc(locator()),
  );
  locator.registerFactory(() => RecommendMoviesBloc(
        locator(),
      ));
  locator.registerFactory(() => SearchMoviesBloc(
        searchMovies: locator(),
      ));
  locator.registerFactory(
    () => TopRatedsMoviesBloc(locator()),
  );

  locator.registerFactory(() => DetailsTvsBloc(
        getTvDetail: locator(),
      ));
  locator.registerFactory(
    () => OnAirsTvsBloc(locator()),
  );
  locator.registerFactory(
    () => PopularsTvsBloc(locator()),
  );
  locator.registerFactory(() => RecommendTvsBloc(
        getTvRecommendations: locator(),
      ));
  locator.registerFactory(() => SearchTvsBloc(
        searchTv: locator(),
      ));
  locator.registerFactory(
    () => TopRatedsTvsBloc(locator()),
  );
  locator.registerFactory(() => WatchlistMoviesBloc(
        SaveWatchlist(locator()),
        RemoveWatchlist(locator()),
        GetWatchlistMovies(locator()),
        GetWatchListStatus(locator()),
      ));
  locator.registerFactory(() => WatchlistTvsBloc(
        getWatchlistTv: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));

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
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TelevisionRepositoryImpl(
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
  locator.registerLazySingleton<DatabaseHelperTelevision>(
      () => DatabaseHelperTelevision());

  // external
  locator.registerLazySingleton(() => SslPinnings.client);
}
