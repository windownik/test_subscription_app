import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:test_payment_app/core/presentation/bloc/app_bloc.dart';

class AppRouterRefreshNotifier extends ChangeNotifier {
  AppRouterRefreshNotifier(AppBloc appBloc) {
    _subscription = appBloc.stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
