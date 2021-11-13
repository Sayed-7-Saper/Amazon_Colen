import 'package:amazon_colen/layout/cubit7/shop_cubit.dart';
import 'package:amazon_colen/layout/shop_home_layout.dart';
import 'package:amazon_colen/moduels/login_screens/shop_loging.dart';
import 'package:amazon_colen/moduels/onbordeing_screen/on_bording_page.dart';
import 'package:amazon_colen/shard/blocOfserver.dart';
import 'package:amazon_colen/shard/component/conestance.dart';
import 'package:amazon_colen/shard/network/local/cach_helper.dart';
import 'package:amazon_colen/shard/network/remot/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async {
  // to insur to loding all data and statr app its imporet besose main is async
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token');
  Widget widget ;
   if(onBoarding != null){
     if(token != null )  widget = ShopHomeLayout();
     else widget = ShopLogin();
   }else{
     widget = OnBoardingScreen();
   }

  print("value board+${onBoarding}");
  // used  bloc to  keep state screen  and tranport between layout
  Bloc.observer = MyBlocObserver();
  runApp(
      MyApp(
        startWidget: widget,
   ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget startWidget;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:[
      BlocProvider(
        create: (BuildContext context )=>
        ShopCubit()
          ..getHomeData()
          ..getCategories()
          ..getFavorites()
          ..getUserData(),
      ),

    ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            appBarTheme: AppBarTheme(color: Colors.white,elevation: 0.0),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.blueAccent,
              backgroundColor: Colors.blueGrey,
              unselectedItemColor: Colors.white,
            ),


          ),
          home: startWidget ,
        ),
    );
  }
}

