import 'package:muse/data/datasources/db/database_helper.dart';
import 'package:muse/data/datasources/tv_local_datasource.dart';
import 'package:muse/data/datasources/tv_remote_datasource.dart';
import 'package:muse/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TelevisionRemoteDataSource,
  TelevisionLocalDataSource,
  DatabaseHelperTv,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
