import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:graphql_flutter/graphql_flutter.dart' hide Store;
import '../../../model/Characters.dart';
import '../../api_service.dart';

part 'char_store.g.dart';

class CharacterList = _CharacterList with _$CharacterList;

abstract class _CharacterList with Store {
  final GraphQLClient client;
  _CharacterList(this.client);

  final _debouncer = _Debouncer(delay: const Duration(milliseconds: 500));

  @observable
  ObservableList<Result> characters = ObservableList<Result>();

  @observable
  bool isLoading = false;

  @observable
  int currentPage = 1;

  @observable
  bool hasNextPage = true;

  @observable
  bool isSearchMode = false;

  @observable
  ObservableList<Result> searchResults = ObservableList<Result>();

  @observable
  int searchPage = 1;

  @observable
  bool hasSearchNextPage = true;

  @action
  Future<void> fetchCharacters() async {
    if (isLoading || !hasNextPage) return;
    isLoading = true;

    try {
      final result = await client.query(
        QueryOptions(
          document: gql(ApiService.getCharacters),
          variables: {"page": currentPage},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException || result.data == null) {
        print("GraphQL Error: ${result.exception}");
        return;
      }

      final data = result.data?['characters'];
      if (data == null) return;

      final models = CharactersModel.fromJson({"characters": data});
      final newItems = models.characters?.results ?? [];

      characters.addAll(newItems);
      hasNextPage = data['info']?['next'] != null;
      currentPage++;

      print('Fetched ${newItems.length}, total ${characters.length}');
    } catch (e) {
      print("Error fetchCharacters: $e");
    } finally {
      isLoading = false;
    }
  }

  @action
  void resetStore() {
    characters.clear();
    currentPage = 1;
    hasNextPage = true;
    isLoading = false;
  }

  @action
  Future<void> refreshCharacters() async {
    resetStore();
    await fetchCharacters();
  }

  @action
  void searchCharactersDebounced(String name) {
    _debouncer.run(name, (latestValue) {
      searchCharacters(latestValue, reset: true);
    });
  }

  @action
  Future<void> searchCharacters(String name, {bool reset = false}) async {
    if (name.isEmpty) {
      isSearchMode = false;
      await refreshCharacters();
      return;
    }

    if (reset) {
      searchResults.clear();
      searchPage = 1;
      hasSearchNextPage = true;
    }

    if (isLoading || !hasSearchNextPage) return;

    isSearchMode = true;
    isLoading = true;

    try {
      final result = await client.query(
        QueryOptions(
          document: gql(ApiService.getCharacters),
          variables: {"name": name, "page": searchPage},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException || result.data == null) {
        print("GraphQL Error (Search): ${result.exception}");
        return;
      }

      final data = result.data?['characters'];
      if (data == null) {
        searchResults.clear();
        return;
      }

      final models = CharactersModel.fromJson({"characters": data});
      final newResults = models.characters?.results ?? [];

      searchResults.addAll(newResults);
      hasSearchNextPage = data['info']?['next'] != null;
      searchPage++;

      print("Search fetched ${newResults.length} results for '$name'");
    } catch (e) {
      print("Error searchCharacters: $e");
    } finally {
      isLoading = false;
    }
  }

  void dispose() {
    _debouncer.dispose();
  }
}

class _Debouncer<T> {
  final Duration delay;
  Timer? _timer;

  _Debouncer({this.delay = const Duration(milliseconds: 500)});

  void run(T value, void Function(T value) action) {
    _timer?.cancel();
    _timer = Timer(delay, () => action(value));
  }

  void dispose() {
    _timer?.cancel();
  }
}
