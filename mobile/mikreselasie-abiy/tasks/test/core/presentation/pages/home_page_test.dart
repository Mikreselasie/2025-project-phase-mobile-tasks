import 'package:ecommerce/core/presentation/pages/home_page.dart';
import 'package:ecommerce/features/auth/domain/entities/authenticated_user.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_state.dart';
import 'package:ecommerce/features/product/presentation/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';

// Mock Blocs
class MockProductBloc extends Mock implements ProductBloc {}

class MockAuthBloc extends Mock implements AuthBloc {}

class FakeProductEvent extends Fake implements ProductEvent {}

class FakeProductState extends Fake implements ProductState {}

class FakeAuthState extends Fake implements AuthState {}

void main() {
  final product = ProductModel(
    id: "1",
    name: 'Test Product',
    price: 10.0,
    imageUrl: 'test.png',
    description: 'Test Description',
  );
  setUpAll(() {
    registerFallbackValue(FakeProductEvent());
    registerFallbackValue(FakeProductState());
    registerFallbackValue(FakeAuthState());
  });

  testWidgets('Back button from Product Detail navigates to HomePage', (
    WidgetTester tester,
  ) async {
    final mockProductBloc = MockProductBloc();
    final mockAuthBloc = MockAuthBloc();

    // Stub the blocs
    when(() => mockProductBloc.state).thenReturn(
      LoadedAllProductState([
        // You can create a mock product object here
      ]),
    );
    when(() => mockAuthBloc.state).thenReturn(
      AuthSuccess(
        AuthenticatedUser(
          name: 'John',
          email: '',
          id: '1',
          accessToken: "null",
        ),
      ),
    );

    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: mockProductBloc),
              BlocProvider.value(value: mockAuthBloc),
            ],
            child: HomePage(),
          ),
          routes: [
            GoRoute(
              path: 'product-detail',
              builder: (context, state) =>
                  DetailsPage(product: state.extra as ProductModel),
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));

    // Verify HomePage is displayed
    expect(find.byType(HomePage), findsOneWidget);

    // Tap on the product card to navigate
    final productCard = find.text('Test Product');
    expect(productCard, findsOneWidget);
    await tester.tap(productCard);
    await tester.pumpAndSettle();

    // Verify ProductDetailPage is displayed
    expect(find.byType(DetailsPage(product: product) as Type), findsOneWidget);

    // Tap the back button
    final backButton = find.byTooltip('Back'); // AppBar default back button
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // Verify we are back to HomePage
    expect(find.byType(HomePage), findsOneWidget);
  });
}
