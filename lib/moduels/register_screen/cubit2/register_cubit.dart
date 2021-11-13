import 'package:amazon_colen/model/login_model.dart';
import 'package:amazon_colen/moduels/register_screen/cubit2/register_state.dart';
import 'package:amazon_colen/shard/network/end_points.dart';
import 'package:amazon_colen/shard/network/remot/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit():super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  void userRegister({
    @required String name,
    @required String phone,
    @required String email,
    @required  String password,

  }){
    ShopLoginModel loginModel ;
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        "name":name,
        "phone":phone,
        "email":email,
        "password":password,
      },
    ).then((value){
     // print(value.data);
      loginModel = ShopLoginModel.formJson(value.data);
      //print(loginModel.status);
      emit(ShopRegisterSuccessState(loginModel));

    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });

  }

  IconData suffixIcon = Icons.visibility;
  bool isPassword = true;
  void isChangePasswordVisibility(){
    isPassword = !isPassword ;
    suffixIcon = isPassword ?Icons.visibility:Icons.visibility_off_outlined;
    emit(ShopRegisterChangeIcon());
  }
}