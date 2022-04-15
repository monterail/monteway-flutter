part of 'counter_cubit.dart';

@CopyWith()
@autoequalMixin
class CounterState extends Equatable with _$CounterStateAutoequalMixin {
  final int value;
  const CounterState({this.value = 0});
}
