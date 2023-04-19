part of 'counter_bloc.dart';

@freezed
class CounterEvent with _$CounterEvent {
  const factory CounterEvent.increased() = _Increased;
  const factory CounterEvent.decreased() = _Decreased;
}
