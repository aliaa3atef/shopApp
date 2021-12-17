import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/userDataLoginModel/user_login_model.dart';
import 'package:shop_app/modules/shopRegister/shopResgisterCubit/state.dart';
import 'package:shop_app/shared/end_point.dart';
import 'package:shop_app/shared/network/remote/DioHelper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  var suffix =  Icons.visibility;


  void changeIcon() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility
        : Icons.visibility_off;

    emit(ShopChangeVisibilityState());
  }

  ShopLoginModel shopRegisterModel;

  void register({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      shopRegisterModel = ShopLoginModel.fromJson(value.data);
      print(shopRegisterModel.status);
      emit(ShopRegisterSuccessState(shopRegisterModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
