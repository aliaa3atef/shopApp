import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppHome/shopHome.dart';
import 'package:shop_app/modules/shopLogin/shopLoginCubit/cubit.dart';
import 'package:shop_app/modules/shopLogin/shopLoginCubit/state.dart';
import 'package:shop_app/modules/shopRegister/shopRegisterScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashedHelper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          builder: (context, state) {
        var cubit = ShopLoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Login To See Our exclusive Sales ',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    sharedTextFormField(
                      iconColor: colorApp,
                      controller: emailController,
                      prefixIcon: Icons.email_outlined,
                      text: "Email Address",
                      validate: (String value) {
                        if (value.isEmpty)
                          return "Email address can not be empty";
                        return null;
                      },
                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    sharedTextFormField(
                      iconColor: colorApp,
                      controller: passwordController,
                      prefixIcon: Icons.lock,
                      isPassword: cubit.isPassword,
                      suffixIcon: cubit.suffix,
                      suffixPressed: ()=> cubit.changeVisibilityIcon(),
                      text: "Password",
                      validate: (String value) {
                        if (value.isEmpty) return "password can not be empty";
                        return null;
                      },
                      type: TextInputType.visiblePassword,
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopLoginLoadingState,
                      builder: (context) => sharedMaterialButton(
                          pressed: () {
                            if (formKey.currentState.validate()) {
                              cubit.login(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          txt: "Login",
                          isUppercase: true,
                          radius: 20,
                          background: colorApp),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don\’t Have An Account ? "),
                        sharedTextButton(
                            onPress: () {
                              navigateAndReplace(
                                  context: context,
                                  screen: ShopRegisterScreen());
                            },
                            text: "REGISTER NOW"),


                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          if (state.shopLoginModel.status) {
            CashedHelper.setData(key: 'token', value: state.shopLoginModel.data.token)
            .then((value){
              token = state.shopLoginModel.data.token;
              navigateAndReplace(context: context, screen: ShopHome());
            });

          } else {
            showToast(state.shopLoginModel.message, Colors.red , context);
          }
        }
      }),
    );
  }
}
