import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:television/television.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TelevisionRemoteDataSource,
  TelevisionLocalDataSource,
  DatabaseHelperTelevision,
  GetNowPlayingTv,
  GetPopularTv,
  GetTopRatedTv,
  GetTvRecommendations,
  GetTvDetail,
  GetWatchlistTv,
  GetWatchListStatusTv,
  RemoveWatchlistTv,
  SaveWatchlistTv,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

class FakeNowPlayingTvE extends Fake implements OnAirsTvsEvent {}

class FakeNowPlayingTvS extends Fake implements OnAirsTvsState {}

class FakeNowPlayingTvBloc extends MockBloc<OnAirsTvsEvent, OnAirsTvsState>
    implements OnAirsTvsBloc {}

//Popular Tv
class FakePopularTvE extends Fake implements PopularsTvsEvent {}

class FakePopularTvS extends Fake implements PopularsTvsState {}

class FakePopularTvBloc extends MockBloc<PopularsTvsEvent, PopularsTvsState>
    implements PopularsTvsBloc {}

//Top rated Tv
class FakeTopRatedTvE extends Fake implements TopRatedsTvsEvent {}

class FakeTopRatedTvS extends Fake implements TopRatedsTvsState {}

class FakeTopRatedTvBloc extends MockBloc<TopRatedsTvsEvent, TopRatedsTvsState>
    implements TopRatedsTvsBloc {}

//Detail Tv
class FakeDetailTvE extends Fake implements DetailsTvsEvent {}

class FakeDetailTvS extends Fake implements DetailsTvsState {}

class FakeDetailTvBloc extends MockBloc<DetailsTvsEvent, DetailsTvsState>
    implements DetailsTvsBloc {}

//Recommendation Tv
class FakeRecommendationTvE extends Fake implements DetailsTvsEvent {}

class FakeRecommendationTvS extends Fake implements DetailsTvsState {}

class FakeRecommendationTvBloc
    extends MockBloc<RecommendTvsEvent, RecommendTvsState>
    implements RecommendTvsBloc {}

//Watchlist Tv
class FakeWatchlistTvE extends Fake implements WatchlistTvsEvent {}

class FakeWatchlistTvS extends Fake implements WatchlistTvsState {}

class FakeWatchlistTvBloc extends MockBloc<WatchlistTvsEvent, WatchlistTvsState>
    implements WatchlistTvsBloc {}
