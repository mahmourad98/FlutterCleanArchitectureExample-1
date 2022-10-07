import 'package:flutter/material.dart';

import 'app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp() : super(key: null,);

  @override
  Widget build(BuildContext context,) {
    return MaterialApp(
      builder: (BuildContext buildContext, Widget? child,) {
        return SafeArea(
          child: child!,
        );
      },
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context,).size.width,
                height: MediaQuery.of(context,).size.height - MediaQuery.of(context,).viewInsets.top,
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

