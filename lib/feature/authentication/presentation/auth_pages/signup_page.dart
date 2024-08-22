import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:layout_in_flutter/feature/authentication/domain/entity/user_entity.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/auth_pages/signin_page.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/bloc/user_bloc.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/bloc/user_event.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/bloc/user_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<UserBloc>(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.navigate_before),
                ),
                Image.asset(
                  "Image/ecom.png", 
                  width: 78,
                  height: 25,
                ),
              ],
            ),
          ),
        ),
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoaded) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            } else if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Unable to Sign Up')),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: reusableText("Create your account", FontWeight.w600, 26),
                  ),
                  reusableText("Name", FontWeight.w400, 16),
                  TextFormField(
                    controller: nameEditingController,
                    decoration: InputDecoration(
                      hintText: "ex: jon smith",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  reusableText("Email", FontWeight.w400, 16),
                  TextFormField(
                    controller: emailEditingController,
                    decoration: InputDecoration(
                      hintText: "ex: jon.smith@email.com",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  reusableText("Password", FontWeight.w400, 16),
                  TextFormField(
                    controller: passwordEditingController,
                    decoration: InputDecoration(
                      hintText: "**********",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  reusableText("Confirm password", FontWeight.w400, 16),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: "**********",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value != passwordEditingController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: isTermsAccepted,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onChanged: (value) {
                          setState(() {
                            isTermsAccepted = value ?? false;
                          });
                        },
                      ),
                      RichText(
                        text: const TextSpan(
                          text: "I understood the ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: "terms & policy.",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff3F51F3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && isTermsAccepted) {
                          final user = UserEntity(
                            userName: nameEditingController.text,
                            email: emailEditingController.text,
                            password: passwordEditingController.text,
                            id: '',
                          );
                          context.read<UserBloc>().add(SignUpEvent(user));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please accept the terms and make sure passwords match.")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("SIGN UP"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RichText(
                        text: TextSpan(
                          text: "Have an account? ",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: "SIGN IN",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff3F51F3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text reusableText(String text, FontWeight weight, double size, [Color color = Colors.black]) {
    return Text(
      text,
      overflow: TextOverflow.clip,
      style: TextStyle(fontWeight: weight, fontSize: size, color: color),
    );
  }
}
