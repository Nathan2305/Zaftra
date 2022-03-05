import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';

class UserCreatedDetails extends StatefulWidget {
  final BackendlessUser newUserCreated;

  const UserCreatedDetails({Key? key, required this.newUserCreated})
      : super(key: key);

  Stateful_UserCreatedDetails createState() =>
      Stateful_UserCreatedDetails(newUserCreated);
}

class Stateful_UserCreatedDetails extends State<UserCreatedDetails>  with SingleTickerProviderStateMixin{
  final BackendlessUser newUserCreated;

  Stateful_UserCreatedDetails(this.newUserCreated);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    const spaceAmongData = 12.0;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 35),
              child: Card(
                shadowColor: Colors.blueGrey,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                elevation: 20,
                child: Container(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 25, left: 12, bottom: 25),
                                child: Text('Usuario creado correctamente',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: DataSource.primaryColor,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                margin: EdgeInsets.all(spaceAmongData),
                                child: Text(
                                  'Email:',
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: DataSource.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: spaceAmongData + 20.0,
                                    bottom: spaceAmongData),
                                child: Text(newUserCreated.email,
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.black)),
                              ),
                              Container(
                                margin: EdgeInsets.all(spaceAmongData),
                                child: Text(
                                  'Contraseña:',
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: DataSource.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: spaceAmongData + 20.0,
                                    bottom: spaceAmongData),
                                child: Text(newUserCreated.password,
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.black)),
                              ),
                              Container(
                                margin: EdgeInsets.all(spaceAmongData),
                                child: Text(
                                  'Nombres:',
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: DataSource.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: spaceAmongData + 20.0,
                                    bottom: spaceAmongData),
                                child: Text(
                                    newUserCreated
                                        .getProperty(DataSource.COLUMN_NAME),
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.black)),
                              ),
                              Container(
                                  margin: EdgeInsets.all(spaceAmongData),
                                  child: Text(
                                    'Apellidos:',
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: DataSource.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    left: spaceAmongData + 20.0,
                                    bottom: spaceAmongData),
                                child: Text(
                                    newUserCreated.getProperty(
                                        DataSource.COLUMN_LAST_NAME),
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.black)),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(top: 20, bottom: 20),
                                  child: FloatingActionButton(
                                      onPressed: () {},
                                      child: Icon(Icons.share),
                                      backgroundColor: DataSource.primaryColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Lottie.asset('assets/user_created.json',
                              repeat: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              alignment: FractionalOffset.topCenter,
              child: Image(
                  height: 50,
                  width: 50,
                  image: AssetImage('assets/check_icon.png')),
            )
          ],
        ),
      ),
    );
  }
}
