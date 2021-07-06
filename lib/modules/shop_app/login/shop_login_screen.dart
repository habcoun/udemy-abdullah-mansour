import 'package:flutter/material.dart';
import 'package:structure/modules/shop_app/login/register_screen.dart';
import 'package:structure/shared/components/components.dart';
import 'package:structure/shared/components/constants.dart';

var emailController = TextEditingController();
var passwordController = TextEditingController();

class ShopLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LOGIN',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: defaultColor,
                      ),
                ),
                Text(
                  'Login now to brows our offers',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                CostumTextFormFeild(
                  label: 'Email adresse',
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  prefix: Icons.email_outlined,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "Sorry ! , Email can't be empty, Enter your email ";
                    } else {}
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                CostumTextFormFeild(
                  label: 'Password',
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  prefix: Icons.lock_outline,
                  suffix: Icons.visibility_outlined,
                  suffixPressed: () {},
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "Sorry ! , Password is too short ";
                    } else {}
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                Defaultbotton(
                  radius: 5.0,
                  text: "LOGIN",
                  onPress: () {},
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't an have account ?",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    TextButton(
                      onPressed: () {
                        navigateTo(
                          context,
                          RegisterScreen(),
                        );
                      },
                      child: Text(
                        "Register",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: defaultColor,
                            ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
