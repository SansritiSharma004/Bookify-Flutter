import 'package:bookify/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  //password visibility
  bool passwordVisible = false;
  @override
  void initState(){
    super.initState();
    passwordVisible = true;
  }

  var _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(

        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              // enter name
              Row(

                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: const Text("Name"),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: 281,
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(191, 207, 255, 1),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'john',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(191, 207, 255, 1),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(10.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 1),)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 1))
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),



              // enter email
              Row(

                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: const Text("Email"),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: 281,
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(191, 207, 255, 1),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'john@bookify.com',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(191, 207, 255, 1),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(10.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 1),)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 1))
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),



              // enter password
              Row(

                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 33.0),
                    child: const Text("Password"),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: 281,
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(191, 207, 255, 1),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Enter Password',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(191, 207, 255, 1),
                        ),
                        suffixIconConstraints: BoxConstraints(maxHeight: 35, minHeight:35 ),
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: Color.fromRGBO(191, 207, 255, 1),
                          onPressed: (){
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        alignLabelWithHint: true,
                        isDense: true,
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 1),)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Color.fromRGBO(191, 207, 255, 1))
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                width: 77,
                height: 77,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 179, 1),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        width: 2,
                        color: Color.fromRGBO(191, 207, 255, 10)
                    )
                ),
                child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 0, 179, 1),

                    ),
                    onPressed: (){

                    },
                    child: Text('Sign Up', style: TextStyle(fontSize: 10, color: Colors.white),)
                ),
              ),

              TextButton(onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LogInScreen()));

              }, child: Text("Log In ?"))

            ],
          ),
        ),
      ),
    );
  }
}
