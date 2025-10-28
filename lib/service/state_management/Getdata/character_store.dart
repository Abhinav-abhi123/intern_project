import 'package:mobx/mobx.dart';
import 'package:graphql_flutter/graphql_flutter.dart' hide Store;
import '../../../model/CharacterDetailScreen.dart';
import '../../api_service.dart';

part 'character_store.g.dart';

class CharacterStore = _CharacterStore with _$CharacterStore;

abstract class _CharacterStore with Store {
  final GraphQLClient client;

  _CharacterStore(this.client);

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  Character? character;

  @action
  Future<void> fetchCharacter(String id) async {
    isLoading = true;
    errorMessage = null;

    try {
      final result = await client.query(
        QueryOptions(
          document: gql(ApiService.getCharacterById),
          variables: {'id': id},
        ),
      );


      if (result.hasException || result.data!['character']==null ) {
        errorMessage = result.exception.toString();
      } else {
        final data = result.data!;
        final characterDetail = CharacterDetailModel.fromJson(data);
        character = characterDetail.character;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
