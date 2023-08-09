/*
 * @Author: Levi Li
 * @Date: 2023-08-04 09:50:57
 * @description: 自定义Sliver
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home Page')),
        body: Container(
          child: const Text('body'),
        ));
  }
}

// 自定义SliverFlexibleHeader
class SliverFlexibleHeaderView extends StatelessWidget {
  const SliverFlexibleHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      // 允许支持弹性效果
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      // 自定义slivers
      slivers: [],
    );
  }
}

// 自定义SliverFlexibleHeader组件

// 构建测试用普通列表
Widget buildSliverList([int count = 5]) {
  return SliverFixedExtentList(
    itemExtent: 50,
    delegate: SliverChildBuilderDelegate((context, index) {
      return ListTile(title: Text('$index'));
    }, childCount: count),
  );
}
