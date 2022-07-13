import 'package:flutter_test/flutter_test.dart';
import 'package:muse/data/models/tv_model.dart';
import 'package:muse/domain/entities/tv.dart';

void main() {
  final tModel = TvModel(
    posterPath: 'posterPath',
    popularity: 1,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 1,
    overview: 'overview',
    originCountry: ['en'],
    genreIds: [1, 2, 3, 4],
    originalLanguage: 'originalLanguage',
    voteCount: 1,
    name: 'name',
    originalName: 'originalName',
  );

  final tTv = Tv(
    posterPath: 'posterPath',
    popularity: 1,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 1,
    overview: 'overview',
    originCountry: ['en'],
    genreIds: [1, 2, 3, 4],
    originalLanguage: 'originalLanguage',
    voteCount: 1,
    name: 'name',
    originalName: 'originalName',
  );

  test('should be a subclass of Tv entity', () async {
    final model = tModel.toEntity();
    expect(model, tTv);
  });
}
