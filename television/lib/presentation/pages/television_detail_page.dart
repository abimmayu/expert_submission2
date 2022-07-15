import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entity/genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:television/domain/entities/television.dart';
import 'package:television/domain/entities/television_detail.dart';
import 'package:television/presentation/bloc/television_detail/television_detail_bloc.dart';
import 'package:television/presentation/bloc/television_recommend/television_recommend_bloc.dart';
import 'package:television/presentation/bloc/television_watchlist/television_watchlist_bloc.dart';

class TelevisionDetailPage extends StatefulWidget {
  static const routeName = '/detail-tv';

  final int id;

  const TelevisionDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TelevisionDetailPageState createState() => _TelevisionDetailPageState();
}

class _TelevisionDetailPageState extends State<TelevisionDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailsTvsBloc>().add(GetDetailsTvsEvent(widget.id));
      context.read<RecommendTvsBloc>().add(GetRecommendTvsEvent(widget.id));
      context.read<WatchlistTvsBloc>().add(GetStatusTvsEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    RecommendTvsState tvRecommendations =
        context.watch<RecommendTvsBloc>().state;
    return Scaffold(
      body: BlocListener<WatchlistTvsBloc, WatchlistTvsState>(
        listener: (_, state) {
          if (state is WatchlistTvsSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
            context.read<WatchlistTvsBloc>().add(GetStatusTvsEvent(widget.id));
          }
        },
        child: BlocBuilder<DetailsTvsBloc, DetailsTvsState>(
          builder: (context, state) {
            if (state is DetailsTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DetailTvsLoaded) {
              final tv = state.tvDetail;
              bool isAddedToWatchlistTv = (context
                      .watch<WatchlistTvsBloc>()
                      .state is WatchlistTvsStatusLoaded)
                  ? (context.read<WatchlistTvsBloc>().state
                          as WatchlistTvsStatusLoaded)
                      .result
                  : false;
              return SafeArea(
                child: DetailContent(
                  tv,
                  tvRecommendations is RecommendTvsLoaded
                      ? tvRecommendations.tv
                      : List.empty(),
                  isAddedToWatchlistTv,
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
  final TvDetail tv;
  final List<Tv> recommendations;
  final bool isAddedWatchlistTv;

  const DetailContent(this.tv, this.recommendations, this.isAddedWatchlistTv,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlistTv) {
                                  BlocProvider.of<WatchlistTvsBloc>(context)
                                      .add(AddItemTvsEvent(tv));
                                } else {
                                  BlocProvider.of<WatchlistTvsBloc>(context)
                                      .add(RemoveItemTvsEvent(tv));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlistTv
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Text(
                              (tv.firstAirDate),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendTvsBloc, RecommendTvsState>(
                              builder: (context, state) {
                                if (state is RecommendTvsLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is RecommendTvsError) {
                                  return Text(state.message);
                                } else if (state is RecommendTvsLoaded) {
                                  final recommendations = state.tv;
                                  if (recommendations.isEmpty) {
                                    return const Text("No tv recommendations");
                                  }
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TelevisionDetailPage.routeName,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
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
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
