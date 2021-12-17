import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/cubit.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/states.dart';


class ShopHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit , ShopHomeStates>(
        builder: (context , state){
          var cubit = ShopHomeCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              title: Text("Shop"),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined) , label: "home"),
                BottomNavigationBarItem(icon: Icon(Icons.category_outlined) , label: "Categories"),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_border) , label: "Favourites"),
                BottomNavigationBarItem(icon: Icon(Icons.settings) , label: "Settings"),
              ],

              currentIndex: cubit.currentIndex,
              onTap: (int index){cubit.changeBottomNavIndex(index);},
            ),
          );
        },
        listener: (context , state){}

    );
  }
}
