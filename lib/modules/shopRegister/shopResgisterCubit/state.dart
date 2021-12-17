
import 'package:shop_app/models/userDataLoginModel/user_login_model.dart';



abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopChangeVisibilityState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel shopRegisterModel;

  ShopRegisterSuccessState(this.shopRegisterModel);

}

class ShopRegisterErrorState extends ShopRegisterStates {

  final String error ;

  ShopRegisterErrorState(this.error);

}

