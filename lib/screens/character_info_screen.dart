import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_task2/commons/text_helper.dart';
import 'package:test_task2/commons/theme_helper.dart';
import 'package:test_task2/helpers/get_status_color.dart';
import 'package:test_task2/screens/widgets/titles.dart';

class CharacterInfoScreen extends StatefulWidget {
  final String image;
  final String name;
  final String isAlive;
  final String origin;
  final String gender;
  final String race;
  final String location;

  const CharacterInfoScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.isAlive,
    required this.origin,
    required this.gender,
    required this.race,
    required this.location,
  }) : super(key: key);

  @override
  State<CharacterInfoScreen> createState() => _CharacterInfoScreenState();
}

class _CharacterInfoScreenState extends State<CharacterInfoScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeHelper.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: ThemeHelper.white,
          ),
        ),
      ),
      body: Query(
        options: QueryOptions(document: gql(query)),
        builder: (QueryResult result, {refetch, fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            fit: StackFit.passthrough,
            children: [
              SizedBox(
                width: 375.w,
                height: 218.h,
                child: ClipRRect(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 160,
                left: 130,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 308, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.name,
                      style: TextHelper.fontSize34w400,
                    ),
                    Text(
                      widget.isAlive,
                      style: TextHelper.fontSize10w500.copyWith(
                        color: getStatusColor(widget.isAlive),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, right: 60, left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Titles(title: 'Gender'),
                              Text(
                                widget.gender,
                              ),
                            ],
                          ),
                          SizedBox(width: 80.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Titles(title: 'Species'),
                              Text(
                                widget.race,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, top: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Titles(title: 'Origin'),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 15,
                              ),
                            ],
                          ),
                          Text(widget.origin),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Titles(title: 'Location'),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 15,
                              ),
                            ],
                          ),
                          Text(widget.location),
                        ],
                      ),
                    ),
                    const Divider(height: 60),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
