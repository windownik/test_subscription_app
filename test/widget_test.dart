import 'package:flutter_test/flutter_test.dart';
import 'package:test_payment_app/app.dart';
import 'package:test_payment_app/core/di/injection.dart';

void main() {
  setUp(() async {
    await getIt.reset();
    await configureDependencies();
  });

  testWidgets('shows welcome onboarding screen', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Добро пожаловать'), findsOneWidget);
  });
}
