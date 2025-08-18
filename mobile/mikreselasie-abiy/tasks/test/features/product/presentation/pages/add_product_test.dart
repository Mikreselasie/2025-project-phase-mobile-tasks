import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/presentation/pages/add_product.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/fake_usecases.dart';

/// Fake use cases to satisfy ProductBloc constructor

void main() {
  group('AddProductPage Widget Tests', () {
    testWidgets('renders AddProductPage correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ProductBloc>(
            create: (_) => ProductBloc(
              getAllProducts: FakeGetAllProducts(),
              getSingleProduct: FakeGetSingleProduct(),
              createProduct: FakeCreateProduct(),
              updateProduct: FakeUpdateProduct(),
              deleteProduct: FakeDeleteProduct(),
            ),
            child: const AddProductPage(),
          ),
        ),
      );

      // Check top title
      expect(find.text('Add Product'), findsOneWidget);
      // Check if form is rendered
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('shows success when product is added', (tester) async {
      final bloc = ProductBloc(
        getAllProducts: FakeGetAllProducts(),
        getSingleProduct: FakeGetSingleProduct(),
        createProduct: FakeCreateProduct(),
        updateProduct: FakeUpdateProduct(),
        deleteProduct: FakeDeleteProduct(),
      );

      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) =>
                BlocProvider.value(value: bloc, child: const AddProductPage()),
          ),
          GoRoute(
            path: '/home',
            builder: (_, __) => const Scaffold(body: Text('Home Page')),
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      bloc.emit(
        ProductsAddSuccess(
          ProductModel(
            id: '1234',
            name: 'Test Product',
            price: 10.0,
            description: 'Test Description',
            imageUrl: 'https://example.com/image.jpg',
          ),
        ),
      );
      await tester.pump();

      // ✅ Now both router and snackbar should work
      expect(find.text('Product added successfully'), findsOneWidget);
    });

    testWidgets('form prevents empty product name', (tester) async {
      final bloc = ProductBloc(
        getAllProducts: FakeGetAllProducts(),
        getSingleProduct: FakeGetSingleProduct(),
        createProduct: FakeCreateProduct(),
        updateProduct: FakeUpdateProduct(),
        deleteProduct: FakeDeleteProduct(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: BlocProvider<ProductBloc>(
                create: (_) => bloc,
                child: const AddProductPage(),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap submit button
      await tester.tap(find.byKey(const Key('submitProductButton')));
      await tester.pump(); // triggers validation

      expect(find.text('Enter product name'), findsOneWidget);
    });
  });
}
