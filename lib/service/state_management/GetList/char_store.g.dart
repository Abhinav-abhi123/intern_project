// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'char_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CharacterList on _CharacterList, Store {
  late final _$charactersAtom = Atom(
    name: '_CharacterList.characters',
    context: context,
  );

  @override
  ObservableList<Result> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(ObservableList<Result> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_CharacterList.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$currentPageAtom = Atom(
    name: '_CharacterList.currentPage',
    context: context,
  );

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$hasNextPageAtom = Atom(
    name: '_CharacterList.hasNextPage',
    context: context,
  );

  @override
  bool get hasNextPage {
    _$hasNextPageAtom.reportRead();
    return super.hasNextPage;
  }

  @override
  set hasNextPage(bool value) {
    _$hasNextPageAtom.reportWrite(value, super.hasNextPage, () {
      super.hasNextPage = value;
    });
  }

  late final _$isSearchModeAtom = Atom(
    name: '_CharacterList.isSearchMode',
    context: context,
  );

  @override
  bool get isSearchMode {
    _$isSearchModeAtom.reportRead();
    return super.isSearchMode;
  }

  @override
  set isSearchMode(bool value) {
    _$isSearchModeAtom.reportWrite(value, super.isSearchMode, () {
      super.isSearchMode = value;
    });
  }

  late final _$searchResultsAtom = Atom(
    name: '_CharacterList.searchResults',
    context: context,
  );

  @override
  ObservableList<Result> get searchResults {
    _$searchResultsAtom.reportRead();
    return super.searchResults;
  }

  @override
  set searchResults(ObservableList<Result> value) {
    _$searchResultsAtom.reportWrite(value, super.searchResults, () {
      super.searchResults = value;
    });
  }

  late final _$searchPageAtom = Atom(
    name: '_CharacterList.searchPage',
    context: context,
  );

  @override
  int get searchPage {
    _$searchPageAtom.reportRead();
    return super.searchPage;
  }

  @override
  set searchPage(int value) {
    _$searchPageAtom.reportWrite(value, super.searchPage, () {
      super.searchPage = value;
    });
  }

  late final _$hasSearchNextPageAtom = Atom(
    name: '_CharacterList.hasSearchNextPage',
    context: context,
  );

  @override
  bool get hasSearchNextPage {
    _$hasSearchNextPageAtom.reportRead();
    return super.hasSearchNextPage;
  }

  @override
  set hasSearchNextPage(bool value) {
    _$hasSearchNextPageAtom.reportWrite(value, super.hasSearchNextPage, () {
      super.hasSearchNextPage = value;
    });
  }

  late final _$fetchCharactersAsyncAction = AsyncAction(
    '_CharacterList.fetchCharacters',
    context: context,
  );

  @override
  Future<void> fetchCharacters() {
    return _$fetchCharactersAsyncAction.run(() => super.fetchCharacters());
  }

  late final _$refreshCharactersAsyncAction = AsyncAction(
    '_CharacterList.refreshCharacters',
    context: context,
  );

  @override
  Future<void> refreshCharacters() {
    return _$refreshCharactersAsyncAction.run(() => super.refreshCharacters());
  }

  late final _$searchCharactersAsyncAction = AsyncAction(
    '_CharacterList.searchCharacters',
    context: context,
  );

  @override
  Future<void> searchCharacters(String name, {bool reset = false}) {
    return _$searchCharactersAsyncAction.run(
      () => super.searchCharacters(name, reset: reset),
    );
  }

  late final _$_CharacterListActionController = ActionController(
    name: '_CharacterList',
    context: context,
  );

  @override
  void resetStore() {
    final _$actionInfo = _$_CharacterListActionController.startAction(
      name: '_CharacterList.resetStore',
    );
    try {
      return super.resetStore();
    } finally {
      _$_CharacterListActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchCharactersDebounced(String name) {
    final _$actionInfo = _$_CharacterListActionController.startAction(
      name: '_CharacterList.searchCharactersDebounced',
    );
    try {
      return super.searchCharactersDebounced(name);
    } finally {
      _$_CharacterListActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
characters: ${characters},
isLoading: ${isLoading},
currentPage: ${currentPage},
hasNextPage: ${hasNextPage},
isSearchMode: ${isSearchMode},
searchResults: ${searchResults},
searchPage: ${searchPage},
hasSearchNextPage: ${hasSearchNextPage}
    ''';
  }
}
