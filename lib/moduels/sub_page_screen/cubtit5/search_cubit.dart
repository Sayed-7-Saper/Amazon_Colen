

import 'package:amazon_colen/model/search_model.dart';
import 'package:amazon_colen/moduels/sub_page_screen/cubtit5/search_state.dart';
import 'package:amazon_colen/shard/component/conestance.dart';
import 'package:amazon_colen/shard/network/end_points.dart';
import 'package:amazon_colen/shard/network/remot/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}