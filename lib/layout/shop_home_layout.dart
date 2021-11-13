import 'package:amazon_colen/layout/cubit7/shop_cubit.dart';
import 'package:amazon_colen/layout/cubit7/shop_states.dart';
import 'package:amazon_colen/moduels/sub_page_screen/search_screen.dart';
import 'package:amazon_colen/shard/component/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopHomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},

        builder: (context ,state){
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("AMZON",style: TextStyle(color: Colors.black),),
              actions: [
                IconButton(icon: Icon(Icons.search,color: Colors.black,), onPressed: (){
                  navigateTo(context, SearchScreen(),);
                })
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndexPage],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.blueGrey,
              unselectedLabelStyle: TextStyle(color: Colors.black),
              selectedLabelStyle: TextStyle(color: Colors.blue),
              onTap: (index){
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndexPage,
              items: [
                BottomNavigationBarItem(icon:Icon(Icons.home,),label: "Home"),
                BottomNavigationBarItem(icon:Icon(Icons.apps,),label: "Categories"),
                BottomNavigationBarItem(icon:Icon(Icons.favorite,),label: "Favorites"),
                BottomNavigationBarItem(icon:Icon(Icons.settings,),label: "Setting"),
              ],

            ),

        );
        },
        );
  }
}
