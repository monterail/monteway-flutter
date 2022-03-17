part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();
}

@autoequalMixin
class CounterIncreased extends CounterEvent
    with _$CounterIncreasedAutoequalMixin {}

@autoequalMixin
class CounterDecreased extends CounterEvent
    with _$CounterDecreasedAutoequalMixin {}
