
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/home_view.dart';
import 'package:movie_app/screens/register_view.dart';
import 'package:movie_app/widgets/custom_button.dart';
import 'package:movie_app/widgets/custom_text_field.dart';
import 'package:movie_app/widgets/methods.dart';

class SignInView extends StatefulWidget {
 const SignInView({super.key});
 static const String id = 'SignInView';

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Container(
           width: double.infinity,
        padding: const EdgeInsets.only(
          top: 70,
          bottom: 40,
        ),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage(kBackground),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const Center(
                    child: Text(
                      'Netflix',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                      onChanged: (data) {
                        email = data;
                      },
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                      labelText: 'Email',
                      suffixIcon: const Icon(Icons.email, color: Colors.red),
                      hintText: 'Enter Your Email'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      onChanged: (data) {
                        password = data;
                      },
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon:  Icon(
                          !isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.red,
                        ),
                      ),
                      obscureText: isObscure,
                      hintText: 'Enter Your Password'),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                         setState(() {
                           isLoading = true;
                         });
                          try {
                            await userLogIn();
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(context, HomeView.id, arguments: email!.substring(0,email!.indexOf('@')));
                            formKey.currentState!.reset();
                          } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(context, 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(
                                context, 'Wrong password provided for that user.');
                          }else if (e.code == 'invalid-email') {
                            showSnackBar(context, 'invalid email');
                          }
                        }catch(e){
                            showSnackBar(context, 'Something went wrong');
                          }
                          setState(() {
                          isLoading = false;
                        });
                        }
                    },
                    text: 'Sign In',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have an account?',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterView.id);
                          formKey.currentState!.reset();
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> userLogIn() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!.trim(), password: password!);
  }
}
