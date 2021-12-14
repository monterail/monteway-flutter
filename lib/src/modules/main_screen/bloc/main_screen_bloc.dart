import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:template/src/services/sentry.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final SentryIntegration _sentry;

  MainScreenBloc({
    required SentryIntegration sentryIntegration,
  })  : _sentry = sentryIntegration,
        super(MainScreenInitial()) {
    on<ReportSentryError>(_handleReportSentryError);
  }

  void _handleReportSentryError(
    MainScreenEvent event,
    Emitter<MainScreenState> emit,
  ) {
    throw Exception('test exception');
  }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   _sentry.captureException(error, stackTrace: stackTrace);
  //   super.onError(error, stackTrace);
  // }
}
