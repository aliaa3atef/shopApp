import 'package:shop_app/models/addOrRemoveFav/editFav.dart';
import 'package:shop_app/models/userDataLoginModel/user_login_model.dart';

abstract class ShopHomeStates {}

class ShopHomeInitialState extends ShopHomeStates {}

class ShopHomeChangeBottomNavIndexState extends ShopHomeStates {}

class ShopHomeHomeDataLoadingState extends ShopHomeStates {}

class ShopHomeHomeDataSuccessState extends ShopHomeStates {}

class ShopHomeHomeDataErrorState extends ShopHomeStates {
  final String error;

  ShopHomeHomeDataErrorState(this.error);
}

class ShopHomeCategoryLoadingState extends ShopHomeStates {}

class ShopHomeCategorySuccessState extends ShopHomeStates {}

class ShopHomeCategoryErrorState extends ShopHomeStates {
  final String error;
  ShopHomeCategoryErrorState(this.error);
}

class ShopHomeGetFavLoadingState extends ShopHomeStates {}

class ShopHomeGetFavSuccessState extends ShopHomeStates {}

class ShopHomeGetFavErrorState extends ShopHomeStates {
  final String error;
  ShopHomeGetFavErrorState(this.error);
}

class ShopHomeChangeFavSuccessState extends ShopHomeStates {
  final EditFavourites editFavourites;

  ShopHomeChangeFavSuccessState(this.editFavourites);

}

class ShopHomeChangeFavErrorState extends ShopHomeStates {
  final String error;
  ShopHomeChangeFavErrorState(this.error);
}

class ShopHomeChangeFavIconSuccessState extends ShopHomeStates {}

class ShopHomeGetProfileLoadingState extends ShopHomeStates {}

class ShopHomeGetProfileSuccessState extends ShopHomeStates {
  final ShopLoginModel profile;

  ShopHomeGetProfileSuccessState(this.profile);

}

class ShopHomeGetProfileErrorState extends ShopHomeStates {
  final String error;
  ShopHomeGetProfileErrorState(this.error);
}

class ShopHomeHomeUpdateDataLoadingState extends ShopHomeStates {}

class ShopHomeHomeUpdateDataSuccessState extends ShopHomeStates {}

class ShopHomeHomeUpdateDataErrorState extends ShopHomeStates {
  final String error;

  ShopHomeHomeUpdateDataErrorState(this.error);
}
