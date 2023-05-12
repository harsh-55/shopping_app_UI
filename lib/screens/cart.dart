import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shopping_app/data/app_data.dart';
import 'package:shopping_app/main_wrapper.dart';
import 'package:shopping_app/model/base_model.dart';
import 'package:shopping_app/utils/reuseable_row_for_cart.dart';

import '../main.dart';
import '../utils/constants.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {

/// Delete current selected item from cart list
  void onDelete(BaseModel data) {
    setState(() {
      if (itemsOnCart.length == 1) {
        itemsOnCart.clear();
      }
      else {
        itemsOnCart.removeWhere((element) => element.id == data.id);
      }
    });
  }

  /// Calculate total price
  double calculateTotalprice() {
    double total = 0.0;
    if (itemsOnCart.isEmpty) {
      total = 0.0;
    }
    else {
      for (BaseModel data in itemsOnCart) {
        total = total + data.price * data.value;
      }
    }
    return total;
  }

  /// Calculate shipping price
  double calculateShipping() {
    double shipping = 0.0;
    if (itemsOnCart.isEmpty) {
      shipping = 0.0;
      return shipping;
    }
    else if (itemsOnCart.length <= 4) {
      shipping = 25.99;
      return shipping;
    }
    else {
      shipping = 88.99;
      return shipping;
    }
  }

  /// Calculate sub total price
  int calculateSubTotal() {
    int subTotal = 0;
    if (itemsOnCart.isEmpty) {
      subTotal = 0;
    }
    else {
      for (BaseModel data in itemsOnCart) {
        subTotal = subTotal + data.price.round();
        subTotal = subTotal - 160;
      }
    }
    return subTotal < 0 ? 0 : subTotal;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return MainWrapper();
              },
            ));
          },
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(LineIcons.user),
            color: Colors.black,
          ),
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
                height: size.height * 0.6,
                width: size.width,
                child: itemsOnCart.isNotEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: itemsOnCart.length,
                        itemBuilder: (context, index) {
                          var current = itemsOnCart[index];
                          return FadeInUp(
                            delay: Duration(milliseconds: 100 * index + 80),
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              height: size.height * 0.25,
                              width: size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    width: size.width * 0.4,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(current.imageUrl),
                                            fit: BoxFit.cover),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 4),
                                              blurRadius: 4,
                                              color:
                                                  Color.fromARGB(61, 0, 0, 0))
                                        ]),
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.52,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                current.name,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    onDelete(current);
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.grey,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: "€",
                                            style:
                                                textTheme.subtitle2?.copyWith(
                                              fontSize: 22,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: current.price.toString(),
                                                style: textTheme.subtitle2
                                                    ?.copyWith(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.04),
                                        Text(
                                          "Size = ${sizes[3]}",
                                          style: textTheme.subtitle2?.copyWith(
                                              fontSize: 15,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.height * 0.04),
                                          height: size.height * 0.045,
                                          width: size.width * 0.4,
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.all(4),
                                                width: size.width * 0.065,
                                                height: size.height * 0.045,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  onTap: () {
                                                    setState(() {
                                                      if (current.value > 1){
                                                        current.value--;
                                                      } else {
                                                        onDelete(current);
                                                        current.value = 1;
                                                      }
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 0.02),
                                                child: Text(
                                                  current.value.toString(),
                                                  style: textTheme.subtitle2
                                                      ?.copyWith(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.all(4),
                                                width: size.width * 0.065,
                                                height: size.height * 0.045,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  onTap: () {
                                                    setState(() {
                                                      current.value >= 0
                                                          ? current.value++
                                                          : null;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Column(
                        children: [
                          SizedBox(height: size.height * 0.02),
                          FadeInUp(
                            delay: const Duration(milliseconds: 200),
                            child: Image(
                              image: AssetImage("assets/images/empty.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          FadeInUp(
                            delay: const Duration(milliseconds: 250),
                            child: const Text(
                              "Ypur cart is empty right now :(",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          FadeInUp(
                              delay: const Duration(milliseconds: 300),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return MainWrapper();
                                      },
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.black,
                                  )))
                        ],
                      )),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.white,
                height: size.height * 0.36,
                width: size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Column(
                    children: [
                      FadeInUp(
                        delay: const Duration(milliseconds: 350),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Promo/Student code or Vouchers",
                              style:
                                  textTheme.headline3?.copyWith(fontSize: 16),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: ReuseableRowForCart(
                              text: 'Sub Total', price: calculateSubTotal().toDouble())),
                      FadeInUp(
                          delay: const Duration(milliseconds: 450),
                          child: ReuseableRowForCart(
                              text: 'Shipping', price: calculateShipping())),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          child:
                              ReuseableRowForCart(text: 'Total', price: calculateTotalprice())),
                      FadeInUp(
                        delay: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.03),
                          child: Center(
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return const cart();
                                  },
                                ));
                              },
                              height: size.height * 0.07,
                              minWidth: size.width * 0.9,
                              color: Color(0xFF141414),
                              child: Text(
                                "CheckOut",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
