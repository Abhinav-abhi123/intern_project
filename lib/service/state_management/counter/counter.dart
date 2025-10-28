

// import 'package:graphql_flutter/graphql_flutter.dart' hide Store;
import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class CounterData = CounterBase with _$CounterData;

abstract class CounterBase with Store {

  @observable
  int _counterValue = 0;

  @computed
  int get counterValue => _counterValue;

  @action
  void increment() => _counterValue++;

  @action
  void decrement() => _counterValue--;

}