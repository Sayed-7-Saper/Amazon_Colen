import 'package:amazon_colen/model/login_model.dart';
import 'package:amazon_colen/moduels/login_screens/cubit1/login_state.dart';
import 'package:amazon_colen/shard/network/end_points.dart';
import 'package:amazon_colen/shard/network/remot/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit():super(ShopLoginInitialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  void userLogin({
  @required String email,
  @required  String password,

  }){
    ShopLoginModel loginModel ;
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          "email":email,
          "password":password,
        },
    ).then((value){
      print(value.data);
      loginModel = ShopLoginModel.formJson(value.data);
      print(loginModel.status);
      emit(ShopLoginSuccessState(loginModel));

    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });

  }

  IconData suffixIcon = Icons.visibility;
  bool isPassword = true;
  void isChangePasswordVisibility(){
    isPassword = !isPassword ;
    suffixIcon = isPassword ?Icons.visibility:Icons.visibility_off_outlined;
    emit(ShopLoginChangeIcon());
  }
}