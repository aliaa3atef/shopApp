import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/cubit.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/states.dart';
import 'package:shop_app/layout/shopAppHome/shopHome.dart';
import 'package:shop_app/modules/onBoarding/onBoardingScreen.dart';
import 'package:shop_app/modules/shopLogin/shopLoginScreen.dart';
import 'package:shop_app/shared/bloc_observe/bloc_observe.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashedHelper.dart';
import 'package:shop_app/shared/network/remote/DioHelper.dart';
import 'package:shop_app/shared/styles/colors.dart';

import 'modules/shopLogin/shopLoginCubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashedHelper.init();



  bool onboarding = CashedHelper.saveData(key: 'onBoarding');
  token = CashedHelper.saveData(key: 'token');
  print(token);
  Widget screen ;

  if(onboarding != null )
    {
      if(token != null )  screen = ShopHome();

      else screen = ShopLoginScreen();
    }
  else screen = OnBoardingScreen();

  runApp(MyApp(screen));
}

class MyApp extends StatelessWidget {
  final Widget screen ;

  const MyApp(this.screen);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ShopHomeCubit()..getShopModel()..getCategory()..getFav()..getProfile(),
      child: BlocConsumer<ShopHomeCubit , ShopHomeStates>(
      listener: (context , state){},
      builder: (context , state)=> MaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              bodyText2: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            dividerTheme: DividerThemeData(
              color: colorApp,
              thickness: 1,
            ),
            primarySwatch: colorApp,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: colorApp,
                unselectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                elevation: 50,
                backgroundColor: Colors.white)),
        darkTheme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          dividerTheme: DividerThemeData(
            color: colorApp,
            thickness: 1,
          ),
          primarySwatch: colorApp,
          scaffoldBackgroundColor: HexColor('33312b'),
          appBarTheme: AppBarTheme(
            backgroundColor: HexColor('33312b'),
            elevation: 0,
            actionsIconTheme: IconThemeData(color: colorApp),
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: colorApp,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            elevation: 50,
            backgroundColor: HexColor('33312b'),
          ),
        ),
        themeMode: ThemeMode.light,
        home: screen,
        debugShowCheckedModeBanner: false,
      ),
    ),);
  }
}
