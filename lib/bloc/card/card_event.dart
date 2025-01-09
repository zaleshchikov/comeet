part of 'card_bloc.dart';

@immutable
 class CardEvent {

}

class GetCards extends CardEvent{}

class SearchCard extends CardEvent{
 String pattern;

 SearchCard(this.pattern);
}

