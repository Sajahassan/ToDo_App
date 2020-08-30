import 'package:flutter/material.dart';
import 'package:todo_hive/hivehelper/hivehelper.dart';
import 'package:todo_hive/screens/mainscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.helper.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.cyan,
        fontFamily: 'Lato',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                color: Colors.pink,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              subtitle: TextStyle(
                color: Colors.cyan,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      title: 'ToDo List',
      home: Builder(builder: (context) {
        Size size = MediaQuery.of(context).size;
        ScreenUtil.init(context);
        ScreenUtil.init(context, width: size.width, height: size.height);
        return MainScreen();
      }),
    );
  }
}
