import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'view/view.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Cooking Calculator',
      home: const RecipeListPage(),
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      == EditPrepPage.routeName => MaterialPageRoute<Prep>(
          builder: (context) {
            final arguments = settings.arguments as EditPrepPageArguments;
            return EditPrepPage(prep: arguments.prep);
          },
          settings: settings,
          fullscreenDialog: true,
        ),
      _ => null,
    };
  }
}
