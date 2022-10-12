import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/news_cubit/cubit.dart';
import '../../shared/cubit/news_cubit/states.dart';
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context, state) {},
       builder: (context, state) {
        var list = NewsCubit.get(context).search;
         return Scaffold(
        appBar: AppBar(),
        key: scaffoldKey,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(
                controller: searchController,
                type: TextInputType.text,
                validate: (String ? value) {
                  if (value!.isEmpty) {
                    return 'Search Must Not Be Empty';
                  }
                  else {
                    return null;
                  }
                },
                onChange: (value)
                {
                  NewsCubit.get(context).getSearch(value);
                },
                label: 'Search',
                prefix: Icons.search,
              ),
            ),
            Expanded(child: articleBuilder(list, context,isSearch: true)),
          ],
        ),
      );
       },
    );
  }
}
