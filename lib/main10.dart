/*
 * @Author: Levi Li
 * @Date: 2023-07-24 13:26:58
 * @description: 可滚动组件子项缓存
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    // 生成6个Page
    for (int i = 0; i < 5; i++) {
      children.add(KeepAliveWrapper(child: Page(text: '${i + 1}')));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: PageView(children: children),
    );
  }
}

// 定义Page，并让 PageState 混入AutomaticKeepAliveClientMixin
class Page extends StatefulWidget {
  const Page({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<Page> createState() => _PageState();
}

// 混入AutomaticKeepAliveClientMixin后Page页面只会build一次
// 混入AutomaticKeepAliveClientMixin的缺点是要修改Page的代码，这样的更改具有侵入性
// 导致当Page组件同时存在列表中和列表外使用时则需要两份Page组件代码
// class _PageState extends State<Page> with AutomaticKeepAliveClientMixin {
class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    // 必须调用
    // super.build(context);

    print("build ${widget.text}");

    return Center(
      child: Text(
        widget.text,
        textScaleFactor: 5,
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true; // 是否需要缓存
}

// 封装KeepAliveWrapper组件，以实现当列表项需要缓存时，只需KeepAliveWrapper包裹即可
class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({Key? key, this.keepAlive = true, required this.child})
      : super(key: key);

  final bool keepAlive;
  final Widget child;

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  // 组件更新
  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
