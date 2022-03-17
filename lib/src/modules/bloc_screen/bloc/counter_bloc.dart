import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_bloc.g.dart';
part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterIncreased>(_onIncreased);
    on<CounterDecreased>(_onDecreased);
  }

  void _onIncreased(CounterIncreased event, Emitter<CounterState> emit) {
    emit(state.copyWith(value: state.value + 1));
  }

  void _onDecreased(CounterDecreased event, Emitter<CounterState> emit) {
    emit(state.copyWith(value: state.value - 1));
  }
}
