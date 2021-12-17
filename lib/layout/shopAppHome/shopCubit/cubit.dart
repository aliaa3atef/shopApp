import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/states.dart';
import 'package:shop_app/models/addOrRemoveFav/editFav.dart';
import 'package:shop_app/models/categoryModel/categoryModel.dart';
import 'package:shop_app/models/getFavourites/getFavModel.dart';
import 'package:shop_app/models/homeModel/homeModel.dart';
import 'package:shop_app/models/userDataLoginModel/user_login_model.dart';
import 'package:shop_app/modules/categoriesScreen/categoriesScreen.dart';
import 'package:shop_app/modules/favouritesScreen/favouritesScreen.dart';
import 'package:shop_app/modules/productsScreen/productsScreen.dart';
import 'package:shop_app/modules/settingsScreen/settingsScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/end_point.dart';
import 'package:shop_app/shared/network/remote/DioHelper.dart';

class ShopHomeCubit extends Cubit<ShopHomeStates> {
  ShopHomeCubit() : super(ShopHomeInitialState());

  static ShopHomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingScreen(),
  ];

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(ShopHomeChangeBottomNavIndexState());
  }

  HomeModel homeModel;
  Map<int, bool> fav = {};

  void getShopModel() {
    emit(ShopHomeHomeDataLoadingState());

    DioHelper.getDate(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        fav.addAll({
          element.id: element.inFavourites,
        });
      });
      print(fav);

      emit(ShopHomeHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeHomeDataErrorState(error.toString()));
    });
  }

  CategoryModel categoryModel;

  void getCategory() {
    emit(ShopHomeCategoryLoadingState());

    DioHelper.getDate(url: Category).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopHomeCategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeCategoryErrorState(error.toString()));
    });
  }

  FavouritesModel favouritesModel;

  void getFav() {
    emit(ShopHomeGetFavLoadingState());

    DioHelper.getDate(url: FAVOURITES, token: token).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(ShopHomeGetFavSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeGetFavErrorState(error.toString()));
    });
  }

  EditFavourites editFavourites;

  void changeFav({@required int prodID}) {
    fav[prodID] = !fav[prodID];
    emit(ShopHomeChangeFavIconSuccessState());

    DioHelper.postData(
            url: FAVOURITES, data: {'product_id': prodID}, token: token)
        .then((value) {
      editFavourites = EditFavourites.fromJson(value.data);
      if (!editFavourites.status) {
        fav[prodID] = !fav[prodID];
      } else
        getFav();

      print(value.data);
      emit(ShopHomeChangeFavSuccessState(editFavourites));
    }).catchError((error) {
      emit(ShopHomeChangeFavErrorState(error.toString()));
    });
  }

  ShopLoginModel profile;

  void getProfile() {
    emit(ShopHomeGetProfileLoadingState());

    DioHelper.getDate(url: PROFILE, token: token).then((value) {
      profile = ShopLoginModel.fromJson(value.data);
      print(profile.data.name);
      emit(ShopHomeGetProfileSuccessState(profile));
    }).catchError((error) {
      print(error.toString());

      emit(ShopHomeGetProfileErrorState(error.toString()));
    });
  }

  ShopLoginModel userDate;
  void updateUserDate({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopHomeHomeUpdateDataLoadingState());

    DioHelper.putData(url: UPDATE_PROFILE,
        token: token,
        data: {
      'name': name,
      'email' : email,
      'phone' : phone,
    })
        .then((value) {

      userDate = ShopLoginModel.fromJson(value.data);
      getProfile();
      print(userDate.message);

      emit(ShopHomeHomeUpdateDataSuccessState());

    }).catchError((error) {

      print(error.toString());

      emit(ShopHomeHomeUpdateDataErrorState(error.toString()));
    });
  }
}
