import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:movies/movies.dart';
import 'package:search/search.dart';
import 'package:television/television.dart';

@GenerateMocks([
  SearchMovies,
  SearchTv,
  MovieRepository,
  TvRepository,
])
void main() {}

class FakeMovieSearchE extends Fake implements SearchMoviesEvent {}

class FakeMovieSearchS extends Fake implements SearchMoviesState {}

class FakeMovieSearchBloc extends MockBloc<SearchMoviesEvent, SearchMoviesState>
    implements SearchMoviesBloc {}

class FakeTvSearchE extends Fake implements SearchTvsEvent {}

class FakeTvSearchS extends Fake implements SearchTvsState {}

class FaketTvSearchBloc extends MockBloc<SearchTvsEvent, SearchTvsState>
    implements SearchTvsBloc {}
