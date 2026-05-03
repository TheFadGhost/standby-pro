import 'package:flutter_test/flutter_test.dart';
import 'package:standby_pro/src/app.dart';
import 'package:standby_pro/src/domain/standby_models.dart';

void main() {
  testWidgets('renders the StandBy screen with duo widgets and customization', (
    tester,
  ) async {
    await tester.pumpWidget(
      const StandbyProApp(
        initialSettings: StandbySettings(
          layoutMode: StandbyLayoutMode.duo,
          activeThemeId: 'aurora',
          leftWidget: StandbyWidgetType.clock,
          rightWidget: StandbyWidgetType.weather,
          clockStyle: ClockStyle.digital,
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Standby Pro'), findsOneWidget);
    expect(find.text('Weather'), findsOneWidget);
    expect(find.text('Customize'), findsOneWidget);
    expect(find.textContaining('London'), findsOneWidget);
  });

  testWidgets('single focus mode shows the configured clock face', (
    tester,
  ) async {
    await tester.pumpWidget(
      const StandbyProApp(
        initialSettings: StandbySettings(
          layoutMode: StandbyLayoutMode.single,
          clockStyle: ClockStyle.flip,
          leftWidget: StandbyWidgetType.clock,
          rightWidget: StandbyWidgetType.music,
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Flip'), findsOneWidget);
    expect(find.text('Duo'), findsOneWidget);
    expect(find.text('Music'), findsNothing);
  });

  testWidgets('customization sheet exposes widget and clock controls', (
    tester,
  ) async {
    await tester.pumpWidget(
      const StandbyProApp(initialSettings: StandbySettings()),
    );

    await tester.tap(find.text('Customize'));
    await tester.pumpAndSettle();

    expect(find.text('Left widget'), findsOneWidget);
    expect(find.text('Right widget'), findsOneWidget);
    expect(find.text('Clock face'), findsOneWidget);
    expect(find.text('OLED burn-in protection'), findsOneWidget);
  });
}
