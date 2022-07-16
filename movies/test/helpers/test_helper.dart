import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelperMovie,
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetMovieRecommendations,
  GetMovieDetail,
  GetWatchlistMovies,
  GetWatchListStatus,
  RemoveWatchlist,
  SaveWatchlist,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

class FakeNowPlayingMovieE extends Fake implements NowPlayingsMoviesEvent {}

class FakeNowPlayingMovieS extends Fake implements NowPlayingsMoviesState {}

class FakeNowPlayingMovieBloc
    extends MockBloc<NowPlayingsMoviesEvent, NowPlayingsMoviesState>
    implements NowPlayingsMoviesBloc {}

class FakePopularMovieE extends Fake implements PopularsMoviesEvent {}

class FakePopularMovieS extends Fake implements PopularsMoviesState {}

class FakePopularMovieBloc
    extends MockBloc<PopularsMoviesEvent, PopularsMoviesState>
    implements PopularsMoviesBloc {}

//Top rated movie
class FakeTopRatedMovieE extends Fake implements TopRatedsMoviesEvent {}

class FakeTopRatedMovieS extends Fake implements TopRatedsMoviesState {}

class FakeTopRatedMovieBloc
    extends MockBloc<TopRatedsMoviesEvent, TopRatedsMoviesState>
    implements TopRatedsMoviesBloc {}

//Detail movie
class FakeDetailMovieE extends Fake implements DetailsMoviesEvent {}

class FakeDetailMovieS extends Fake implements DetailsMoviesState {}

class FakeDetailMovieBloc
    extends MockBloc<DetailsMoviesEvent, DetailsMoviesState>
    implements DetailsMoviesBloc {}

//Recommendation movie
class FakeRecommendationMovieE extends Fake implements RecommendMoviesEvent {}

class FakeRecommendationMovieS extends Fake implements RecommendMoviesState {}

class FakeRecommendationMovieBloc
    extends MockBloc<RecommendMoviesEvent, RecommendMoviesState>
    implements RecommendMoviesBloc {}

//Wachlist movie
class FakeWatchlistMovieE extends Fake implements WatchlistMoviesEvent {}

class FakeWatchlistMovieS extends Fake implements WatchlistMoviesState {}

class FakeWatchlistMovieBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}
