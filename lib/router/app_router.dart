import 'package:auto_route/annotations.dart';
import 'package:test_task2/screens/character_info_screen.dart';
import 'package:test_task2/screens/characters_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: [
    MaterialRoute(page: CharactersScreen, initial: true),
    MaterialRoute(page: CharacterInfoScreen),
  ],
)
class $AppRouter {}
