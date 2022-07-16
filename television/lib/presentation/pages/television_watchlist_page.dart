import 'package:core/common/utils.dart';
import 'package:core/presentations/widget/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:television/presentation/bloc/television_watchlist/television_watchlist_bloc.dart';

class WatchlistTelevisionPage extends StatefulWidget {
  static const routeName = '/watchlist-tv';

  const WatchlistTelevisionPage({Key? key}) : super(key: key);

  @override
  _WatchlistTelevisionPageState createState() =>
      _WatchlistTelevisionPageState();
}

class _WatchlistTelevisionPageState extends State<WatchlistTelevisionPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistTvsBloc>().add(GetListEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvsBloc>().add(GetListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('watchlist tv page'),
      appBar: AppBar(
        title: const Text('Watchlist TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvsBloc, WatchlistTvsState>(
          builder: (context, state) {
            if (state is WatchlistTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvsLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
