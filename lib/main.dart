import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/shared/bloc_observer/bloc_observer.dart';
import 'package:news/shared/cubit/news_cubit/cubit.dart';
import 'package:news/shared/cubit/news_cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import 'layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.isDark});

  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()..changeAppMode(fromShared: isDark) ,
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              titleSpacing: 20.0,
              elevation: 0.0,
              color: Colors.white,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
                size: 30.0,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              elevation: 20.0,
              selectedIconTheme: IconThemeData(
                color: Colors.deepOrange,
              ),
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: HexColor("333739"),
            appBarTheme: AppBarTheme(
              titleSpacing: 20.0,
              elevation: 0.0,
              backgroundColor: HexColor("333739"),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor("333739"),
                statusBarIconBrightness: Brightness.light,
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
                size: 30.0,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: HexColor("333739"),
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              elevation: 20.0,
              selectedIconTheme: IconThemeData(
                color: Colors.deepOrange,
              ),
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          themeMode:
              NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: HomeLayout(),
        ),
      ),
    );
  }
}
