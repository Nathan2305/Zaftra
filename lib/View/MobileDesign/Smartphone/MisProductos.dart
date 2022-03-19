//@dart=2.9

import 'package:RestaurantAdmin/Utils/DataSource.dart';
import 'package:RestaurantAdmin/View/MobileDesign/Smartphone/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

final listCategories = {
  "Platos criollos",
  "Caldos",
  "Pescados y mariscos",
  "Pollos y parrillas",
  "Bebidas",
  "Postres",
  "Otros"
};
final listCategoriesImageUrl = {
  'https://backendlessappcontent.com/C53D7BF1-EC61-A11B-FF18-31BAED0CB500/E46CA2B0-F560-48E6-8149-9FFF4A0F167A/files/image_categories/lomo.png',
  'https://backendlessappcontent.com/C53D7BF1-EC61-A11B-FF18-31BAED0CB500/E46CA2B0-F560-48E6-8149-9FFF4A0F167A/files/image_categories/caldos.png',
  'https://backendlessappcontent.com/C53D7BF1-EC61-A11B-FF18-31BAED0CB500/E46CA2B0-F560-48E6-8149-9FFF4A0F167A/files/image_categories/seafood.png',
  'https://backendlessappcontent.com/C53D7BF1-EC61-A11B-FF18-31BAED0CB500/E46CA2B0-F560-48E6-8149-9FFF4A0F167A/files/image_categories/parrillas.png',
  'https://backendlessappcontent.com/C53D7BF1-EC61-A11B-FF18-31BAED0CB500/E46CA2B0-F560-48E6-8149-9FFF4A0F167A/files/image_categories/bebidas.png',
  'https://backendlessappcontent.com/C53D7BF1-EC61-A11B-FF18-31BAED0CB500/E46CA2B0-F560-48E6-8149-9FFF4A0F167A/files/image_categories/postre.png',
  'https://backendlessappcontent.com/C53D7BF1-EC61-A11B-FF18-31BAED0CB500/E46CA2B0-F560-48E6-8149-9FFF4A0F167A/files/image_categories/otros.png',
};

void main() {
  runApp(MisProductos());
}

class MisProductos extends StatefulWidget {
  _MisProductos createState() => _MisProductos();
}

class _MisProductos extends State<MisProductos> with TickerProviderStateMixin {
  /* AnimationController animationController;
  Animation<double> animation;*/
  PageController pageController = PageController(initialPage: 0);
  double verticalDrag = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    /*animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);*/
    // pageController.initialPage=0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                DataSource.primaryColorPlatos,
                DataSource.secondaryColorPlatos
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(
                      'Selecciona una opción',
                      style: TextStyle(fontSize: 8.w, color: Colors.white),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  flex: 5,
                  child: PageView(controller: pageController, children: [
                    Widget_PlatosCriollos(),
                    Widget_Sopas(),
                    Widget_SeaFood(),
                    Widget_Parrillas(),
                    Widget_Bebidas(),
                    Widget_Postres(),
                    Widget_Otros(),
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class Widget_Otros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var category = listCategories.elementAt(6);
    var url = listCategoriesImageUrl.elementAt(6);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Hero(
            tag: url,
            child: Image.network(url, width: 75.w, height: 40.h),
          ),
          onTap: () {
            startRouteProductDetail(context, category, url);
          },
        ),
        Hero(
          tag: category,
          child: Text(
            category,
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class Widget_Postres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var category = listCategories.elementAt(5);
    var url = listCategoriesImageUrl.elementAt(5);
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Hero(
            tag: url,
            child: Image.network(url, width: 75.w, height: 40.h),
          ),
          onTap: () {
            startRouteProductDetail(context, category, url);
          },
        ),
        Hero(
          tag: category,
          child: Text(
            category,
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class Widget_Bebidas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var category = listCategories.elementAt(4);
    var url = listCategoriesImageUrl.elementAt(4);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Hero(
            tag: url,
            child: Image.network(url, width: 75.w, height: 40.h),
          ),
          onTap: () {
            startRouteProductDetail(context, category, url);
          },
        ),
        Hero(
          tag: category,
          child: Text(
            category,
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class Widget_Parrillas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var category = listCategories.elementAt(3);
    var url = listCategoriesImageUrl.elementAt(3);
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Hero(
            tag: url,
            child: Image.network(url, width: 75.w, height: 40.h),
          ),
          onTap: () {
            startRouteProductDetail(context, category, url);
          },
        ),
        Hero(
          tag: category,
          child: Text(
            category,
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class Widget_SeaFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var category = listCategories.elementAt(2);
    var url = listCategoriesImageUrl.elementAt(2);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Hero(
            tag: url,
            child: Image.network(url, width: 75.w, height: 40.h),
          ),
          onTap: () {
            startRouteProductDetail(context, category, url);
          },
        ),
        Hero(
          tag: category,
          child: Text(
            category,
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class Widget_Sopas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var category = listCategories.elementAt(1);
    var url = listCategoriesImageUrl.elementAt(1);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: url,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Image.network(
                url,
                width: 75.w,
                height: 40.h,
                fit: BoxFit.contain,
              ),
              onTap: () {
                startRouteProductDetail(context, category, url);
              },
            ),
          ),
        ),
        Hero(
          tag: category,
          child: Text(
            category,
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class Widget_PlatosCriollos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var category = listCategories.elementAt(0);
    var url = listCategoriesImageUrl.elementAt(0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Hero(
            tag: url,
            child: Image.network(url, width: 75.w, height: 40.h),
          ),
          onTap: () {
            startRouteProductDetail(context, category, url);
          },
        ),
        Hero(
          tag: category,
          child: Text(
            category,
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class MyClipperScroll extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path0 = Path();
    path0.lineTo(0, size.height * 0.8542857);
    path0.quadraticBezierTo(size.width * 0.3704167, size.height * 1.0035714,
        size.width * 0.4983333, size.height);
    path0.quadraticBezierTo(size.width * 0.6312500, size.height * 0.9985714,
        size.width, size.height * 0.8542857);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, 0);
    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

void startRouteProductDetail(
    BuildContext context, String category, String url) {
  //Methods.startNewRoute(context, productDetail);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetail(category: category, url: url),
    ),
  );
}
