import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/model/base_model.dart';
import 'package:shopping_app/screens/details.dart';
import 'package:shopping_app/utils/constants.dart';

import '../data/app_data.dart';
import '../model/categories_model.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller =
        PageController(initialPage: 2, keepPage: true, viewportFraction: 0.7);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Two Text
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Find your",
                          style: textTheme.headline1,
                          children: [
                            TextSpan(
                              text: " Style",
                              style: textTheme.headline1?.copyWith(
                                color: Colors.orange,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          text: "Be more beautiful with our ",
                          style: TextStyle(
                            color: Color.fromARGB(186, 0, 0, 0),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "suggestions :)",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Categories
              FadeInUp(
                delay: const Duration(milliseconds: 450),
                child: Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: size.width,
                  height: size.height * 0.15,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (ctx, index) {
                        CategoriesModel current = categories[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage(current.imageurl),
                              ),
                              SizedBox(
                                height: size.height * 0.007,
                              ),
                              Text(
                                current.title,
                                style: textTheme.subtitle1,
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),

              ///Body
              FadeInUp(
                duration: Duration(milliseconds: 550),
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  height: size.height * 0.45,
                  width: size.width,
                  child: PageView.builder(
                    controller: _controller,
                    physics: const BouncingScrollPhysics(),
                    itemCount: mainList.length,
                    itemBuilder: (context, index) {
                      BaseModel data = mainList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(
                                data: mainList[index],
                                isCameFromMostPopularPart: false,
                              ),
                            ),
                          );
                        },
                        child: view(index, textTheme, size),
                      );
                    },
                  ),
                ),
              ),

              /// Most Popular Text
              FadeInUp(
                delay: const Duration(milliseconds: 650),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("Most Popular", style: textTheme.headline3),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text("See all", style: textTheme.headline4),
                      ),
                    ],
                  ),
                ),
              ),

              /// Most Popular Content
              FadeInUp(
                duration: Duration(milliseconds: 750),
                child: SizedBox(
                  height: size.height * 0.44,
                  width: size.width,
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: mainList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.61),
                    itemBuilder: (context, index) {
                      BaseModel current = mainList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(
                                data: mainList[index],
                                isCameFromMostPopularPart: false,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Hero(
                              tag: current.imageUrl,
                              child: Container(
                                width: size.width * 0.5,
                                height: size.height * 0.3,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  image: DecorationImage(
                                    image: AssetImage(current.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                      color: Color.fromARGB(61, 0, 0, 0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                current.name,
                                style: textTheme.headline2,
                              ),
                            ),
                            RichText(
                                text: TextSpan(
                                    text: "€",
                                    style: textTheme.subtitle2?.copyWith(
                                      color: primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                  TextSpan(
                                    text: current.price.toString(),
                                    style: textTheme.subtitle2?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ])),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Page View
  Widget view(int index, TextTheme theme, Size size) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double value = 0.0;
          if (_controller.position.haveDimensions) {
            value = index.toDouble() - (_controller.page ?? 0);
            value = (value * 0.05).clamp(-1, 1);
          }
          return Transform.rotate(
            angle: 3.14 * value,
            child: card(size, mainList[index], theme),
          );
        });
  }

  Padding card(Size size, BaseModel data, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Hero(
            tag: data.id,
            child: Container(
              height: size.height * 0.35,
              width: size.width * 0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image: DecorationImage(
                      image: AssetImage(data.imageUrl), fit: BoxFit.cover)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              data.name,
              style: textTheme.headline2,
            ),
          ),
          RichText(
            text: TextSpan(
              text: "€",
              style: textTheme.headline2?.copyWith(
                color: primaryColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: data.price.toString(),
                  style: textTheme.headline2?.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
