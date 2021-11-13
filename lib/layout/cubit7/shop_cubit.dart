import 'package:amazon_colen/model/categories_model.dart';
import 'package:amazon_colen/model/changeFavorites_model.dart';
import 'package:amazon_colen/model/favortites_model.dart';
import 'package:amazon_colen/model/home_model.dart';
import 'package:amazon_colen/model/login_model.dart';
import 'package:amazon_colen/moduels/screens_app/cateogires.dart';
import 'package:amazon_colen/moduels/screens_app/favorits.dart';
import 'package:amazon_colen/moduels/screens_app/prodact.dart';
import 'package:amazon_colen/moduels/screens_app/setting.dart';
import 'package:amazon_colen/shard/component/conestance.dart';
import 'package:amazon_colen/shard/network/end_points.dart';
import 'package:amazon_colen/shard/network/remot/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:amazon_colen/layout/cubit7/shop_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class  ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialStates());
  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndexPage = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),

  ];

  void changeBottom(int index){
    currentIndexPage = index ;
    emit(ChangeBottomNavigationBarStates());
  }
  HomeModel homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      //print (value.data);
      homeModel = HomeModel.fromJson(value.data);
     // print( 'Strings:  ${homeModel.data.banners[0].image} ');


      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
     // print(value.data);
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }
  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId){
    favorites[productId] = !favorites[productId];

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data:{
        'product_id':productId,
      },
      token: token,
    ).then((value){
      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }

      changeFavoritesModel= ChangeFavoritesModel.fromJson(value.data);
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error){
      //favorites [productId] = !favorites[productId];
      emit(ShopErrorChangeFavoritesState(error.toString()));

    });

  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.formJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
  @required String name,
  @required String phone,
  @required String email,
   String password,

   }) {
    emit(ShopUpdateUserDataState());

    DioHelper.putData(
      url: UPDATE_PROFILE ,
      token: token,
      data: {
        "name":name,
        "phone":phone,
        "email":email,
        "password":password,
      },
    ).then((value) {
      userModel = ShopLoginModel.formJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopSuccessUpdateUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }




}