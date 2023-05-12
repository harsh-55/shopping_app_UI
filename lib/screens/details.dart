import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/Method/add_to_cart.dart';
import 'package:shopping_app/model/base_model.dart';
import 'package:shopping_app/utils/constants.dart';

import '../utils/reuseable_text.dart';

class Details extends StatefulWidget {
  const Details({
    required this.data,
    super.key,
    required this.isCameFromMostPopularPart,
  });

  final BaseModel data;
  final bool isCameFromMostPopularPart;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  int selectedsize = 3;
  int selectedColor = 2;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    BaseModel current = widget.data;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Product Image
            SizedBox(
              height: size.height * 0.5,
              width: size.width,
              child: Stack(
                children: [
                  ///Top Image
                  Hero(
                    tag: widget.isCameFromMostPopularPart
                        ? current.imageUrl
                        : current.id,
                    child: Container(
                      height: size.height * 0.5,
                      width: size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(current.imageUrl),
                              fit: BoxFit.cover)),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: size.height * 0.12,
                      width: size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: gradient,
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter)),
                    ),
                  )
                ],
              ),
            ),

            /// Product Info
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            current.name,
                            style: textTheme.headline3?.copyWith(fontSize: 23),
                          ),
                          ReuseableText(
                            price: current.price,
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.006),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            current.star.toString(),
                            style: textTheme.headline5,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${current.review} K+ review",
                            style: textTheme.headline5
                                ?.copyWith(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            ///Select Size Text
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,top: 18,bottom: 10),
                child: Text("Select Size",
                style: textTheme.headline3,
                ),
              ),
            ),

            /// Sizes
            FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: SizedBox(
                height: size.height * 0.08,
                width: size.width * 0.9,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: sizes.length,
                  itemBuilder: (context, index) {
                    var current = sizes[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedsize = index;
                      });
                    },
                    child: AnimatedContainer(
                      margin: const EdgeInsets.only(left: 12,top: 7 ,bottom: 7,right: 4),
                      duration: const Duration(milliseconds: 200),
                    width: size.width * 0.12,
                      decoration: BoxDecoration(
                        color: selectedsize == index ? primaryColor : Colors.transparent,
                        border: Border.all(color: primaryColor , width: 2),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text(current,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: selectedsize == index
                            ? Colors.white
                              : Colors.black
                        ),
                        ),
                      ),
                    ),
                  );
                },),
              ),
            ),

            ///Select Color Text
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,top: 18,bottom: 10),
                child: Text("Select Color",
                  style: textTheme.headline3,
                ),
              ),
            ),

            ///Colors
            FadeInUp(
              delay: const Duration(milliseconds: 700),
              child: SizedBox(
                height: size.height * 0.08,
                width: size.width,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    var current = colors[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = index;
                        });
                      },
                      child: AnimatedContainer(
                        margin: const EdgeInsets.only(left: 12,top: 7 ,bottom: 7,right: 4),
                        duration: const Duration(milliseconds: 200),
                        width: size.width * 0.12,
                        decoration: BoxDecoration(
                            color: current,
                            border: Border.all(color: primaryColor , width: selectedColor == index ? 2 :1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    );
                  },),
              ),
            ),

            /// Add To cart
            FadeInUp(
              delay: const Duration(milliseconds: 800),
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.03),
                child: Center(
                  child: MaterialButton(
                    onPressed: () {
                      AddToCart.addToCart(current, context);
                    },
                    height: size.height * 0.07,
                  minWidth: size.width * 0.9,
                    color: Color(0xFF141414),
                    child: Text("Add to cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
