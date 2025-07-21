enum ProductCategory {
  shoes,
  clothing,
  accessories,
  electronics,
  beauty,
  home,
  sports,
  toys,
}

extension ProductCategoryExtension on ProductCategory {
  String get displayName {
    switch (this) {
      case ProductCategory.shoes:
        return 'Shoes';
      case ProductCategory.clothing:
        return 'Clothing';
      case ProductCategory.accessories:
        return 'Accessories';
      case ProductCategory.electronics:
        return 'Electronics';
      case ProductCategory.beauty:
        return 'Beauty & Personal Care';
      case ProductCategory.home:
        return 'Home & Living';
      case ProductCategory.sports:
        return 'Sports & Outdoors';
      case ProductCategory.toys:
        return 'Toys & Games';
    }
  }
}
