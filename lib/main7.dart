/*
 * @Author: Levi Li
 * @Date: 2023-07-24 13:26:58
 * @description: ListView(沿一个方向线性排布所有子组件，并且它也支持列表项懒加载)
 */
import 'package:english_words/english_words.dart';
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
        home: const ScaffoldRoute());
  }
}

class ScaffoldRoute extends StatefulWidget {
  const ScaffoldRoute({super.key});

  @override
  State<ScaffoldRoute> createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute> {
  final int _selectedIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 导航栏
      appBar: AppBar(
        title: const Text('App Name'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const ListViewTestRoute(),
    );
  }
}

class ListViewTestRoute extends StatefulWidget {
  const ListViewTestRoute({super.key});

  @override
  State<ListViewTestRoute> createState() => _ListViewTestRouteState();
}

class _ListViewTestRouteState extends State<ListViewTestRoute> {
  // 列表尾部标记
  static const loadingTag = '##loading##';
  final _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  // 模拟加载数据
  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        // 重新构建列表
        _words.insertAll(
            _words.length - 1,
            // 每次生成20个单词
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 基本用法
    // return ListView(
    //  shrinkWrap: true,
    //  padding: const EdgeInsets.all(20.0),
    //  children: const <Widget>[
    //   Text('I\'m dedicating every day to you'),
    //   Text('Domestic life was never quite my style'),
    //   Text('When you smile, you knock me out, I fall apart'),
    //   Text('And I thought I was so smart'),
    //  ],
    // );

    // 使用ListView.builder，且指定prototypeItem或itemExtent
    // return ListView.builder(
    //  itemCount: 100,
    //  prototypeItem: const ListTile(title: Text("1")),
    //  //itemExtent: 56,
    //  itemBuilder: (context, index) {
    //   return ListTile(title: Text("$index"));
    //  },
    // );

    // 下划线widget预定义
    // Widget divider1 = const Divider(color: Colors.blue);
    // Widget divider2 = const Divider(color: Colors.green);
    // return ListView.separated(
    //   // 子项总数
    //   itemCount: 100,
    //   // 列表构造器
    //   itemBuilder: (BuildContext context, int index) {
    //     return ListTile(title: Text("$index"));
    //   },
    //   //分割器构造器
    //   separatorBuilder: (BuildContext context, int index) {
    //     return index % 2 == 0 ? divider1 : divider2;
    //   },
    // );

    // 模拟无限加载列表
    // return ListView.separated(
    //   itemCount: _words.length,
    //   itemBuilder: (context, index) {
    //     // 到了表尾
    //     if (_words[index] == loadingTag) {
    //       // 不足100条，继续加载
    //       if (_words.length - 1 < 100) {
    //         // 异步加载数据
    //         _retrieveData();
    //         // 加载时显示loading
    //         return Container(
    //           padding: const EdgeInsets.all(16.0),
    //           alignment: Alignment.center,
    //           child: const SizedBox(
    //             width: 24.0,
    //             height: 24.0,
    //             child: CircularProgressIndicator(strokeWidth: 2.0),
    //           ),
    //         );
    //       } else {
    //         // 已经加载了100条数据
    //         return Container(
    //           alignment: Alignment.center,
    //           padding: const EdgeInsets.all(16.0),
    //           child: const Text('没有更多', style: TextStyle(color: Colors.grey)),
    //         );
    //       }
    //     }
    //     // 显示单词表项
    //     return ListTile(title: Text(_words[index]));
    //   },
    //   separatorBuilder: (context, index) => const Divider(height: .0),
    // );

    // 添加固定列表头(注意：ListView的高度必须要有边界)
    return Column(
      children: [
        const ListTile(title: Text('商品列表')),
        Expanded(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text('$index'));
            },
          ),
        ),
      ],
    );
  }
}
