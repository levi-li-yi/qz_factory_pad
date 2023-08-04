/*
 * @Author: Levi Li
 * @Date: 2023-07-24 13:26:58
 * @description: PageView(页面切换和 Tab 布局)
 */
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ScaffoldRoute(),
    );
  }
}

class ScaffoldRoute extends StatefulWidget {
  const ScaffoldRoute({super.key});

  @override
  State<ScaffoldRoute> createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute> {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    // 生产6个tab页
    for (int i = 0; i < 6; i++) {
      children.add(Page(text: '$i'));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: PageView(
          // 只能实现缓存前后两页
          allowImplicitScrolling: true,
          children: children,
        ));
  }
}

// 定义Page
class Page extends StatefulWidget {
  const Page({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    print("build ${widget.text}");

    return Center(
      child: Text(
        widget.text,
        textScaleFactor: 5,
      ),
    );
  }
}
