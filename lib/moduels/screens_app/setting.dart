
import 'package:amazon_colen/layout/cubit7/shop_cubit.dart';
import 'package:amazon_colen/layout/cubit7/shop_states.dart';
import 'package:amazon_colen/shard/component/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SettingScreen extends StatelessWidget {
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        // notes rebulid stata is to vast
        if(state is ShopSuccessUserDataState ){
          nameController.text = state.userModel.data.name;
          emailController.text =state.userModel.data.email;
          phoneController.text = state.userModel.data.phone;

        }
      },
        builder: (context,state){
        var model = ShopCubit.get(context).userModel ;
        nameController.text = model.data.name;
        emailController.text =model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null ,
          builder: (context) => Form(
            key: formKey,
            child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              // defaultTextFormField
              children: [
                defaultTextFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: ( String value){
                    if(value.isEmpty )
                    {
                      return "please enter your name ";
                    }
                  },
                  label: "User name",
                  prefix: Icons.person,
                ),
                SizedBox(height: 15,),
                defaultTextFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: ( String value){
                    if(value.isEmpty )
                    {
                      return "please enter your mail  ";
                    }
                  },
                  label: "Enter email",
                  prefix: Icons.email,
                ),
                SizedBox(height: 15,),
                defaultTextFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: ( String value){
                    if(value.isEmpty )
                    {
                      return "please enter your phone ";
                    }
                  },
                  label: "Enter phone",
                  prefix: Icons.phone,
                ),
                SizedBox(height: 25,),
                defaultButton(function: (){
                  if(formKey.currentState.validate()){
                    ShopCubit.get(context).updateUserData(
                      name: nameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      //password: pa
                    );
                  }

                }, text: "Update"),
                SizedBox(height: 20,),
                defaultButton(function: (){
                  singOut(context);
                }, text: "Logout"),

              ],

            ),
        ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
        }
    );
  }
}
