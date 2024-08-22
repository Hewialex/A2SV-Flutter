import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/auth_pages/signin_page.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/bloc/user_bloc.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/bloc/user_state.dart';
import 'package:layout_in_flutter/main.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the GetMeEvent when the SplashScreen is initialized
    // context.read<UserBloc>().add(GetMeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Image/splash.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(82, 63, 81, 243),
                  Color(0xff3F51F3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserLoaded) {
                  // Navigate to HomePage when user is authenticated
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } else {
                  // Navigate to LoginPage when user is not authenticated
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } 
              },
              builder: (context, state) {
                return AnimatedSplashScreen(
                  splash: Image.asset('Image/ecom.png'),
                  duration: 5000,
                  curve: Curves.easeInOut,
                  splashIconSize: 350,
                  splashTransition: SplashTransition.slideTransition,
                  animationDuration: const Duration(milliseconds: 1500),
                  backgroundColor: Colors.transparent,
                  pageTransitionType: PageTransitionType.fade,
                  nextScreen: const LoginPage(), // Placeholder for BlocConsumer
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
