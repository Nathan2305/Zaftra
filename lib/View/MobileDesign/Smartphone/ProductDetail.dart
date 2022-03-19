//@dart=2.9
import 'package:RestaurantAdmin/DAO/Dishes.dart';
import 'package:RestaurantAdmin/Model/ModelMainMenuMVP.dart';
import 'package:RestaurantAdmin/Presenter/PresenterDishesMVP.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';

import 'package:RestaurantAdmin/View/MobileDesign/Smartphone/AddDishesScreen.dart';
import 'package:RestaurantAdmin/main.dart';
import 'package:animate_do/animate_do.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

class ProductDetail extends StatelessWidget {
  ProductDetail({Key key, this.category, this.url}) : super(key: key);
  var category;
  var url;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 0,
            elevation: 0,
          ),
          body: StatefulProductDetail(category, url),
        );
      },
    );
  }
}

class StatefulProductDetail extends StatefulWidget {
  final category;
  final url;

  StatefulProductDetail(this.category, this.url);

  _StatefulProductDetail createState() => _StatefulProductDetail(category, url);
}

class _StatefulProductDetail extends State<StatefulProductDetail> {
  bool showLoadingProgress = false;
  PresenterDishesMVP presenterDishesMVP;
  var category;
  var url;
  String initAmountDishes = '';
  var _futureDishes;
  _StatefulProductDetail(this.category, this.url);
  @override
  void initState() {
    // TODO: implement initState
    var myOwnerId = ModelMainMenuMVP.currentUser.getObjectId();
    DataQueryBuilder dataQueryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId='${myOwnerId}' and category='${category}'"
      ..sortBy = ["created DESC"]
      ..pageSize = 100
      ..offset = 0;
    _futureDishes = Backendless.data.withClass<Dishes>().find(dataQueryBuilder);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //color: Colors.red,
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 30.h,
            child: CustomPaint(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 2.h),
                      child: Text(
                        initAmountDishes,
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: Hero(
                              tag: url,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 2.w),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 4.h),
                                  child: Image.network(url),
                                ),
                              )),
                          flex: 3,
                        ),
                        Expanded(
                          child: Hero(
                              tag: category,
                              child: Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                      fontSize: 20.sp, color: Colors.white),
                                ),
                              )),
                          flex: 4,
                        )
                      ],
                    ),


                  ),

                ],
              ),
              painter: PainterAmount(),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: _futureDishes,
            builder:
                (BuildContext context, AsyncSnapshot<List<Dishes>> snapshot) {
              Widget resultWidget;
              if (snapshot.connectionState == ConnectionState.waiting) {
                resultWidget = LoadingWidget();
              } else {
                 if (snapshot.hasData) {
                  List<Dishes> listDishesRetrieved = snapshot.data;
                  resultWidget = AnimatedList(
                    initialItemCount: listDishesRetrieved.length,
                    itemBuilder: (context, index, animation) {
                      String nameDish =
                          listDishesRetrieved.elementAt(index).name;
                      String priceDish =
                      listDishesRetrieved.elementAt(index).price.toString();
                      String descDish =
                          listDishesRetrieved.elementAt(index).description;
                      return FadeInLeft(
                        delay: Duration(milliseconds: 50*index),
                        child: Card(
                          elevation: 20,
                          margin: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(20)),
                          ),
                          child: Container(
                            //margin: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(50)),
                                    color: DataSource.primaryColor,
                                  ),
                                  padding: EdgeInsets.all(1.5.h),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(nameDish,
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text(descDish,
                                            style: TextStyle(fontSize: 16.sp)),
                                      ),
                                    ),
                                    Expanded(child: Text(priceDish,
                                        style: TextStyle(fontSize: 16.sp)),flex: 1,)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (!snapshot.hasData) {
                  resultWidget = Text(
                    'Aún no tienes platos en la categoria ${category}',
                    style: TextStyle(fontSize: 15.sp),
                  );
                } else {
                  resultWidget = Text(
                    'Error cargando paltos ${snapshot.error}',
                    style: TextStyle(fontSize: 15.sp),
                  );
                }
              }
              return Container(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: resultWidget,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FadeInLeft(
                          delay: Duration(seconds: 1),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: FloatingActionButton(
                              onPressed: (){
                                PushAndWaitForDishes();
                              },
                              child: Icon(Icons.add),
                              backgroundColor: DataSource.primaryColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
              );
            },
          ))
        ],
      ),
    );
  }

  Future<void> PushAndWaitForDishes() async {
    var listDishesCreated = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddDishesScreen(categorySent: category)));
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SpinKitCircle(
      color: Colors.blue,
      size: 15.h,
    );
  }
}

class PainterAmount extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
          Offset(size.width * -0.00, size.height * 0.50),
          Offset(size.width * 1.00, size.height * 0.50),
          [DataSource.primaryColor, DataSource.secondaryColor],
          [0.00, 1.00]);

    Path path0 = Path();
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width, size.height * 0.8300000);
    path0.lineTo(size.width * 0.6862500, size.height * 0.8300000);
    path0.quadraticBezierTo(size.width * 0.6856250, size.height * 0.9958333,
        size.width * 0.6237500, size.height * 0.9966667);
    path0.cubicTo(
        size.width * 0.5625000,
        size.height * 0.9966667,
        size.width * 0.4400000,
        size.height * 0.9966667,
        size.width * 0.3787500,
        size.height * 0.9966667);
    path0.quadraticBezierTo(size.width * 0.3134375, size.height * 0.9975000,
        size.width * 0.3125000, size.height * 0.8400000);
    path0.lineTo(0, size.height * 0.8300000);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
