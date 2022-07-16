import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:television/television.dart';

void main() {
  const tvDetailModelTest = TvDetailResponse(
    backdropPath: 'backdropPath',
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: "https://google.com",
    id: 1,
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    status: 'Status',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    tagline: 'Tagline',
    name: 'name',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
  );

  final tvDetailTest = tvDetailModelTest.toEntity();
  final tvDetailJsonTest = tvDetailModelTest.toJson();

  group('TV series detail model test', () {
    test('Should return a subclass og tv detail model entity', () {
      final result = tvDetailModelTest.toEntity();
      expect(result, tvDetailTest);
    });
  });

  test('Should become a json data of tv detail model', () {
    final result = tvDetailModelTest.toJson();
    expect(result, tvDetailJsonTest);
  });
}
