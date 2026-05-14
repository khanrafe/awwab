import 'package:awwab/src/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('renders app shell', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: AwwabApp()));
    await tester.pumpAndSettle();

    expect(find.text('Awwab'), findsOneWidget);
  });
}
