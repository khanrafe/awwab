import 'package:awwab/src/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders app shell', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: AwwabApp()));
    await tester.pumpAndSettle();

    expect(find.text('Your Recovery System'), findsOneWidget);
  });
}
