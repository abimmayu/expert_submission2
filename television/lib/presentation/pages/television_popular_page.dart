import 'package:core/presentations/widget/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:television/presentation/bloc/television_popular/television_popular_bloc.dart';

class PopularTelevisionPage extends StatefulWidget {
  static const routeName = '/popular-tv';

  const PopularTelevisionPage({Key? key}) : super(key: key);

  @override
  _PopularTelevisionPageState createState() => _PopularTelevisionPageState();
}

class _PopularTelevisionPageState extends State<PopularTelevisionPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularsTvsBloc>().add(PopularsTvsGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Popular TV series page'),
      appBar: AppBar(
        title: const Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularsTvsBloc, PopularsTvsState>(
          builder: (context, state) {
            if (state is PopularsTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularsTvsLoaded) {
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
