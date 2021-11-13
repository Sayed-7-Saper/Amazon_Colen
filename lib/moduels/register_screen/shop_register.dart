import 'package:amazon_colen/layout/shop_home_layout.dart';
import 'package:amazon_colen/moduels/register_screen/cubit2/register_cubit.dart';
import 'package:amazon_colen/moduels/register_screen/cubit2/register_state.dart';
import 'package:amazon_colen/shard/component/components.dart';
import 'package:amazon_colen/shard/component/conestance.dart';
import 'package:amazon_colen/shard/network/local/cach_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state){
          if(state is ShopRegisterSuccessState)
          {
            if(state.registerModel.status ){
              showToast(text: state.registerModel.message, state: ToastStates.SUCCESS);
              CacheHelper.saveData(
                  key: "token",
                  value: state.registerModel.data.token).
              then((value) {
                token = state.registerModel.data.token;

                navigateAndFinish(context, ShopHomeLayout());
              });

            }else{
              showToast(text: state.registerModel.message, state: ToastStates.ERROR);

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
                        Text("REGISTER",style:Theme.of(context).textTheme.headline5,),
                        SizedBox(height: 10,),
                        Text("Login now to browse our hot offer",style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: ( String value){
                            if(value.isEmpty )
                            {
                              return "please enter your Name ";
                            }
                          },
                          label: "Enter User Name",
                          prefix: Icons.person,
                        ),

                        SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: ( String value){
                            if(value.isEmpty )
                            {
                              return "please enter your Phone ";
                            }
                          },
                          label: "Enter Phone",
                          prefix: Icons.phone,
                        ),

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
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            validate: (String value){
                              if (value.isEmpty){
                                return "enter your password";
                              }
                            },
                            label: "enter password",
                            prefix: Icons.lock,
                            suffix: ShopRegisterCubit.get(context).suffixIcon,
                            suffixPressed: (){
                              ShopRegisterCubit.get(context).isChangePasswordVisibility();
                            },
                            onSubmit: (value){

                            }
                        ),
                        SizedBox(height: 25,),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context){
                            return defaultButton(
                              function: (){
                                if(formKey.currentState.validate()){
                                  ShopRegisterCubit.get(context).userRegister
                                    (
                                      name: nameController.text,
                                      phone: phoneController.text,
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
