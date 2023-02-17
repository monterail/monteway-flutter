part of 'counter_cubit.dart';

@freezed
class CounterState with _$CounterState {
  const factory CounterState({@Default(0) int value}) = _CounterState;
}
