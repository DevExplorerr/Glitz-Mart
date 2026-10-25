# Glitz Mart

Glitz Mart is a Flutter e-commerce application with Firebase email/password
authentication, a product catalog loaded from the Fake Store API, and a
mobile-first shopping experience for browsing, favoriting, cart management,
checkout, and order confirmation.

## Features

- Splash screen followed by sign-up and login flows.
- Firebase Authentication for email/password registration and sign-in.
- Product catalog fetched from `https://fakestoreapi.com/products`.
- Product categories, promotional banners, product cards, ratings, and detail
  views.
- Store search interface and bottom navigation for Home, Favorites, Cart, and
  Account sections.
- Add-to-cart, quantity adjustment, item removal, total quantity, and total
  price calculation.
- Favorites managed with Provider.
- Checkout review with:
  - Cart item summary
  - Subtotal and billing summary
  - Address section
  - Credit/debit card, PayPal, cash on delivery, and Payoneer selections
  - Promo-code input
- Order confirmation screen with a continue-shopping action.
- Responsive Flutter UI with bundled category, payment, promotional, and
  animated GIF assets.

## Technology stack

- **Flutter/Dart** (`>=3.3.0 <4.0.0`)
- **GetX** for navigation and reactive controllers
- **Provider** for favorites state
- **Firebase Core** and **Firebase Auth**
- **HTTP** for Fake Store API requests
- **Cloud Firestore** and **Firebase Storage** dependencies are declared for
  future use, but the current application code does not persist products,
  carts, orders, or uploaded files with them.
- `carousel_slider`, `flutter_slidable`, `flutter_rating_bar`,
  `flutter_credit_card`, `google_fonts`, `shimmer`, and `fluttertoast`

## Requirements

Install the following before starting:

- Flutter SDK with Dart 3.3 or newer
- Android Studio and an Android SDK for Android development, or an Xcode
  environment for iOS development
- A configured Firebase project with Email/Password sign-in enabled if you
  want to use authentication
- Internet access at runtime for the Fake Store API and Firebase

Check the local Flutter installation with:

```bash
flutter doctor
```

## Getting started

1. Clone the repository and enter the project directory.

   ```bash
   git clone https://github.com/DevExplorerr/E-Commerce-Application.git
   cd E-Commerce-Application
   ```

2. Install Dart and Flutter dependencies.

   ```bash
   flutter pub get
   ```

3. Configure Firebase for the platforms you intend to run:

   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

   The repository currently contains Firebase configuration for Android and
   web in [`lib/firebase_options.dart`](lib/firebase_options.dart), plus the
   Android Google Services file. iOS, macOS, Windows, and Linux require their
   own Firebase configuration before they can use Firebase features.

4. Enable **Email/Password** under Firebase Authentication in the Firebase
   console.

5. Start the app on a connected device or emulator:

   ```bash
   flutter run
   ```

   You can select a target explicitly, for example:

   ```bash
   flutter run -d chrome
   flutter run -d <android-device-id>
   ```

## Typical user flow

1. The app opens on the splash screen.
2. Create an account or switch to the login screen.
3. Browse products loaded from Fake Store API.
4. Open a product to view details, add it to favorites, add it to the cart, or
   buy it immediately.
5. Review the cart and proceed to checkout.
6. Select a payment method, review the address and totals, and place the order.
7. Return to the home screen from the order confirmation page.

## Project structure

```text
lib/
├── main.dart                         # App bootstrap and Firebase initialization
├── auth_screen/                      # Login, sign-up, and Firebase Auth service
├── controller/                       # GetX controllers for users, products, and cart
├── models/                           # Product and cart data models
├── pages/                            # Screens for browsing, cart, checkout, and account
├── provider/                         # Provider-based favorites state
├── app_bar/                          # App bar widgets
├── carousel_slider/                  # Promotional carousel widgets
├── header/                           # Home header, search, and category widgets
├── widgets/                          # Reusable cards, fields, billing, and UI widgets
└── global/                           # Shared helpers such as toast notifications

assets/
├── categories/                       # Category images
├── promo-banner/                     # Promotional carousel images
└── *.png, *.gif                     # Branding, payment, and status assets
```

## State and data notes

- Products are fetched each time the product controller initializes; an API
  failure leaves the catalog unavailable and stops the loading state.
- Cart contents and favorites are held in memory, so they are reset when the
  application is restarted.
- The checkout screen currently presents a review and confirmation flow. It
  does not submit a payment, create a server-side order, or persist an
  address.
- The promo-code input is present, but applying a code is not implemented yet.
- The account controller stores the current display name and email in memory
  for the active app session.

## Useful commands

```bash
# Format Dart sources
dart format lib test

# Analyze the project
flutter analyze

# Run tests
flutter test

# Build a release Android APK
flutter build apk --release

# Build the web application
flutter build web
```

## Testing

The test suite is under [`test/`](test/). Run it with:

```bash
flutter test
```

The project includes a starter widget smoke test. When adding features, prefer
tests for authentication states, product loading/error states, cart totals,
favorite toggling, and checkout validation.

## Assets and app branding

The application title is **Glitz Mart**. Assets are declared in
[`pubspec.yaml`](pubspec.yaml), including category images, promotional banners,
payment logos, the splash animation, and the order-success animation.

## Contributing

1. Create a focused branch for your change.
2. Run `dart format`, `flutter analyze`, and `flutter test`.
3. Keep Firebase configuration and other environment-specific credentials out
   of new source files.
4. Open a pull request with a description of the user-visible behavior and
   validation performed.
