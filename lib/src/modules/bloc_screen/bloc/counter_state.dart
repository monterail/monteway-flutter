part of 'counter_bloc.dart';

@CopyWith()
@autoequalMixin
class CounterState extends Equatable with _$CounterStateAutoequalMixin {
  final int value;
  const CounterState({this.value = 0});
}
