# Task 14 | 🛒 Product Local Data Source (Flutter / Dart)

This module handles local caching of products using `SharedPreferences`. It provides a simple interface for saving, retrieving, updating, and deleting product data stored locally on the device.

---

## 📦 Features

- Cache a list of `ProductModel`s.
- Retrieve all cached products.
- Save a single product via JSON.
- Update an existing product.
- Delete a product by ID.
- Unit tested using `Mockito`.

---

## 🧱 Structure

```dart
abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getAllCachedProducts();
  Future<ProductModel> getProductById(String id);
  Future<void> cacheProduct(ProductModel product);
  Future<void> saveProduct(Map<String, dynamic> productJson);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}```

# 🛍️ Task 10: Flutter E-commerce Project with Clean architecture

## 🚀 Overview

This Flutter project demonstrates a simple e-commerce application with clean architecture that follows the onion model in which the innner layers are independent of the outer layer.

## Tests included

- **Product Model Test**
  - **File Location**: test/features/product/data/models/product_model_test.dart

  - **Check if Product model is subclass of Product**
  - **Check if fromJSON method is working well**
  - **Check if toJSON method is workin well**

- **Create Product Test**: This test verifies that the CreateProduct use case correctly interacts with the ProductRepository to create a product.
  - **File Location**: test/features/product/domain/usecases/create_product_test.dart

  - Ensures the **createProduct** method in the repository is called with the correct Product entity.
  - Confirms that the result returned by the use case matches the expected Right(Product) value.
  - Uses mockito to isolate and mock the repository behavior.

- **Delete Product Use Case**

  - The repository's deleteProduct method is called with the correct productId. 
  - The result is a successful Right(unit) response.
  - No unexpected repository interactions occur.
  - **Uses**:
    - mockito for mocking the repository
    - dartz for Right and unit

- **Get All Products Use Case**
  - Tests that the GetAllProducts use case fetches the product list from the repository.
  - **Verifies**:
    - Calls getAllProducts() on the repository
    - Returns a Right(List<Product>) result
    - No other interactions with the repository
  - **Tools Used**:
    - mockito to mock the repository
    - dartz for Right and NoParams

- **Get Product By ID Use Case**
  - This test ensures the GetProduct use case correctly retrieves a product from the repository using its ID.
  - **Verifies**:
    - Calls getProductById() with the correct ID
    - Returns a Right(Product) result
    - No additional interactions with the repository
  - **Tools Used**:
    - mockito to mock the repository
    - dartz for Right and NoParams
- **Update Product Use Case**
  - This test ensures that the UpdateProduct use case properly updates a product through the repository.
  - **Verifies**:
    - Calls updateProduct() with the correct Product entity
    - Returns Right(Product) upon success
    - Confirms no unexpected repository interactions
  - **Tools Used**:
    - mockito to mock the repository
    - dartz for Right and NoParams


## 📦 Getting Started

1. Ensure Flutter is installed and configured.
2. Clone or download the repository.
3. Run the following commands:

```bash
flutter pub get
flutter run
```



