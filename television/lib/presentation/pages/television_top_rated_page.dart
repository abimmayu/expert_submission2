import 'package:core/presentations/widget/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:television/presentation/bloc/television_top_rated/television_top_rated_bloc.dart';

class TopRatedTelevisionPage extends StatefulWidget {
  static const routeName = '/top-rated-tv';

  const TopRatedTelevisionPage({Key? key}) : super(key: key);

  @override
  _TopRatedTelevisionPageState createState() => _TopRatedTelevisionPageState();
}

class _TopRatedTelevisionPageState extends State<TopRatedTelevisionPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedsTvsBloc>().add(TopRatedsTvsGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedsTvsBloc, TopRatedsTvsState>(
          builder: (context, state) {
            if (state is TopRatedsTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedsTvsLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvs = state.result[index];
                  return TvCard(tvs);
                },
                itemCount: state.result.length,
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text("Error"),
              );
            }
          },
        ),
      ),
    );
  }
}
