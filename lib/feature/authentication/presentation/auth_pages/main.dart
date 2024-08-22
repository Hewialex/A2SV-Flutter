
// import 'package:flutter/material.dart';
// import 'package:layout_in_flutter/feature/authentication/presentation/auth_pages/signin_page.dart';
// import 'package:layout_in_flutter/feature/authentication/presentation/auth_pages/signup_page.dart';


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App Name',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       initialRoute: '/sign_up_page',
//       routes: {
//         '/sign_up_page': (context) => const SignUpPage(),
//         '/login_page': (context) => const LoginPage(),
//         '/home_page': (context) => const HomePage(), // Replace with your actual home page
//          // If you have a different sign-up page
//       },
//       onUnknownRoute: (settings) {
//         // Handle unknown routes
//         return MaterialPageRoute(
//           builder: (context) => const SignUpPage(), // Default fallback
//         );
//       },
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: const Center(
//         child: Text('Welcome to the Home Page!'),
//       ),
//     );
//   }
// }
