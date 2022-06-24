import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharacterInitial()) {
    on<CharacterEvent>((event, emit) async {
      if (event is GetCharacterEvent) {
        emit(CharacterLoadingState());
        try {
          String query = '''query{
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
          emit(CharacterLoadedState());
        } catch (e) {
          emit(
            CharacterErrorState(error: 'Error'),
          );
        }
      }
    });
  }
}
