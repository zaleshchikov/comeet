part of 'friend_bloc.dart';

@immutable
 class FriendEvent {}

class GetFriends extends FriendEvent{}

class AddFriend extends FriendEvent{
 Friend friend;

 AddFriend(this.friend);
}

class DeleteFriend extends FriendEvent{
 Friend friend;

 DeleteFriend(this.friend);
}