import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/modules/bloc_screen/bloc/counter_bloc.dart';

@RoutePage()
class BlocScreen extends StatelessWidget {
  final String? title;

  const BlocScreen({@PathParam('title') this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title ?? ''),
        ),
        body: BlocProvider(
          create: (context) => CounterBloc(),
          child: BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: 'minusBtn',
                      onPressed: () => context
                          .read<CounterBloc>()
                          .add(const CounterEvent.decreased()),
                      child: const Icon(Icons.remove),
                    ),
                    Text('${state.value}'),
                    FloatingActionButton(
                      heroTag: 'plusBtn',
                      onPressed: () => context
                          .read<CounterBloc>()
                          .add(const CounterEvent.increased()),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
}
