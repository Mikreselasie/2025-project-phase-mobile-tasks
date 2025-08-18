import 'package:ecommerce/core/presentation/pages/home_page.dart';
import 'package:ecommerce/features/product/presentation/pages/details_page.dart';
import 'package:ecommerce/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test Product Detail Page Navigation', (
    WidgetTester tester,
  ) async {
    // Build the app
    await tester.pumpWidget(App()); // Replace with your root widget

    // Ensure the home page is displayed
    expect(find.byType(HomePage), findsOneWidget);

    // Tap on a product to navigate to the Product Detail page
    final productFinder = find.text(
      'Product 1',
    ); // Adjust text to match your test product
    expect(productFinder, findsOneWidget);
    await tester.tap(productFinder);
    await tester.pumpAndSettle(); // Wait for the navigation animation to finish

    // Ensure Product Detail page is displayed
    expect(find.byType(DetailsPage), findsOneWidget);

    // Tap the back button (AppBar back button)
    final backButton = find.byTooltip(
      'Back',
    ); // Default tooltip for back button
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle(); // Wait for the pop animation

    // Ensure we are back on the home page
    expect(find.byType(HomePage), findsOneWidget);
  });
}
