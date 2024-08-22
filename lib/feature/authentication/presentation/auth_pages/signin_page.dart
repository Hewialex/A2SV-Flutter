import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_in_flutter/feature/authentication/domain/entity/user_entity.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/auth_pages/reusable_textfield.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/auth_pages/signup_page.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/bloc/user_bloc.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/bloc/user_event.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/bloc/user_state.dart';
import 'package:layout_in_flutter/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset("Image/ecom.png", width: 144, height: 50),
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 65),
                child: reusableText("Sign into your account", FontWeight.w600, 26),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableText("Email", FontWeight.w400, 16),
                  ReusableTextField(
                    hint: "ex: jon.smith@email.com",
                    textEditingController: emailController,
                    textInputType: TextInputType.emailAddress,
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
                  const SizedBox(height: 35),
                  reusableText("Password", FontWeight.w400, 16),
                  ReusableTextField(
                    hint: "*********",
                    textEditingController: passwordController,
                    textInputType: TextInputType.text,
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0, bottom: 68),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final user = UserEntity(
                        userName: '', // Not required for login
                        email: emailController.text,
                        password: passwordController.text,
                        id: '',
                      );
                      context.read<UserBloc>().add(SignInEvent(user));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please Enter Valid Data")),
                      );
                    }
                  },
                  child: ElevatedButton(onPressed:  () {
                    if (_formKey.currentState!.validate()) {
                      final user = UserEntity(
                        userName: '', // Not required for login
                        email: emailController.text,
                        password: passwordController.text,
                        id: '',
                      );
                      context.read<UserBloc>().add(SignInEvent(user));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please Enter Valid Data")),
                      );
                    }
                  }, child: Text("SIGN IN")),
                ),
              ),
              GestureDetector(
                onTap: () =>   Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage()
                                ),
                              ),
                child: RichText(
                  text: TextSpan(
                    text: "Don’t have an account? ",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    children: [
                      TextSpan(
                        text: "SIGN UP",
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
               BlocListener<UserBloc, UserState>(
                    listener: (context, state) {
                      if(state is UserLoaded){
                       Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage()
                                ),
                              );
                      } else if(state is UserError){
                         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to Login')),
        );
                      }
                    },
                    child: SizedBox(),
                )
            ],
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
