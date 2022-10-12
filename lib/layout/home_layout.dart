import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modulus/search/search.dart';
import '../shared/components/components.dart';
import '../shared/cubit/news_cubit/cubit.dart';
import '../shared/cubit/news_cubit/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: () async {
                  cubit.changeAppMode();
                },
                icon: Icon(
                  Icons.dark_mode,
                ),
              ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.items,
            onTap: (value) {
              cubit.changeIndex(value);
            },
          ),
        );
      },
    );
  }
}
