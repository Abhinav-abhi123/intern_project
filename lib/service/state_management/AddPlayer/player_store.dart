import 'package:mobx/mobx.dart';
import '../../../model/player_model.dart';
import '../../Database/database_helper.dart';

part 'player_store.g.dart';

class PlayerStore = _PlayerStore with _$PlayerStore;

abstract class _PlayerStore with Store {
  final db = DatabaseHelper.instance;

  @observable
  ObservableList<Player> players = ObservableList<Player>();

  @action
  Future<void> loadPlayers() async {
    try {
      final playerList = await db.getPlayers();
      players = ObservableList<Player>.of(playerList);
    } catch (e) {
      print(" Error loading players: $e");
      players.clear();
    }
  }

  @action
  Future<void> addPlayer(Player player) async {
    try {
      final now = DateTime.now().toString();
      final newPlayer = player.copyWith(createdAt: now, updatedAt: now);
      final id = await db.insertPlayer(newPlayer);
      newPlayer.id = id;
      players.add(newPlayer);
    } catch (e) {
      print(" Error adding player: $e");
    }
  }

  @action
  Future<void> updatePlayer(Player player) async {
    try {
      final updated = player.copyWith(updatedAt: DateTime.now().toString());
      await db.updatePlayer(updated);

      final index = players.indexWhere((p) => p.id == player.id);
      if (index != -1) {
        players[index] = updated;
      } else {
        print(" Player not found in list for update (ID: ${player.id})");
      }
    } catch (e) {
      print(" Error updating player: $e");
    }
  }

  @action
  Future<void> deletePlayer(Player player) async {
    try {
      if (player.id != null) {
        await db.deletePlayer(player.id!);
        players.removeWhere((p) => p.id == player.id);
      } else {
        print("Tried to delete a player without an ID");
      }
    } catch (e) {
      print("Error deleting player: $e");
    }
  }

  @action
  Future<void> toggleSaved(Player player) async {
    try {
      final index = players.indexWhere((p) => p.id == player.id);
      if (index != -1) {
        final updatedPlayer = player.copyWith(isSaved: !player.isSaved);
        await db.updatePlayer(updatedPlayer);
        players[index] = updatedPlayer;
      } else {
        print(" Player not found for toggleSaved (ID: ${player.id})");
      }
    } catch (e) {
      print("Error toggling saved state: $e");
    }
  }


  @computed
  List<Player> get savedPlayers => players.where((p) => p.isSaved).toList();


  Future<void> initStore() async {
    try {
      await loadPlayers();
    } catch (e) {
      print(" Error initializing player store: $e");
    }
  }
}
