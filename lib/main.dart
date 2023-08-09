/*
 * @Author: Levi Li
 * @Date: 2023-08-04 09:50:57
 * @description: 自定义Sliver
 */
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

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
      // 为了能使CustomScrollView拉到顶部时还能继续往下拉，允许支持弹性效果
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      // 自定义slivers
      slivers: [],
    );
  }
}

// 实现接收固定widget的_SliverFlexibleHeader组件
class _SliverFlexibleHeader extends SingleChildRenderObjectWidget {
  const _SliverFlexibleHeader({
    Key? key,
    required Widget child,
    // ignore: unused_element
    this.visibleExtent = 0,
  }) : super(key: key, child: child);
  final double visibleExtent;

  // 自定义RenderObject
  @override
  RenderObject createRenderObject(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  void updateRenderObject(
      BuildContext context, _FlexibleHeaderRenderSliver renderObject) {
    renderObject.visibleExtent = visibleExtent;
  }
}

class _FlexibleHeaderRenderSliver extends RenderSliverSingleBoxAdapter {
  _FlexibleHeaderRenderSliver(double visibleExtent)
      : _visibleExtent = visibleExtent;

  double _lastOverScroll = 0;
  final double _lastScrollOffset = 0;
  late double _visibleExtent = 0;

  // 可视长度发生变化，更新状态并重新布局
  set visibleExtent(double value) {
    if (_visibleExtent != value) {
      _lastOverScroll = 0;
      _visibleExtent = value;
      markNeedsLayout(); // flutter内置函数
    }
  }

  @override
  void performLayout() {
    // 滑动距离大于_visibleExtent时，则表示子节点已经在屏幕之外了
    if (child == null || (constraints.scrollOffset > _visibleExtent)) {
      geometry = SliverGeometry(scrollExtent: _visibleExtent);
      return;
    }

    // 测试overlap，下拉过程中overlap会一直变化
    double overScroll = constraints.overlap < 0 ? constraints.overlap.abs() : 0;
    var scrollOffset = constraints.scrollOffset;

    // 在Viewport中顶部的可视空间为该Sliver可绘制最大区域
    // 1. 如果Sliver已经滑出可视区域则 constraints.scrollOffset 会大于 _visibleExtent，
    //    这种情况我们在一开始就判断过了。
    // 2. 如果我们下拉超出了边界，此时 overScroll>0，scrollOffset 值为0，所以最终的绘制区域为
    //    _visibleExtent + overScroll.
    double paintExtent = _visibleExtent + overScroll - constraints.scrollOffset;
    // 绘制高度不超过最大可绘制空间
    paintExtent = math.min(paintExtent, constraints.remainingPaintExtent);
  }
}

// 自定义SliverFlexibleHeader组件
// 由于涉及到 Sliver 布局，通过现有组件很难组合实现我们想要的功能，所以我们通过定制 RenderObject 的方式来实现它
// 为了能根据下拉位置的变化来动态调整，SliverFlexibleHeader 中我们通过一个 builder 来动态构建布局，当下拉位置发生变化时，builder 就会被回调。

// 构建测试用普通列表
Widget buildSliverList([int count = 5]) {
  return SliverFixedExtentList(
    itemExtent: 50,
    delegate: SliverChildBuilderDelegate((context, index) {
      return ListTile(title: Text('$index'));
    }, childCount: count),
  );
}
