import 'package:about/about_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/pages/home_movie_page.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';
import 'package:search/presentation/pages/search_pages_television.dart';
import 'package:television/domain/entities/television.dart';
import 'package:television/presentation/bloc/television_on_air/television_on_air_bloc.dart';
import 'package:television/presentation/bloc/television_popular/television_popular_bloc.dart';
import 'package:television/presentation/bloc/television_top_rated/television_top_rated_bloc.dart';
import 'package:television/presentation/pages/television_detail_page.dart';
import 'package:television/presentation/pages/television_popular_page.dart';
import 'package:television/presentation/pages/television_top_rated_page.dart';
import 'package:television/presentation/pages/television_watchlist_page.dart';

class HomeTelevisionPage extends StatefulWidget {
  const HomeTelevisionPage({Key? key}) : super(key: key);

  @override
  _HomeTelevisionPageState createState() => _HomeTelevisionPageState();
  static const routeName = '/tv';
}

class _HomeTelevisionPageState extends State<HomeTelevisionPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OnAirsTvsBloc>().add(OnAirsTvsGetEvent());
      context.read<PopularsTvsBloc>().add(PopularsTvsGetEvent());
      context.read<TopRatedsTvsBloc>().add(TopRatedsTvsGetEvent());
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
                Navigator.pushNamed(context, HomeMoviePage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Television'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
              title: const Text('Watchlist'),
              leading: const Icon(Icons.save_alt),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.movie),
                  title: const Text('Movie'),
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
        title: const Text('Muse Asia'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTelevisionPage.routeName);
            },
            icon: const Icon(Icons.search),
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
                'Now Playing TV',
                style: kHeading6,
              ),
              BlocBuilder<OnAirsTvsBloc, OnAirsTvsState>(
                builder: (context, state) {
                  if (state is OnAirsTvsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is OnAirsTvsLoaded) {
                    return TvList(state.result);
                  } else if (state is OnAirsTvsError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular TV',
                onTap: () => Navigator.pushNamed(
                    context, PopularTelevisionPage.routeName),
              ),
              BlocBuilder<PopularsTvsBloc, PopularsTvsState>(
                builder: (context, state) {
                  if (state is PopularsTvsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularsTvsLoaded) {
                    return TvList(state.result);
                  } else if (state is PopularsTvsError) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated TV',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTelevisionPage.routeName),
              ),
              BlocBuilder<TopRatedsTvsBloc, TopRatedsTvsState>(
                builder: (context, state) {
                  if (state is TopRatedsTvsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedsTvsLoaded) {
                    return TvList(state.result);
                  } else if (state is TopRatedsTvsError) {
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

class TvList extends StatelessWidget {
  final List<Tv> tv;

  const TvList(this.tv, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvs = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TelevisionDetailPage.routeName,
                  arguments: tvs.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tvs.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
