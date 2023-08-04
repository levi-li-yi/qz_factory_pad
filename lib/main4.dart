/*
 * @Author: Levi Li
 * @Date: 2023-07-24 13:26:58
 * @description: 容器类组件
 */
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('容器类组件'),
      ),
      body: const Column(
        children: [
          MyPadding(),
          MyDecoratedBox(),
          MyTransform(),
          Padding(padding: EdgeInsets.only(top: 20)),
          MyContainer(),
          MyClip(),
          MyFittedBox(),
        ],
      ),
    );
  }
}

// Padding可以给其子节点添加填充（留白），和边距效果类似
class MyPadding extends StatelessWidget {
  const MyPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      // 上限左右各添加16像素
      padding: EdgeInsets.all(16),
      child: Column(
        //显式指定对齐方式为左对齐，排除对齐干扰
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            // 左边8像素
            padding: EdgeInsets.only(left: 8),
            child: Text('左边8像素'),
          ),
          Padding(
            // 上下各8像素
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('上下各8像素'),
          ),
          Padding(
            // 四个方向
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text('四个方向'),
          )
        ],
      ),
    );
  }
}

// 装饰容器,
// DecoratedBox可以在其子组件绘制前(或后)绘制一些装饰（Decoration），如背景、边框、渐变等。
class MyDecoratedBox extends StatelessWidget {
  const MyDecoratedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        // 背景渐变
        gradient: LinearGradient(colors: [Colors.red, Colors.orange.shade700]),
        // 圆角
        borderRadius: BorderRadius.circular(3),
        // 阴影
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(2.0, 2.0),
            blurRadius: 4.0,
          )
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Text('Login'),
      ),
    );
  }
}

// 变换容器
// Transform可以在其子组件绘制时对其应用一些矩阵变换来实现一些特效。
// Matrix4是一个4D矩阵，通过它我们可以实现各种矩阵操作，
class MyTransform extends StatelessWidget {
  const MyTransform({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Y轴倾斜
        Container(
          color: Colors.black,
          child: Transform(
            alignment: Alignment.topRight,
            transform: Matrix4.skewY(0.5),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.deepOrange,
              child: const Text('沿Y轴倾斜'),
            ),
          ),
        ),
        // 平移
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          //默认原点为左上角，左移20像素，向上平移5像素
          child: Transform.translate(
            offset: const Offset(-20.0, -5.0),
            child: const Text('平移'),
          ),
        ),
        // 旋转
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.rotate(
            angle: math.pi / 2,
            child: const Text('旋转90度'),
          ),
        ),
        // 缩放
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.scale(
            scale: 1.5,
            child: const Text('放大1.5倍'),
          ),
        ),
        // Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(color: Colors.red),
              child: Transform.scale(
                scale: 1.5,
                child: const Text('Hello Flutter'),
              ),
            ),
            const Text('你好', style: TextStyle(color: Colors.green))
          ],
        ),
        // 对比Transform.rotate和RotatedBox区别
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              //将Transform.rotate换成RotatedBox
              child: RotatedBox(
                quarterTurns: 1, //旋转90度(1/4圈)
                child: Text("Hello world"),
              ),
            ),
            Text(
              "你好",
              style: TextStyle(color: Colors.green, fontSize: 18.0),
            )
          ],
        ),
      ],
    );
  }
}

// 容器组件
// Container是一个组合类容器，它本身不对应具体的RenderObject，
// 它是DecoratedBox、ConstrainedBox、Transform、Padding、Align等组件组合的一个多功能容器
class MyContainer extends StatelessWidget {
  const MyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 容器外补白，margin
        Container(
          margin: const EdgeInsets.all(20.0),
          color: Colors.orange,
          child: const Text('容器外补白'),
        ),
        // 容器内补白，padding
        Container(
            padding: const EdgeInsets.all(20.0),
            color: Colors.orange,
            child: const Text('容器内补白'))
      ],
    );
  }
}

// 剪裁组件(ClipOval、ClipRRect、ClipRect、ClipPath)
class MyClip extends StatelessWidget {
  const MyClip({super.key});

  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset(
      'images/avatar.jpg',
      width: 60.0,
    );

    return Container(
      child: Column(
        children: [
          avatar,
          // 剪裁为原型
          ClipOval(
            child: avatar,
          ),
          // 圆角矩形
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: avatar,
          ),
          // 使用Align
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                widthFactor: 0.5, // //宽度设为原来宽度一半，另一半会溢出
                child: avatar,
              ),
              const Text('你好，，，')
            ],
          ),
          // 使用ClipRect将溢出部分隐藏
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRect(
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.5,
                  child: avatar,
                ),
              ),
              const Text('你好，，，')
            ],
          ),
          // 自定义剪裁
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.red),
            child: ClipRect(
              clipper: MyCustomClipper(),
              child: avatar,
            ),
          )
        ],
      ),
    );
  }
}

// 自定义剪裁(CustomClipper)
class MyCustomClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // Rect.fromLTWH(10.0, 15.0, 40.0, 30.0)，即图片中部40×30像素的范围。
    return const Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    // 如果在应用中，剪裁区域始终不会发生变化时应该返回false，
    // 这样就不会触发重新剪裁，避免不必要的性能开销
    return false;
  }
}

// 空间适配(FittedBox)
// 子组件大小超出了父组件大小时，如果不经过处理的话 Flutter 中就会显示一个溢出警告并在控制台打印错误日志
class MyFittedBox extends StatelessWidget {
  const MyFittedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          wContainer(BoxFit.none),
          const Text('Overflow'),
          wContainer(BoxFit.contain),
          const Text('Contain'),
        ],
      ),
    );
  }
}

Widget wContainer(BoxFit boxFit) {
  return Container(
    width: 50,
    height: 50,
    color: Colors.red,
    // 虽然 FittedBox 子组件的大小超过了 FittedBox 父 Container 的空间，但FittedBox 自身还是要遵守其父组件传递的约束，
    // 所以最终 FittedBox 的本身的大小是 50×50，
    child: FittedBox(
      fit: boxFit,
      // 超出父容器尺寸
      child: Container(width: 60, height: 70, color: Colors.blue),
    ),
  );
}
