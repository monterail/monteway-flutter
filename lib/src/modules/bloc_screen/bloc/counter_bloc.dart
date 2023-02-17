import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_event.dart';
part 'counter_state.dart';
part 'counter_bloc.freezed.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const _CounterState()) {
    on<_Decreased>(_onDecreased);
    on<_Increased>(_onIncreased);
  }

  void _onIncreased(
    _Increased event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(value: state.value + 1));
  }

  void _onDecreased(
    _Decreased event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(value: state.value - 1));
  }
}
