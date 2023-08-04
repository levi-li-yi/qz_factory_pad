/*
 * @Author: Levi Li
 * @Date: 2023-07-24 13:26:58
 * @description: TabBarView(提供了 Tab 布局组件，通常和 TabBar 配合使用)
 */
import 'package:flutter/material.dart';
import 'package:qz_factory_pad/keep.alive.wrapper.dart';

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

class _ScaffoldRouteState extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin {
  // 显式定义controller
  late TabController _tabController;
  List tabs = ['新闻', '历史', '图片'];

  @override
  void initState() {
    super.initState();

    // 定义Tab Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        // 在AppBar的底部放置TabBar
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
      // 定义TabBarView
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return KeepAliveWrapper(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                e,
                textScaleFactor: 5,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 销毁
  @override
  void dispose() {
    // 释放controller
    _tabController.dispose();
    super.dispose();
  }
}
