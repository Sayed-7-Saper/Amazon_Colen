import 'package:amazon_colen/model/changeFavorites_model.dart';
import 'package:amazon_colen/model/home_model.dart';
import 'package:amazon_colen/model/login_model.dart';

abstract class ShopStates{}
class ShopInitialStates extends ShopStates {}
class ChangeBottomNavigationBarStates extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{
  /* HomeModel homeModel;
   ShopSuccessHomeDataState(this.homeModel);*/
}
class ShopErrorHomeDataState extends ShopStates{
  final String error;
  ShopErrorHomeDataState(this.error);
}
class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}
class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
   final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates {
  final String error;

  ShopErrorChangeFavoritesState(this.error);

}
class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel userModel;
  ShopSuccessUserDataState(this.userModel);
}
class ShopErrorUserDataState extends ShopStates {}
class ShopUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final ShopLoginModel userModel;
  ShopSuccessUpdateUserDataState(this.userModel);
}
class ShopErrorUpdateUserDataState extends ShopStates {}

