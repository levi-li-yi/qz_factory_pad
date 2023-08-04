/*
 * @Author: Levi Li
 * @Date: 2023-07-24 13:26:58
 * @description: 布局类组件()
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
      title: 'Flutter APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Widget redBox = const DecoratedBox(
  decoration: BoxDecoration(color: Colors.red),
);

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // 用于测试LayoutBuilder时，Column子组件
    var children = List.filled(6, const Text('A'));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        // 尺寸限制类容器，用于限制容器大小
        // 最小高度为50，宽度尽可能大的红色容器
        // body: ConstrainedBox(
        //   constraints: const BoxConstraints(
        //     minWidth: double.infinity,
        //     minHeight: 60.0,
        //   ),
        //   // 虽然SizedBox指定高度为5.0，但是渲染出的高度仍然为红色容器设定的minHeight
        //   child: SizedBox(
        //     height: 5.0,
        //     child: redBox,
        //   ),
        // ),

        // 有多个父级ConstrainedBox，多重限制
        // 最终渲染的是宽90、高60，有多重限制时，对于minWidth和minHeight来说，
        // 是取父子中相应数值较大的。实际上，只有这样才能保证父限制与子限制不冲突。
        // body: ConstrainedBox(
        //   constraints: const BoxConstraints(
        //     minWidth: 60.0,
        //     minHeight: 60.0,
        //   ),
        //   child: ConstrainedBox(
        //     constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0),
        //     child: redBox,
        //   ),
        // ),

        // UnconstrainedBox 组件，UnconstrainedBox 的子组件将不再受到约束，大小完全取决于自己。
        // 一般情况下，我们会很少直接使用此组件，但在"去除"多重限制的时候也许会有帮助
        // 任何时候子组件都必须遵守其父组件的约束，所以在此提示读者，在定义一个通用的组件时，如果要对子组件指定约束，那么一定要注意，因为一旦指定约束条件，子组件自身就不能违反约束。
        // body: ConstrainedBox(
        //   constraints: const BoxConstraints(minWidth: 60.0, minHeight: 100.0),
        //   // 去除父级限制
        //   child: UnconstrainedBox(
        //     child: ConstrainedBox(
        //       constraints:
        //           const BoxConstraints(minWidth: 90.0, minHeight: 20.0),
        //       child: redBox,
        //     ),
        //   ),
        // ));

        // 线性布局(Row、Column)
        // body: const Center(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text('1 row item'),
        //           Text('1 row item'),
        //         ],
        //       ),
        //       Row(
        //         mainAxisSize: MainAxisSize.min,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text('2 row item'),
        //           Text('2 row item'),
        //         ],
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         textDirection: TextDirection.rtl,
        //         children: [
        //           Text('3 row item'),
        //           Text('3 row item'),
        //         ],
        //       ),
        //       Row(
        //         // mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         verticalDirection: VerticalDirection.up,
        //         children: [
        //           Text('4 row item'),
        //           Text('4 row item'),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        // 特殊情况，如果Row里面嵌套Row，或者Column里面再嵌套Column，那么只有最外面的Row或Column会占用尽可能大的空间，里面Row或Column所占用的空间为实际大小
        // 如果要让里面的Column占满外部Column，可以使用Expanded 组件：
        // body: Container(
        //   color: Colors.green,
        //   child: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisSize: MainAxisSize.max,
        //       children: <Widget>[
        //         Expanded(
        //           child: Container(
        //             color: Colors.red,
        //             child: const Column(
        //               mainAxisSize: MainAxisSize.max, // 外层不加Expanded时无效
        //               children: <Widget>[Text('is col item')],
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ));

        // 弹性布局
        // Flex组件可以沿着水平或垂直方向排列子组件
        // Expanded 只能作为 Flex 的孩子（否则会报错），它可以按比例“扩伸”Flex子组件所占用的空间。
        //因为 Row和Column 都继承自 Flex，所以 Expanded 也可以作为它们的孩子。
        // body: Column(
        //   children: [
        //     Flex(
        //       direction: Axis.horizontal,
        //       children: <Widget>[
        //         Expanded(
        //             flex: 1,
        //             child: Container(
        //               height: 30.0,
        //               color: Colors.red,
        //             )),
        //         Expanded(
        //             flex: 2,
        //             child: Container(
        //               height: 30.0,
        //               color: Colors.green,
        //             ))
        //       ],
        //     ),
        //     Padding(
        //         padding: const EdgeInsets.only(top: 20.0),
        //         child: SizedBox(
        //           height: 100.0,
        //           child: Flex(
        //             direction: Axis.vertical,
        //             children: <Widget>[
        //               Expanded(
        //                 flex: 2,
        //                 child: Container(
        //                   height: 30.0,
        //                   color: Colors.red,
        //                 ),
        //               ),
        //               const Spacer(
        //                 flex: 1,
        //               ),
        //               Expanded(
        //                 flex: 1,
        //                 child: Container(height: 30.0, color: Colors.green),
        //               )
        //             ],
        //           ),
        //         ))
        //   ],
        // ),

        // 流式布局
        // 我们把超出屏幕显示范围会自动折行的布局称为流式布局
        // Flutter中通过Wrap和Flow来支持流式布局
        // body: const SizedBox(
        //   width: 600,
        //   height: 60.0,
        //   child: Wrap(
        //       spacing: 8.0, // 主轴(水平)方向间距
        //       runSpacing: 4.0, // 纵轴（垂直）方向间距
        //       alignment: WrapAlignment.start, //沿主轴方向居中
        //       children: [
        //         Chip(
        //           avatar: CircleAvatar(
        //               backgroundColor: Colors.blue, child: Text('A')),
        //           label: Text('Chip A'),
        //           labelPadding: EdgeInsets.only(right: 100.0),
        //         ),
        //         Chip(
        //           avatar: CircleAvatar(
        //               backgroundColor: Colors.blue, child: Text('B')),
        //           label: Text('Chip B'),
        //           labelPadding: EdgeInsets.only(right: 100.0),
        //         ),
        //         Chip(
        //           avatar: CircleAvatar(
        //               backgroundColor: Colors.blue, child: Text('C')),
        //           label: Text('Chip C'),
        //           labelPadding: EdgeInsets.only(right: 100.0),
        //         ),
        //         Chip(
        //           avatar: CircleAvatar(
        //               backgroundColor: Colors.blue, child: Text('D')),
        //           label: Text('Chip D'),
        //           labelPadding: EdgeInsets.only(right: 100.0),
        //         ),
        //       ]),
        // ),

        // 层叠布局和 Web 中的绝对定位相似，子组件可以根据距父容器四个角的位置来确定自身的位置。
        // Flutter中使用Stack和Positioned这两个组件来配合实现绝对定位。
        // Stack允许子组件堆叠，而Positioned用于根据Stack的四个角来确定子组件的位置
        // 通过ConstrainedBox确保Stack沾满屏幕
        // body: ConstrainedBox(
        //   constraints: const BoxConstraints.expand(),
        //   child: Stack(
        //     alignment: Alignment.center, // 指定未定位部分定位widget的对齐方式
        //     fit: StackFit.expand, // 未定位widget占满stack整个空间
        //     children: [
        //       Container(
        //         color: Colors.red,
        //         child: const Text('Hello center',
        //             style: TextStyle(color: Colors.white)),
        //       ),
        //       const Positioned(
        //         left: 18.0,
        //         child: Text('Positioned left'),
        //       ),
        //       const Positioned(
        //         top: 18.0,
        //         child: Text('Positioned top'),
        //       ),
        //     ],
        //   ),
        // ),

        // 对齐与相对定位
        // 如果我们只想简单的调整一个子元素在父元素中的位置的话，使用Align组件会更简单一些。
        // widthFactor和heightFactor是用于确定Align 组件本身宽高的属性；
        //它们是两个缩放因子，会分别乘以子元素的宽、高，最终的结果就是Align 组件的宽高。如果值为null，则组件的宽高将会占用尽可能多的空间。
        // FractionalOffset 继承自 Alignment，它和 Alignment唯一的区别就是坐标原点不同！
        //FractionalOffset 的坐标原点为矩形的左侧顶点，这和布局系统的一致，所以理解起来会比较容易。
        // Stack可以有多个子元素，并且子元素可以堆叠，而Align只能有一个子元素，不存在堆叠。
        // body: Container(
        //   height: 120.0,
        //   width: 120.0,
        //   color: Colors.blue.shade50,
        //   child: const Align(
        //     widthFactor: 2,
        //     heightFactor: 2,
        //     // alignment: Alignment.topRight,
        //     // alignment: Alignment(2.0, 0.0),
        //     alignment: FractionalOffset(0.2, 0.6),
        //     child: FlutterLogo(
        //       size: 60,
        //     ),
        //   ),
        // ),

        //  LayoutBuilder、AfterLayout
        // 通过 LayoutBuilder，我们可以在布局过程中拿到父组件传递的约束信息，然后我们可以根据约束信息动态的构建不同的布局。
        // 比如我们实现一个响应式的 Column 组件 ResponsiveColumn，它的功能是当当前可用的宽度小于 200 时，将子组件显示为一列，否则显示为两列。
        body: Column(
          children: [
            // 限制宽度为190，小于200
            SizedBox(
              width: 190,
              child: ResponsiveColumn(children: children),
            ),
            // ResponsiveColumn(children: children),
            const LayoutLogPrint(child: Text('log'))
          ],
        ));
  }
}

// 响应式的Column，当前可用的宽度小于 200 时，将子组件显示为一列
class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    // 通过LayoutBuilder拿到父组件传递的约束,然后判定maxWidth是否小于200
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 最大宽度小于200，显示单列
        if (constraints.maxWidth < 200) {
          return Column(mainAxisSize: MainAxisSize.min, children: children);
        } else {
          // 大于200，显示双列
          var childrens = <Widget>[];
          for (var i = 0; i < children.length; i += 2) {
            if (i + 1 < children.length) {
              childrens.add(Row(
                mainAxisSize: MainAxisSize.min,
                children: [children[i], children[i + 1]],
              ));
            } else {
              childrens.add(children[i]);
            }
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: childrens,
          );
        }
      },
    );
  }
}

// 封装打印父组件传递给子组件约束的组件
class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({Key? key, this.tag, required this.child})
      : super(key: key);

  final Widget child;
  final T? tag;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        // assert在编译release版本时会被去除
        assert(() {
          print('${tag ?? key ?? child}: $constraints');
          return true;
        }());
        return child;
      },
    );
  }
}
