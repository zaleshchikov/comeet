part of 'card_bloc.dart';

@immutable
 class CardState {
 List<User> cards;
 bool isLoading;

 CardState(this.cards, {this.isLoading = false});
}

