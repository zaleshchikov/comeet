part of 'card_bloc.dart';

@immutable
 class CardEvent {

}

class GetCards extends CardEvent{}

class SearchCard extends CardEvent{
 String pattern;

 SearchCard(this.pattern);
}

class AddFriend extends CardEvent{
 String id;

 AddFriend(this.id);
}

class DeleteFriend extends CardEvent{
 String id;

 DeleteFriend(this.id);
}