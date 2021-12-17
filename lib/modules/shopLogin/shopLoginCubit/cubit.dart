import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/userDataLoginModel/user_login_model.dart';
import 'package:shop_app/modules/shopLogin/shopLoginCubit/state.dart';
import 'package:shop_app/shared/end_point.dart';
import 'package:shop_app/shared/network/remote/DioHelper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  var suffix = Icons.visibility;


  void changeVisibilityIcon() {

    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility
        : Icons.visibility_off ;

    emit(ShopLogChangeVisibilityIconState());
  }

  ShopLoginModel shopLoginModel ;

  void login({@required String email, @required String password}) {

    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(shopLoginModel));

    }).catchError((error) {

      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

}
