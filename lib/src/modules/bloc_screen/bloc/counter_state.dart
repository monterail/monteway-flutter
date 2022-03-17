part of 'counter_bloc.dart';

@autoequalMixin
class CounterState extends Equatable with _$CounterStateAutoequalMixin {
  final int value;
  const CounterState({this.value = 0});

  CounterState copyWith({int? value}) => CounterState(
        value: value ?? this.value,
      );
}
