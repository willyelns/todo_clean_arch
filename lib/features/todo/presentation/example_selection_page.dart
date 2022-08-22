import 'package:flutter/material.dart';
import '../../../routes/app_pages.dart';

class ExampleSelectionPage extends StatelessWidget {
  const ExampleSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To do Example'),
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                  onPressed: () => _toMobx(context),
                  child: const Text('Mobx Example')),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () => _toBloc(context),
                  child: const Text('BLoC Example')),
            ],
          ),
        ));
  }

  void _toMobx(BuildContext context) {
    context.push(AppPages.homeMobx);
  }

  void _toBloc(BuildContext context) {
    context.push(AppPages.homeBloc);
  }
}
