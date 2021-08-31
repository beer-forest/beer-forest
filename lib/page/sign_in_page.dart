import 'package:firebase_authentication_tutorial/route/route.dart' as route;
import 'package:firebase_authentication_tutorial/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'learnmate',
                      style: TextStyle(fontSize: 52.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                            hintText: 'asdf@gmail.com',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)
                        )
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    obscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.green, width: 2.0)
                                  )
                              )
                          ),
                          onPressed: (){
                            context.read<AuthenticationService>().signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            print("inside sign_in_page");
                            // TODO(chococigar) there is a known delay in sign in. for some reason you have to click twice.
                            if (Auth.instance.isSignedIn) {
                              print("is signed in.");
                              Navigator.of(context).pushNamed(route.Home);
                            }
                          },
                          child: Center(
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 8.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 0.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.green, width: 2.0)
                                )
                            )
                        ),
                        onPressed: () => Navigator.of(context).pushNamed(route.SignUp),
                        child:
                          Center(
                            child: Text('Sign up',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')
                            ),
                          ),
                      ),
                    ),
                  ),
                ]
              ),
            ),
         ],
      ),
      ),
    );
  }
}
