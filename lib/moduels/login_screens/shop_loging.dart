

import 'package:amazon_colen/layout/shop_home_layout.dart';
import 'package:amazon_colen/model/login_model.dart';
import 'package:amazon_colen/moduels/login_screens/cubit1/login_cubit.dart';
import 'package:amazon_colen/moduels/login_screens/cubit1/login_state.dart';
import 'package:amazon_colen/moduels/register_screen/shop_register.dart';
import 'package:amazon_colen/shard/component/components.dart';
import 'package:amazon_colen/shard/component/conestance.dart';
import 'package:amazon_colen/shard/network/local/cach_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ShopLogin extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey =GlobalKey<FormState>();
  //var cubit =ShopLoginCubit.get(context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state){
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status ){
              showToast(text: state.loginModel.message, state: ToastStates.SUCCESS);
              CacheHelper.saveData(
                  key: "token",
                  value: state.loginModel.data.token).
              then((value) {
                token = state.loginModel.data.token;
                //navigateAndFinish
                navigateAndFinish(context, ShopHomeLayout());
              });

            }else{
              showToast(text: state.loginModel.message, state: ToastStates.ERROR);

            }

          }

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",style:Theme.of(context).textTheme.headline5,),
                        SizedBox(height: 10,),
                        Text("Login now to browse our hot offer",style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: ( String value){
                            if(value.isEmpty )
                            {
                              return "please enter your mail first ";
                            }
                          },
                          label: "Enter email",
                          prefix: Icons.email,
                        ),

                        SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          validate: (String value){
                            if (value.isEmpty){
                              return "enter your password";
                            }
                          },
                          label: "enter password",
                          prefix: Icons.lock,
                          suffix: ShopLoginCubit.get(context).suffixIcon,
                            suffixPressed: (){
                              ShopLoginCubit.get(context).isChangePasswordVisibility();
                            },
                          onSubmit: (value){
                            if(formKey.currentState.validate()){
                              ShopLoginCubit.get(context).userLogin
                                (
                                  email: emailController.text,
                                  password: passController.text
                              );
                            }
                          }
                        ),
                        SizedBox(height: 25,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                            builder: (context){
                            return defaultButton(
                              function: (){
                                if(formKey.currentState.validate()){
                                  ShopLoginCubit.get(context).userLogin
                                    (
                                      email: emailController.text,
                                      password: passController.text
                                  );
                                }

                              },
                              text: "login",isUpperCase: true,);
                            },
                            fallback: (context){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                            },

                        ),
                        SizedBox(height: 20,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\'t have an account ?"),
                            TextButton(onPressed: (){
                              navigateTo(context, RegisterScreen());
                            },
                              child: Text("REGISTER"),),
                          ],
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

    ),

    );
  }
}
