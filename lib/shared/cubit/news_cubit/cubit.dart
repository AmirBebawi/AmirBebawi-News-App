import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/cubit/news_cubit/states.dart';

import '../../../modulus/business/business_screen.dart';
import '../../../modulus/science/science_screen.dart';
import '../../../modulus/sports/sports_screen.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];
  List<Widget> screen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<String> titles = [
    'Business',
    'Sports',
    'Science',
  ];

  void changeIndex(index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'e4160235dcc14342aebd723c400337de',
      },
    ).then((value) {
      if (kDebugMode) {
        print(value.data.toString());
      }
      business = value.data['articles'];
      if (kDebugMode) {
        print(business.length);
      }
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'e4160235dcc14342aebd723c400337de',
        },
      ).then((value) {
        if (kDebugMode) {
          print(value.data.toString());
        }
        sports = value.data['articles'];
        if (kDebugMode) {
          print(sports.length);
        }
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'e4160235dcc14342aebd723c400337de',
        },
      ).then((value) {
        if (kDebugMode) {
          print(value.data.toString());
        }
        science = value.data['articles'];
        if (kDebugMode) {
          print(science.length);
        }
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isDark = false;

  void changeAppMode({bool ? fromShared})
  {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
  List<dynamic> search = [];

  void getSearch(String data) {
    emit(NewsGetSearchLoadingState());
    //search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': data,
        'apiKey': 'e4160235dcc14342aebd723c400337de',
      },
    ).then((value) {
      search = value.data['articles'];
      if (kDebugMode) {
        print(search.length);
      }
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}