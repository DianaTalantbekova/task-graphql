part of 'character_bloc.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoadingState extends CharacterState {}

class CharacterLoadedState extends CharacterState {
     final String query = '''query{
  characters{
    results{
      name
      status
      species
      gender
      origin{name}
      location{name}
      image
    }
  }
}''';
}

class CharacterErrorState extends CharacterState {
  final String error;

  CharacterErrorState({required this.error});
}
