import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ordinary/service/api_service.dart';
import 'package:ordinary/service/route_service.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ordinary/service/state_management/AddPlayer/player_store.dart';
import 'package:ordinary/service/state_management/GetList/char_store.dart';
import 'package:ordinary/service/state_management/Getdata/character_store.dart';
import 'package:ordinary/service/state_management/counter/counter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  final client = GraphQLClient(
    link: HttpLink(ApiService.path),
    cache: GraphQLCache(),
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<CounterData>(create: (_) => CounterData()),
        Provider<CharacterList>(create: (_) => CharacterList(client)),
        Provider<PlayerStore>(
          create: (_) => PlayerStore(),
        ),

        Provider<CharacterStore>(
          create: (_) {
            // Create GraphQL client
            final client = GraphQLClient(
              link: HttpLink('https://rickandmortyapi.com/graphql'),
              cache: GraphQLCache(),
            );

            return CharacterStore(client); // pass the client
          },
        ),

      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        Link link;

        final HttpLink httpLink = HttpLink(
          ApiService.path,
          defaultHeaders: ApiService.header,
        );

        link = httpLink;

        ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
          GraphQLClient(
            link: link,
            queryRequestTimeout: const Duration(seconds: 40),
            cache: GraphQLCache(store: InMemoryStore()),
          ),
        );

        return GraphQLProvider(
          key: ValueKey<int>(Random(100).nextInt(50)),
          client: client,
          child: MaterialApp.router(
            title: 'ordinary',
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
          ),
        );
      },
    );
  }
}
