import 'package:e_commerce_app/commons/widgets/custom_button.dart';
import 'package:e_commerce_app/commons/widgets/custom_text_field.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum AuthOptions {
  signUp,
  signIn,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthOptions? _authoptions = AuthOptions.signIn;
  final AuthService authService = AuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();

  void signUpUser() {
    authService.signUpUser(
        context: context,
        username: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // text
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            // some spacing
            const SizedBox(
              height: 10,
            ),
            // Sign Up radio - tile
            ListTile(
              tileColor: _authoptions == AuthOptions.signUp
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Create Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                  fillColor: const MaterialStatePropertyAll(
                      GlobalVariables.secondaryColor),
                  value: AuthOptions.signUp,
                  groupValue: _authoptions,
                  onChanged: (val) {
                    setState(() {
                      _authoptions = val;
                    });
                  }),
            ),
            // Sign Up radio - tile
            if (_authoptions == AuthOptions.signUp)
              Container(
                color: GlobalVariables.backgroundColor,
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        textEditingController: _nameController,
                        hintText: "Name",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        textEditingController: _emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        textEditingController: _passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          text: "Create Account",
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ListTile(
              tileColor: _authoptions == AuthOptions.signIn
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Sign-In.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                  fillColor: const MaterialStatePropertyAll(
                      GlobalVariables.secondaryColor),
                  value: AuthOptions.signIn,
                  groupValue: _authoptions,
                  onChanged: (val) {
                    setState(() {
                      _authoptions = val;
                    });
                  }),
            ),
            if (_authoptions == AuthOptions.signIn)
              Container(
                color: GlobalVariables.backgroundColor,
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        textEditingController: _emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        textEditingController: _passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          text: "Sign in",
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
