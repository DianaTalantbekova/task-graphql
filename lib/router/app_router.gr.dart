// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../screens/character_info_screen.dart' as _i2;
import '../screens/characters_screen.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    CharactersRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.CharactersScreen());
    },
    CharacterInfoRoute.name: (routeData) {
      final args = routeData.argsAs<CharacterInfoRouteArgs>();
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.CharacterInfoScreen(
              key: args.key,
              image: args.image,
              name: args.name,
              isAlive: args.isAlive,
              origin: args.origin,
              gender: args.gender,
              race: args.race,
              location: args.location));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(CharactersRoute.name, path: '/'),
        _i3.RouteConfig(CharacterInfoRoute.name, path: '/character-info-screen')
      ];
}

/// generated route for
/// [_i1.CharactersScreen]
class CharactersRoute extends _i3.PageRouteInfo<void> {
  const CharactersRoute() : super(CharactersRoute.name, path: '/');

  static const String name = 'CharactersRoute';
}

/// generated route for
/// [_i2.CharacterInfoScreen]
class CharacterInfoRoute extends _i3.PageRouteInfo<CharacterInfoRouteArgs> {
  CharacterInfoRoute(
      {_i4.Key? key,
      required String image,
      required String name,
      required String isAlive,
      required String origin,
      required String gender,
      required String race,
      required String location})
      : super(CharacterInfoRoute.name,
            path: '/character-info-screen',
            args: CharacterInfoRouteArgs(
                key: key,
                image: image,
                name: name,
                isAlive: isAlive,
                origin: origin,
                gender: gender,
                race: race,
                location: location));

  static const String name = 'CharacterInfoRoute';
}

class CharacterInfoRouteArgs {
  const CharacterInfoRouteArgs(
      {this.key,
      required this.image,
      required this.name,
      required this.isAlive,
      required this.origin,
      required this.gender,
      required this.race,
      required this.location});

  final _i4.Key? key;

  final String image;

  final String name;

  final String isAlive;

  final String origin;

  final String gender;

  final String race;

  final String location;

  @override
  String toString() {
    return 'CharacterInfoRouteArgs{key: $key, image: $image, name: $name, isAlive: $isAlive, origin: $origin, gender: $gender, race: $race, location: $location}';
  }
}
