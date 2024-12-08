part of 'friend_bloc.dart';

@immutable
 class FriendState {
 List<Friend> friends;
 bool isLoading;
 FriendState(this.friends, {this.isLoading = false});
}

