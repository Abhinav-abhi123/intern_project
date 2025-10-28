// lib/service/state_management/GetList/char_store.dart
import 'package:mobx/mobx.dart';
import 'package:graphql_flutter/graphql_flutter.dart' hide Store;
import '../../../model/Characters.dart';
import '../../api_service.dart';

part 'char_store.g.dart';

class CharacterList = _CharacterList with _$CharacterList;

abstract class _CharacterList with Store {
  final GraphQLClient client;
  _CharacterList(this.client);

  @observable
  ObservableList<Result> characters = ObservableList<Result>();

  @observable
  bool isLoading = false;

  @observable
  int currentPage = 1;

  @observable
  bool hasNextPage = true;

  /// Fetch next page and append results
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

      if (result.hasException || result.data==null) {
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
}
