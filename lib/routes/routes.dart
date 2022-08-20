import 'package:flutter/widgets.dart';

import '../features/todo/presentation/bloc/pages/home_page_bloc.dart';
import '../features/todo/presentation/mobx/pages/add_task_page.dart';
import '../features/todo/presentation/mobx/pages/home_page_mobx.dart';

final routes = <String, WidgetBuilder>{
  '/': (context) => const HomePageMobx(),
  'home_mobx': (context) => const HomePageMobx(),
  'home_bloc': (context) => const HomePageBloc(),
  'add_task_mobx': (context) => const AddTaskPageMobx(),
};
