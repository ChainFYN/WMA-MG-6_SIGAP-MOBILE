import 'package:flutter_test/flutter_test.dart';
import 'package:sigap_app/main.dart';

void main() {
  testWidgets('SIGAP smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SigapApp());

    // Verify that SIGAP title is rendered.
    expect(find.text('SIGAP'), findsWidgets);
    expect(find.text('Pendaftaran Akun Warga'), findsOneWidget);
  });
}
