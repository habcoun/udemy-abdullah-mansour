import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:structure/layout/shop_app/shop-layout.dart';
import 'package:structure/modules/shop_app/login/cubit/shop_login_cubit.dart';
import 'package:structure/modules/shop_app/register/shop_register_screen.dart';
import 'package:structure/shared/components/components.dart';
import 'package:structure/shared/components/constants.dart';
import 'package:structure/shared/network/local/cahce_helper.dart';

var emailController = TextEditingController();
var passwordController = TextEditingController();
var formKey = GlobalKey<FormState>();

class ShopLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSucess) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });

              print(state.loginModel.message);
            } else {
              showToast(
                message: state.loginModel.message.toString(),
                state: ToastState.ERROR,
                colorText: Colors.white,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: defaultColor,
                                  ),
                        ),
                        Text(
                          'Login now to brows our hot offers',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
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
                          isPassword:
                              ShopLoginCubit.get(context).isPasswordShow,
                          label: 'Password',
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock_outline,
                          suffix: ShopLoginCubit.get(context).suffix,
                          onTap: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Sorry ! , Password is too short ";
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (BuildContext context) =>
                              state is! ShopLoginLoading,
                          widgetBuilder: (BuildContext context) =>
                              Defaultbotton(
                            radius: 5.0,
                            text: "LOGIN",
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallbackBuilder: (BuildContext context) => Center(
                            child: CircularProgressIndicator(),
                          ),
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
                                  ShopRegisterScreen(),
                                );
                              },
                              child: Text(
                                "Register",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
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
            ),
          );
        },
      ),
    );
  }
}
