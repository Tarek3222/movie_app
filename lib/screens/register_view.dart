
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/home_view.dart';
import 'package:movie_app/widgets/custom_button.dart';
import 'package:movie_app/widgets/custom_text_field.dart';
import 'package:movie_app/widgets/methods.dart';

class RegisterView extends StatefulWidget {
 const RegisterView({super.key});

  static String id = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey=GlobalKey();

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
                  const SizedBox(
                    height: 5,
                  ),
                  const Center(
                    child:  Text(
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
                      'Register',
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
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Email can\'t be empty';
                        }
                        return null;
                      },
                      suffixIcon: const Icon(Icons.email, color: Colors.red,),
                      labelText: 'Email',
                      hintText: 'Enter your email'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      onChanged: (data) {
                        password = data;
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Password can\'t be empty';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon:  Icon(
                          !isObscure ? Icons.visibility : Icons.visibility_off_outlined,
                          color: Colors.red,
                        ),
                      ),
                      obscureText: isObscure,
                      labelText: 'Password',
                      hintText: 'Enter your password'),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await registerUser();
                          Navigator.pushNamed(context, HomeView.id, arguments: email!.substring(0, email!.indexOf('@')));
                          formKey.currentState!.reset();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(context,'weak password');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context,'email already in use');
                          }else if (e.code == 'invalid-email') {
                            showSnackBar(context,'invalid email');
                          }
                        }catch(e){
                          showSnackBar(context, 'Something went wrong');
                        }
          
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    text: 'Register',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> registerUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential =
        await auth.createUserWithEmailAndPassword(
            email: email!.trim(), password: password!);
  }
}
