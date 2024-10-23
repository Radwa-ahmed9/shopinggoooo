// lib/screens/home_page.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:store_app/services/get_all_categories_service.dart';
import 'package:store_app/screens/category_products_page.dart'; // تأكد من أن المسار صحيح
import 'package:store_app/widgets/custom_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                },
                icon: Icon(Icons.exit_to_app)),
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.cartPlus,
                color: Colors.black,
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Categories',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: FirebaseAuth.instance.currentUser!.emailVerified
            ? Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                child: FutureBuilder<List<dynamic>>(
                  future: GetAllCategoriesService().getAllCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<dynamic> categories = snapshot.data!;
                      return ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryProductsPage(
                                    categoryName: categories[index],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  categories[index],
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            : MaterialButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                },
                child: Text("please Verified Email"),
              ));
  }
}
