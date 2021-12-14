import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:template/src/modules/bloc_screen/bloc/counter_bloc.dart';
import 'package:template/src/modules/main_screen/bloc/main_bloc.dart';
import 'package:template/src/repositories/user_repository/user_repository.dart';

void main() {
  group('Bloc counter', () {
    blocTest<CounterBloc, CounterState>(
      'increase actions',
      build: () => CounterBloc(),
      act: (bloc) => [
        for (int i = 0; i < 4; i++) bloc.add(CounterIncreased()),
      ],
      expect: () => const <CounterState>[
        CounterState(value: 1),
        CounterState(value: 2),
        CounterState(value: 3),
        CounterState(value: 4)
      ],
    );

    blocTest<CounterBloc, CounterState>(
      'decrease actions',
      build: () => CounterBloc(),
      act: (bloc) => [for (int i = 0; i < 4; i++) bloc.add(CounterDecreased())],
      expect: () => const <CounterState>[
        CounterState(value: -1),
        CounterState(value: -2),
        CounterState(value: -3),
        CounterState(value: -4)
      ],
    );
  });

  //problem with testing Hive

  // group('Bloc main', () {
  //   setUp(() async {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     await Hive.initFlutter();
  //     Hive.registerAdapter(UserAdapter());
  //     await Hive.openBox(UserRepository.userInfoBoxKey);
  //   });
  //   blocTest<MainBloc, MainState>(
  //     'add user test',
  //     build: () => MainBloc(),
  //     act: (bloc) => {
  //       bloc.add(AddUserEvent()),
  //     },
  //     expect: () => <MainState>[
  //       MainState(user: User(pk: 1, firstName: 'Jan', lastName: 'Nowak')),
  //     ],
  //   );
  // });
}
