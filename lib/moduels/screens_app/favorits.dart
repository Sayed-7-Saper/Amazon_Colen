import 'package:amazon_colen/layout/cubit7/shop_cubit.dart';
import 'package:amazon_colen/layout/cubit7/shop_states.dart';
import 'package:amazon_colen/shard/component/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildListProduct(
                    ShopCubit.get(context).favoritesModel.data.data[index].product,
                    context,
                ),
            separatorBuilder: (context, index) => Divider(),
            itemCount:
            ShopCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
