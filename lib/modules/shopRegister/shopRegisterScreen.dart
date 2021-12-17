import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppHome/shopHome.dart';
import 'package:shop_app/modules/shopRegister/shopResgisterCubit/cubit.dart';
import 'package:shop_app/modules/shopRegister/shopResgisterCubit/state.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashedHelper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        builder: (context, state) {
          var nameController = TextEditingController();
          var emailController = TextEditingController();
          var passwordController = TextEditingController();
          var phoneController = TextEditingController();

          var formKey = GlobalKey<FormState>();
          var cubit = ShopRegisterCubit.get(context);

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
                          'REGISTER',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'REGISTER To See Our exclusive Sales ',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        sharedTextFormField(
                          iconColor: colorApp,
                          controller: nameController,
                          prefixIcon: Icons.person,
                          text: "User Name",
                          validate: (String value) {
                            if (value.isEmpty) return "User Name can not be empty";
                            return null;
                          },
                          type: TextInputType.name,
                        ),
                        SizedBox(
                          height: 15,
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
                          suffixPressed: ()=> cubit.changeIcon(),
                          text: "Password",
                          validate: (String value) {
                            if (value.isEmpty) return "password can not be empty";
                            return null;
                          },
                          type: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        sharedTextFormField(
                          iconColor: colorApp,
                          controller: phoneController,
                          prefixIcon: Icons.phone,
                          text: "Phone",
                          validate: (String value) {
                            if (value.isEmpty) return "Phone can not be empty";
                            return null;
                          },
                          type: TextInputType.phone,
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => sharedMaterialButton(
                              pressed: () {
                                if (formKey.currentState.validate()) {
                                  cubit.register(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              txt: "Register",
                              isUppercase: true,
                              radius: 20,
                              background: colorApp),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          );
        },
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.shopRegisterModel.status) {
              CashedHelper.setData(
                      key: 'token', value: state.shopRegisterModel.data.token)
                  .then((value) {
                token = state.shopRegisterModel.data.token;
                navigateAndReplace(context: context, screen: ShopHome());
              });
            } else {
              showToast(state.shopRegisterModel.message, Colors.red, context);
            }
          }
        },
      ),
    );
  }
}
