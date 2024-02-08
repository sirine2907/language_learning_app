import 'package:flutter/material.dart';
import 'package:language_learning_app/components/category_item.dart';
import 'package:language_learning_app/screens/numbers_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9EBF0),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFD1DC),
        title: Text('Tuku'),
      ),
      body: Column(
        children: [
          Category(
            onTap:(){
              //navigator.push(context, Route)
              Navigator.push(context,
                 MaterialPageRoute(builder: (BuildContext context){
                return NumbersPage();
              }));
            },
            text:'Numbers',
             color: Color(0xFFFFDAB9),
             ),
          Category(
            onTap:(){},
            text:'Family members',
             color: Color(0xFFC5E7F5),
             ),
          Category(
            onTap:(){},
            text:'Colors',
             color: Color(0xFFF0E68C),
             ),
          Category(
            onTap:(){},
            text:'Phrases',
             color: Color(0xFFFEE1D5),
             ),
        ],
      ),
    );
  }
}

