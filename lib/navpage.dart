import 'package:flutter/material.dart';
import 'package:vethouse/map_page.dart';

class Navpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Text(
                    "greeting",
                    style: TextStyle(
                      color: Color.fromARGB(255, 58, 83, 183),
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Its Time To Take Care Of Your Pet.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Sofia Sans',
                      color: Color.fromARGB(255, 97, 97, 97),
                      fontSize: 30,
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/testtt.png"))),
              ),
              Column(
                children: <Widget>[
                  // the login button
                  MyButton(
                    iconData: Icons.pets,
                    buttonText: 'Search for a shop',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Mappage()));
                    },
                  ),
                  // creating the signup button
                  SizedBox(height: 20),
                  MyButton(
                    iconData: Icons.vaccines,
                    buttonText: 'Search for a Vet',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Mappage()));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.iconData,
    required this.buttonText,
    this.onTap,
  }) : super(key: key);
  final IconData iconData;
  final String buttonText;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 50.0,
            width: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Container(
                  height: 50.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 58, 83, 183),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    iconData,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 44, 39, 176),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
