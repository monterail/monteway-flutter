import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/modules/cubit_screen/cubit/counter_cubit.dart';

@RoutePage()
class CubitScreen extends StatelessWidget {
  final String? title;

  const CubitScreen({@PathParam('title') this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title ?? ''),
        ),
        body: BlocProvider(
          create: (context) => CounterCubit(),
          child: BlocBuilder<CounterCubit, CounterState>(
            builder: (context, state) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: 'minusBtn',
                      onPressed: () => context.read<CounterCubit>().decrement(),
                      child: const Icon(Icons.remove),
                    ),
                    Text('${state.value}'),
                    FloatingActionButton(
                      heroTag: 'plusBtn',
                      onPressed: () => context.read<CounterCubit>().increment(),
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
