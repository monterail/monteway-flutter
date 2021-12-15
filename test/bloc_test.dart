import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/src/modules/bloc_screen/bloc/counter_bloc.dart';

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

  //problem with Hive testing

  // group('Bloc main', () {
  //   setUp(() async {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     await Hive.initFlutter();
  //     Hive.registerAdapter(UserAdapter());
  //     await Hive.openBox('infoUserBoxKey');
  //   });
  //   blocTest<MainBloc, MainState>(
  //     'add user test',
  //     build: () => MainBloc(userRepository: UserRepository()),
  //     act: (bloc) => {
  //       bloc.add(AddUserEvent()),
  //     },
  //     expect: () => <MainState>[
  //       MainState(user: User(pk: 1, firstName: 'Jan', lastName: 'Nowak')),
  //     ],
  //   );
  // });
}
