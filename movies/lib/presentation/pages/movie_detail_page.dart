import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entity/genre.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/presentation/bloc/detail_movie/detail_movie_bloc.dart';
import 'package:movies/presentation/bloc/recommend_movie/recommended_movies_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_movies_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail';

  final int id;
  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailsMoviesBloc>().add(GetDetailsMoviesEvent(widget.id));
      context
          .read<RecommendMoviesBloc>()
          .add(GetRecommendMoviesEvent(widget.id));
      context.read<WatchlistMoviesBloc>().add(GetStatusMovieEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    RecommendMoviesState movieRecommendations =
        context.watch<RecommendMoviesBloc>().state;
    return Scaffold(
      body: BlocListener<WatchlistMoviesBloc, WatchlistMoviesState>(
        listener: (_, state) {
          if (state is MovieWatchlistSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
            context
                .read<WatchlistMoviesBloc>()
                .add(GetStatusMovieEvent(widget.id));
          }
        },
        child: BlocBuilder<DetailsMoviesBloc, DetailsMoviesState>(
          builder: (context, state) {
            if (state is MoviesDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviesDetailsLoaded) {
              final movie = state.movieDetail;
              bool isAddedToWatchlist = (context
                      .watch<WatchlistMoviesBloc>()
                      .state is MovieWatchlistStatusLoaded)
                  ? (context.read<WatchlistMoviesBloc>().state
                          as MovieWatchlistStatusLoaded)
                      .result
                  : false;
              return SafeArea(
                child: DetailContent(
                  movie,
                  movieRecommendations is RecommendMoviesLoaded
                      ? movieRecommendations.movies
                      : List.empty(),
                  isAddedToWatchlist,
                ),
              );
            } else {
              return const Text("Empty");
            }
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;
  const DetailContent(this.movie, this.recommendations, this.isAddedWatchlist,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  BlocProvider.of<WatchlistMoviesBloc>(context)
                                      .add(AddItemMovieEvent(movie));
                                } else {
                                  BlocProvider.of<WatchlistMoviesBloc>(context)
                                      .add(RemoveItemMovieEvent(movie));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendMoviesBloc,
                                RecommendMoviesState>(
                              builder: (context, state) {
                                if (state is RecommendMoviesLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is RecommendMoviesError) {
                                  return Text(state.message);
                                } else if (state is RecommendMoviesLoaded) {
                                  final recommendations = state.movies;
                                  if (recommendations.isEmpty) {
                                    return const Text(
                                        "No movie recommendations");
                                  }
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.routeName,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }
    if (result.isEmpty) {
      return result;
    }
    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
