/*
 * @Author: Levi Li
 * @Date: 2023-07-24 13:26:58
 * @description: 滚动监听及控制
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
  // ScrollController实例
  final ScrollController _controller = ScrollController();
  // 是否显示“返回顶部”按钮
  bool showToTopBtn = false;

  @override
  void initState() {
    super.initState();

    // 监听滚动事件，打印出滚动位置
    _controller.addListener(() {
      print(_controller.offset);

      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      }

      if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  // 销毁钩子
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: 100,
          itemExtent: 50.0,
          controller: _controller,
          itemBuilder: (context, index) {
            return ListTile(title: Text('$index'));
          },
        ),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease);
              },
            ),
    );
  }
}

// 滚动监听及控制
class ScrollControllerRoute extends StatefulWidget {
  const ScrollControllerRoute({super.key});

  @override
  State<ScrollControllerRoute> createState() => _ScrollControllerRouteState();
}

class _ScrollControllerRouteState extends State<ScrollControllerRoute> {
  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}
