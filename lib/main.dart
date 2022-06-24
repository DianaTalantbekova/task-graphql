import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_task2/router/app_router.gr.dart';

void main() async {
  await Hive.initFlutter();
  final HttpLink httpLink = HttpLink('https://rickandmortyapi.com/graphql');
  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(
        store: HiveStore(await Hive.openBox('openBox')),
      ),
    ),
  );

  var app = GraphQLProvider(
    client: client,
    child: MyApp(),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp.router(
            routeInformationParser: appRouter.defaultRouteParser(),
            routerDelegate: appRouter.delegate());
      },
    );
  }
}
