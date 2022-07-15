import 'package:core/data/datasources/ssl/ssl.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/data/datasources/db/database_helper.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/data/repository/movie_repository_impl.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/presentation/bloc/detail_movie/detail_movie_bloc.dart';
import 'package:movies/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movies/presentation/bloc/popular_movie/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/recommend_movie/recommended_movies_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movie/top_rated_movies_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_movies_bloc.dart';
import 'package:search/presentation/search.dart';
import 'package:television/data/datasources/db/database_helper_television.dart';
import 'package:television/data/datasources/television_local_data_source.dart';
import 'package:television/data/datasources/television_remote_data_source.dart';
import 'package:television/data/repositories/television_repository_impl.dart';
import 'package:television/domain/repositories/television_repository.dart';
import 'package:television/domain/usecase/television_get_detail.dart';
import 'package:television/domain/usecase/television_get_now_playing.dart';
import 'package:television/domain/usecase/television_get_popular.dart';
import 'package:television/domain/usecase/television_get_recommendation.dart';
import 'package:television/domain/usecase/television_get_top_rated.dart';
import 'package:television/domain/usecase/television_get_watchlist.dart';
import 'package:television/domain/usecase/television_get_watchlist_status.dart';
import 'package:television/domain/usecase/television_remove_watchlist.dart';
import 'package:television/domain/usecase/television_save_watchlist.dart';
import 'package:television/presentation/bloc/television_detail/television_detail_bloc.dart';
import 'package:television/presentation/bloc/television_on_air/television_on_air_bloc.dart';
import 'package:television/presentation/bloc/television_popular/television_popular_bloc.dart';
import 'package:television/presentation/bloc/television_recommend/television_recommend_bloc.dart';
import 'package:television/presentation/bloc/television_top_rated/television_top_rated_bloc.dart';
import 'package:television/presentation/bloc/television_watchlist/television_watchlist_bloc.dart';

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
        getWatchlistMovies: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
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
