import 'package:RestaurantAdmin/Presenter/PresenterDishesMVP.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';
import 'package:RestaurantAdmin/Utils/WidgetsX.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceDishesMVP.dart';
import 'package:RestaurantAdmin/View/MobileDesign/Smartphone/AddDishesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

class ProductDetail extends StatelessWidget {
  ProductDetail({Key? key, required this.category, required this.url})
      : super(key: key);
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

class _StatefulProductDetail extends State<StatefulProductDetail>
    implements interfaceDishesMVP {
  bool showLoadingProgress = false;
  PresenterDishesMVP? presenterDishesMVP;
  var category;
  var url;
  String initAmountDishes = '';

  _StatefulProductDetail(this.category, this.url);

  @override
  void initState() {
    // TODO: implement initState
    presenterDishesMVP = PresenterDishesMVP(this);
    presenterDishesMVP!.requestModelLoadMyDishes(category);
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
                                child: Image.network(url),
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
                  )
                ],
              ),
              painter: PainterAmount(),
            ),
          ),
          Expanded(
              child: Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Visibility(
                    visible: showLoadingProgress,
                    child: LoadingWidget(),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Visibility(
                    visible: !showLoadingProgress,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        'Aún no tienes platos en la categoría ' + category,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !showLoadingProgress,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: FloatingActionButton(
                        heroTag: 'fab',
                        elevation: 10,
                        onPressed: () {
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
          ))
        ],
      ),
    );
  }

  @override
  void notifyViewEmptyDishes() {
    // TODO: implement notifyViewEmptyDishes
    if (showLoadingProgress) {
      setState(() {
        showLoadingProgress = false;
      });
    }
    /* SnackBar snackBar = SnackBar(
        content:
            Text('Aún no tienes platos agregados en la categoría ' + category));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
  }

  @override
  void notifyViewShowDishes() {
    // TODO: implement notifyViewShowDishes
  }

  @override
  void notifyViewShowMessage(String msgType, String msgError) {
    // TODO: implement notifyViewShowMessage
    AlertDialog alertDialog =
        WidgetsX.buildAlertDialog(msgError, msgType, 13.sp);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  void notifyViewStartLoadingWidget() {
    // TODO: implement notifyViewStartLoadingWidget
    setState(() {
      showLoadingProgress = true;
    });
  }

  @override
  void notifyViewCloseLoadingWidget() {
    // TODO: implement notifyViewCloseLoadingWidget
    setState(() {
      showLoadingProgress = false;
    });
  }

  @override
  void notifyViewShowDishesAmount(int amountDishes) {
    // TODO: implement notifyViewShowDishesAmount
    setState(() {
      initAmountDishes = amountDishes.toString();
    });
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
    path0.moveTo(0, 0);
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
