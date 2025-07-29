# 🛍️ Task 6: Flutter E-commerce Navigation Project

## 🚀 Overview

This Flutter project demonstrates a simple e-commerce application with structured navigation using Flutter's routing system. The app includes multiple screens with navigation patterns such as argument passing, stack management, and conditional navigation logic.

## 📌 Navigation Flow

- **Home Page**

  - **Add Button**: Navigates to the Add/Update Product Page, passing an argument to indicate the action type.
  - **Search Button**: Navigates to the Search Page.
  - **Product Cards**: Navigate to the Product Details Page with product information passed as arguments.

- **Product Details Page**

  - **Update Button**: Routes to the Add/Update Product Page, passing the selected product data.
  - **Delete Button**: Removes the product and pops the current screen to return to the previous page.

- **Add/Update Product Page**

  - Displays a dynamic button that toggles between **Add** and **Update** based on context.
  - On submission (Add/Update), navigates back to the Home Page.
  - **Delete Button** (if shown): Pops the current screen from the navigation stack.

- **Back Navigation**

  - All pages include a back arrow or similar mechanism that pops the current screen from the stack, returning the user to the previous screen.

## 📦 Getting Started

1. Ensure Flutter is installed and configured.
2. Clone or download the repository.
3. Run the following commands:

```bash
flutter pub get
flutter run
```

This will launch the application on your connected device or emulator.

---

For best practices, each navigation action should use `Navigator.push`, `Navigator.pop`, or `Navigator.pushNamed` depending on your routing setup.

