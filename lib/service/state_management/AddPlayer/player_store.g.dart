// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlayerStore on _PlayerStore, Store {
  Computed<List<Player>>? _$savedPlayersComputed;

  @override
  List<Player> get savedPlayers =>
      (_$savedPlayersComputed ??= Computed<List<Player>>(
            () => super.savedPlayers,
            name: '_PlayerStore.savedPlayers',
          ))
          .value;

  late final _$playersAtom = Atom(
    name: '_PlayerStore.players',
    context: context,
  );

  @override
  ObservableList<Player> get players {
    _$playersAtom.reportRead();
    return super.players;
  }

  @override
  set players(ObservableList<Player> value) {
    _$playersAtom.reportWrite(value, super.players, () {
      super.players = value;
    });
  }

  late final _$loadPlayersAsyncAction = AsyncAction(
    '_PlayerStore.loadPlayers',
    context: context,
  );

  @override
  Future<void> loadPlayers() {
    return _$loadPlayersAsyncAction.run(() => super.loadPlayers());
  }

  late final _$addPlayerAsyncAction = AsyncAction(
    '_PlayerStore.addPlayer',
    context: context,
  );

  @override
  Future<void> addPlayer(Player player) {
    return _$addPlayerAsyncAction.run(() => super.addPlayer(player));
  }

  late final _$updatePlayerAsyncAction = AsyncAction(
    '_PlayerStore.updatePlayer',
    context: context,
  );

  @override
  Future<void> updatePlayer(Player player) {
    return _$updatePlayerAsyncAction.run(() => super.updatePlayer(player));
  }

  late final _$deletePlayerAsyncAction = AsyncAction(
    '_PlayerStore.deletePlayer',
    context: context,
  );

  @override
  Future<void> deletePlayer(Player player) {
    return _$deletePlayerAsyncAction.run(() => super.deletePlayer(player));
  }

  late final _$toggleSavedAsyncAction = AsyncAction(
    '_PlayerStore.toggleSaved',
    context: context,
  );

  @override
  Future<void> toggleSaved(Player player) {
    return _$toggleSavedAsyncAction.run(() => super.toggleSaved(player));
  }

  @override
  String toString() {
    return '''
players: ${players},
savedPlayers: ${savedPlayers}
    ''';
  }
}
