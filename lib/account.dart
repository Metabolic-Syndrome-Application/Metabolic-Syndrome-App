import 'package:flutter/material.dart';

import 'FoodMenu.dart';

void main() {
  runApp(MyApp());
}

//สร้าง Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int number = 0;
  //กลุ่มข้อมูล
  List<FoodMenu> menu =  [
    FoodMenu("กุ้งเผา","500","assets/images/grillshrimp.jpg"),
    FoodMenu("กะเพราไก่","25","assets/images/kapraokai.jpg"),
    FoodMenu("ต้มยำกุ้ง", "300","assets/images/tomyumkung.jpg"),
    FoodMenu("สลัดผัก", "250","assets/images/saladbowl.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [];

    data.add(Text("กดปุ่มเพื่อเพิ่มตัวเลข"));
    data.add(Text(number.toString()));
    data.add(Image(
        image: NetworkImage(
            "https://cdn.pixabay.com/photo/2014/12/10/20/48/laboratory-563423_640.jpg")));

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello Dart"),
      ),
      body: ListView.builder(
          itemCount: menu.length,
          itemBuilder: (BuildContext context, int index) {
            FoodMenu food = menu[index] ;
            return ListTile(
              leading: Image.asset(food.img),
              title: Text(food.name,style: TextStyle(fontSize:30),),
              subtitle: Text(food.price+"บาท"),
              onTap:() {
                print("คุณเลือกอาหารชื่อว่า"+food.name);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: addNumber ,
        child: Icon(Icons.add),
      ),
    );
  }

  void addNumber() {
    setState(() {
      number++;
    });
  }

  List<Widget> getData(int count) {
    List<Widget> data = [];
    for (var i = 0; i < count; i++) {
      var menu = ListTile(
        title: Text(
          "เมนูทที่ ${i + 1}",
          style: TextStyle(fontSize: 25),
        ),
        subtitle: Text("หัวข้อย่อยที่ ${i + 1}"),
      );
      data.add(menu);
    }
    return data;
  }
}
