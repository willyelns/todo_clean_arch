import 'package:flutter/material.dart';

import 'features/todo/presentation/pages/home_page_bloc.dart';
import 'features/todo/presentation/pages/mobx/add_task_page.dart';
import 'features/todo/presentation/pages/mobx/home_page_mobx.dart';

final routes = <String, Widget Function(BuildContext)>{
  '/': (BuildContext context) => HomePageMobx(),
  'home_mobx': (BuildContext context) => HomePageMobx(),
  'home_bloc': (BuildContext context) =>
      HomePageBloc(title: 'To do list - Bloc'),
  'add_task_mobx': (BuildContext context) => AddTaskPageMobx(),
};
