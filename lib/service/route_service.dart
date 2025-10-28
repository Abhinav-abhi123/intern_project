import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ordinary/service/state_management/AddPlayer/player_store.dart';
import 'package:ordinary/views/profile.dart';
import 'package:provider/provider.dart';

import '../model/CharacterDetailScreen.dart';
import '../views/Add_players.dart';
import '../views/Saved_Players.dart';
import '../views/char_details.dart';
import '../views/choose_page.dart';
import '../views/episode_detail_screen.dart';
import '../views/home_screen.dart';
import '../views/splash_screen.dart';
import '../views/char_list.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: SplashScreen.route,
  routes: [
    GoRoute(
      path: SplashScreen.route,
      name: SplashScreen.route,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: CategorySelectionScreen.route,
      name: CategorySelectionScreen.route,
      builder: (context, state) => const CategorySelectionScreen(),
    ),
    GoRoute(
      path: HomeScreen.route,
      name: HomeScreen.route,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: CharacterDetailScreen.route, // dynamic parameter
          name: CharacterDetailScreen.route, // dynamic parameter
          builder: (context, state) {
            // final characterId = state.pathParameters['id']!;
            final id = state.uri.queryParameters['id']!;
            return CharacterDetailScreen(characterId: id);
          },
        ),
        GoRoute(
          path: EpisodeDetailScreen.route,
          name: EpisodeDetailScreen.route,
          builder: (context, state) {
            final episode = state.extra as Episode;
            return EpisodeDetailScreen(episode: episode);
          },
        ),
        GoRoute(
          path: ViewmorePage.route,
          name: ViewmorePage.route,
          builder: (context, state) => const ViewmorePage(),
        ),
        GoRoute(
          path: AddPlayers.route,
          name: AddPlayers.route,
          builder: (context, state) => const AddPlayers(),

        ),
        GoRoute(
          path: SavedPlayersScreen.route,
          name: SavedPlayersScreen.route,
          builder: (context, state) {
            final playerStore = Provider.of<PlayerStore>(context, listen: false);
            return SavedPlayersScreen(playerStore: playerStore);
          },
        ),
        GoRoute(
          path: Profile.route,
          name: Profile.route,
          builder: (context, state) => const Profile(),

        ),

      ],
    ),
  ],
);
