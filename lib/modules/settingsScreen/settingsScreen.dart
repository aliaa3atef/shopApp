import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/cubit.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/states.dart';
import 'package:shop_app/modules/shopLogin/shopLoginScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      builder: (context, state) {

        var profile = ShopHomeCubit.get(context).profile;
        nameController.text = profile.data.name;
        emailController.text = profile.data.email;
        phoneController.text = profile.data.phone;


        return ConditionalBuilder(
          condition: ShopHomeCubit.get(context).profile != null,
          builder: (context) {

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopHomeHomeUpdateDataLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    sharedTextFormField(
                      controller: nameController,
                      prefixIcon: Icons.person,
                      iconColor: colorApp,
                      text: "Name",
                      validate: (String value) {
                        if (value.isEmpty) return "Name Must Not Be Empty";
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    sharedTextFormField(
                      controller: emailController,
                      iconColor: colorApp,
                      prefixIcon: Icons.email,
                      text: "Email Address",
                      validate: (String value) {
                        if (value.isEmpty)
                          return "Email Address Must Not Be Empty";
                        return null;
                      },
                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    sharedTextFormField(
                      controller: phoneController,
                      prefixIcon: Icons.phone,
                      iconColor: colorApp,
                      text: "Phone",
                      validate: (String value) {
                        if (value.isEmpty) return "Phone Must Not Be Empty";
                        return null;
                      },
                      type: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    sharedMaterialButton(
                        radius: 10,
                        background: colorApp,
                        pressed: () => signOut(context),
                        txt: "LOGOUT"),
                    SizedBox(
                      height: 20,
                    ),
                    sharedMaterialButton(
                        radius: 10,
                        background: colorApp,
                        pressed: () {
                          if(formKey.currentState.validate())
                            {
                              ShopHomeCubit.get(context).updateUserDate(name : nameController.text,
                                  email : emailController.text, phone : phoneController.text);
                            }
                        },
                        txt: "UPDATE"),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {},
    );
  }
}
