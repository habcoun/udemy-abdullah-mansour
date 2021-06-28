import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:structure/modules/business/business-screen.dart';
import 'package:structure/modules/sciences/sciences-screen.dart';
import 'package:structure/modules/sports/sports-screen.dart';
import 'package:structure/shared/network/remote/dio_helper.dart';

part 'newsapp_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> sciences = [];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    SciencesScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Sciences',
    ),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;

    emit(NewsBottomNavState());
  }

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '8c4435312c084c168b826c54686121a8',
      },
    ).then((value) {
      emit(NewsGetBusinessSuccessState());
      business = value.data['articles'];
      print(business.length);
    }).catchError((e) {
      print('error DioHelper getData ' + e.toString());
      emit(NewsGetBusinessErrorState(e.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '8c4435312c084c168b826c54686121a8',
      },
    ).then((value) {
      sports = value.data['articles'];
      print(sports.length);
      emit(NewsGetSportsSuccessState());
    }).catchError((e) {
      print('error DioHelper getData ' + e.toString());
      emit(NewsGetSportsErrorState(e.toString()));
    });
  }

  void getSciences() {
    emit(NewsGetSiencesLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '8c4435312c084c168b826c54686121a8',
      },
    ).then((value) {
      sciences = value.data['articles'];
      print(sciences.length);
      emit(NewsGetSciencesSuccessState());
    }).catchError((e) {
      print('error DioHelper getData ' + e.toString());
      emit(NewsGetSciencesErrorState(e.toString()));
    });
  }

  String imageDisplay(image) {
    if (image == null) {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png';
    } else {
      return image;
    }
  }
}
