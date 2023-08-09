/*
 * @Author: Levi Li
 * @Date: 2023-07-24 13:26:58
 * @description: CustomScrollView 和 Slivers
 * Flutter 提供了一个 CustomScrollView 组件来帮助我们创建一个公共的 Scrollable 和 Viewport ，然后它的 slivers 参数接受一个 Sliver 数组，
 * 这样我们就可以使用CustomScrollView 方面的实现我们期望的功能了：
 */
import 'package:flutter/material.dart';
import 'sliver.header.delegate.dart';

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
      // home: const CustomScrollViewRoute(),
      // home: const WholePageRoute(),
      home: const SliverPersistentRoute(),
    );
  }
}

// 一个基本的CustomScrollView示例页面
class CustomScrollViewRoute extends StatefulWidget {
  const CustomScrollViewRoute({super.key});

  @override
  State<CustomScrollViewRoute> createState() => _CustomScrollViewRouteState();
}

class _CustomScrollViewRouteState extends State<CustomScrollViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Scroll View'),
      ),
      body: buildTwoSliverList(),
    );
  }
}

// 使用CustomScrollView将两个SliverFixedExtentList融合在一个Scrollable和ViewPort中
Widget buildTwoSliverList() {
  // SliverFixedExtentList 是一个 Sliver，它可以生成高度相同的列表项。
  var listView = SliverFixedExtentList(
    itemExtent: 56, // 高度56
    delegate: SliverChildBuilderDelegate(
      (_, index) => ListTile(title: Text('$index')),
      childCount: 10,
    ),
  );

  // 使用 CustomScrollView
  return CustomScrollView(
    slivers: [listView, listView],
  );
}

// 一个包含AppBar的完整页面的ScrollView
class WholePageRoute extends StatelessWidget {
  const WholePageRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          // AppBar，包含一个导航栏
          SliverAppBar(
            // 滑动到顶端会固定住
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset('./images/avatar.jpg', fit: BoxFit.cover),
            ),
          ),
          // 使用SliverToBoxAdapter将RenderBox 适配成Sliver
          // 此处滑动方向是水平的，和CustomSliverView的滑动方向不一样
          // 如果 CustomScrollView 有孩子也是一个完整的可滚动组件且它们的滑动方向一致，
          // 则 CustomScrollView 不能正常工作
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: PageView(
                children: const [Text('Page 1'), Text('Page 2')],
              ),
            ),
          ),
          // 加留白的Sliver
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            // grid
            sliver: SliverGrid(
              // 定义网格基础
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  // 两列显式
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0),
              // 创建子Widget
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          // 加一个SliverFixedExtentList
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate((context, index) {
              // 创建列表项
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('list item $index'),
              );
            }, childCount: 20),
          ),
        ],
      ),
    );
  }
}

// 使用SliverPersistentHeader，实现当滑动到 CustomScrollView 的顶部时，可以将组件固定在顶部。
// Flutter 中设计 SliverPersistentHeader 组件的初衷是为了实现 SliverAppBar，
// 所以它的一些属性和回调在SliverAppBar 中才会用到
class SliverPersistentRoute extends StatelessWidget {
  const SliverPersistentRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          buildSliverList(),
          SliverPersistentHeader(
            // 滑动到顶部固定住
            pinned: true,
            // 最大和最小高度
            delegate: SliverHeaderDelegate(
              maxHeight: 80,
              minHeight: 50,
              child: buildHeader(1),
            ),
          ),
          buildSliverList(),
          SliverPersistentHeader(
            // 滑动到顶部固定住
            pinned: true,
            // 最大和最小高度
            delegate: SliverHeaderDelegate(
              maxHeight: 80,
              minHeight: 50,
              child: buildHeader(2),
            ),
          ),
          buildSliverList(30),
        ],
      ),
    );
  }

  // 构建固定高度的SliverList, count 为列表项属性
  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
      itemExtent: 50,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(title: Text('$index'));
        },
        childCount: count,
      ),
    );
  }

  // 构建Header
  Widget buildHeader(int i) {
    return Container(
      color: Colors.lightBlue.shade200,
      alignment: Alignment.centerLeft,
      child: Text('PersistentHeader $i'),
    );
  }
}
