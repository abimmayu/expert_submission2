import 'package:cached_network_image/cached_network_image.dart';

import 'package:about/about_page.dart';
import 'package:core/common/utils/constants.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movies/presentation/bloc/popular_movie/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movie/top_rated_movies_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';
import 'package:search/presentation/search.dart';
import 'package:television/presentation/pages/television_home_page.dart';
import 'package:television/presentation/pages/television_watchlist_page.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
  static const routeName = '/home';
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingsMoviesBloc>().add(NowPlayingsMoviesGetEvent());
      context.read<PopularsMoviesBloc>().add(PopularsMoviesGetEvent());
      context.read<TopRatedsMoviesBloc>().add(TopRatedsMoviesGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/abimmayu.jpg'),
              ),
              accountName: Text('Abim Mayu Indra Ardiansyah'),
              accountEmail: Text('p2324b319@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Television'),
              onTap: () {
                Navigator.pushNamed(context, HomeTelevisionPage.routeName);
              },
            ),
            ExpansionTile(
              title: const Text('Watchlist'),
              leading: const Icon(Icons.save_alt),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.movie),
                  title: const Text('Movies'),
                  onTap: () {
                    Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.tv),
                  title: const Text('Television'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, WatchlistTelevisionPage.routeName);
                  },
                ),
              ],
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing Movies',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingsMoviesBloc, NowPlayingsMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingsMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingsMoviesLoaded) {
                    return MovieList(state.movies);
                  } else if (state is NowPlayingsMoviesError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular Movies',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),
              BlocBuilder<PopularsMoviesBloc, PopularsMoviesState>(
                builder: (context, state) {
                  if (state is PopularsMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularsMoviesLoaded) {
                    return MovieList(state.result);
                  } else if (state is PopularsMoviesError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated Movies',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<TopRatedsMoviesBloc, TopRatedsMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedsMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedsMoviesLoaded) {
                    return MovieList(state.result);
                  } else if (state is TopRatedsMoviesError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
