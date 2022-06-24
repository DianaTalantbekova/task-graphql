import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_task2/commons/text_helper.dart';
import 'package:test_task2/commons/theme_helper.dart';
import 'package:test_task2/helpers/get_status_color.dart';
import 'package:test_task2/router/app_router.gr.dart';
import 'package:test_task2/screens/bloc/character_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
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
  late CharacterBloc characterBloc;

  @override

  void initState() {
    characterBloc = CharacterBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CharacterBloc, CharacterState>(
        bloc: characterBloc,
        listener: (context, state) {
        },
        builder: (context, state) {
          // if (state is CharacterLoadedState) {
            return Query(
              options: QueryOptions(
                document: gql(query),
              ),
              builder: (QueryResult result, {refetch, fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final query = result.data?['characters']['results'];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: query.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                context.router.push(
                                  CharacterInfoRoute(
                                    image: query[index]['image'],
                                    name: query[index]['name'],
                                    isAlive: query[index]['status'],
                                    gender: query[index]['gender'],
                                    race: query[index]['species'],
                                    origin: query[index]['origin']['name'],
                                    location: query[index]['location']['name'],
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: 95.h,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                        query[index]['image'],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 18),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            query[index]['status'],
                                            style: TextHelper.fontSize10w500
                                                .copyWith(
                                              color: getStatusColor(
                                                query[index]['status'],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            query[index]['name'],
                                            style: TextHelper.fontSize16w500,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                query[index]['species'] + ', ',
                                                style: TextHelper.fontSize12w400
                                                    .copyWith(
                                                        color:
                                                            ThemeHelper.grey),
                                              ),
                                              Text(
                                                query[index]['gender'],
                                                style: TextHelper.fontSize12w400
                                                    .copyWith(
                                                        color:
                                                            ThemeHelper.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          // }
          // return const SizedBox();
        },
      ),
    );
  }
}
