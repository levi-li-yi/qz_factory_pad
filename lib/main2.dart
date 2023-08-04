/*
 * @Author: Levi Li
 * @Date: 2023-07-24 13:26:58
 * @description: 基础组件
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
        home: const MyHomePage(title: 'Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHomePage> {
  int _counter = 0;

  // 单选开关状态
  bool _switchSelected = true;
  // 复选框状态
  bool _checkboxSelected = true;

  // 定义获取input的controller
  final TextEditingController _testController = TextEditingController();

  // 定义input焦点
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode? focusScopeNode;

  // 定义用户名、密码输入框的controller
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // 初始化状态、状态监听
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _testController.addListener(() {
      print(_testController.text);
    });
    _testController.text = '123';

    // 监听焦点变化
    focusNode1.addListener(() {
      print(focusNode1.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const Text('Center'),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text('ElevatedButton'),
              ),
              TextButton(
                child: const Text('TextButton'),
                onPressed: () {
                  print('TextButton');
                },
              ),
              OutlinedButton(
                child: const Text('OutlinedButton'),
                onPressed: () {
                  print('OutlinedButton');
                },
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Icon OutlinedButton'),
                onPressed: () {
                  print(_testController.text);
                },
              ),
              Switch(
                value: _switchSelected,
                onChanged: (value) {
                  setState(() {
                    _switchSelected = value;
                  });
                },
              ),
              Checkbox(
                value: _checkboxSelected,
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    _checkboxSelected = value!;
                  });
                },
              ),
              TextField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: '用户名',
                  hintText: '用户名或邮箱',
                  prefixIcon: Icon(Icons.person),
                  // 未获得焦点下划线设为灰色
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  // 获得焦点下划线设为蓝色
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                // enabled: false,
                keyboardType: TextInputType.text,
                // obscureText: true,
                controller: _testController,
                // 关联focusNode1
                focusNode: focusNode1,
              ),
              TextField(
                autofocus: false,
                keyboardType: TextInputType.text,
                // 关联focusNode2
                focusNode: focusNode2,
                decoration: const InputDecoration(
                  // labelText: '用户名',
                  hintText: '用户名或邮箱',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              ElevatedButton(
                child: const Text('移动焦点'),
                onPressed: () {
                  // 写法1
                  // FocusScope.of(context).requestFocus(focusNode2);
                  // 这是第二种写法
                  focusScopeNode ??= FocusScope.of(context);
                  focusScopeNode?.requestFocus(focusNode2);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // 当所有编辑框都失去焦点时键盘就会收起
                  focusNode1.unfocus();
                  focusNode2.unfocus();
                },
                child: const Text('隐藏键盘'),
              ),
              const Text('测试表单验证及操作'),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        autofocus: true,
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: '用户名',
                          hintText: '请输入用户名',
                          icon: Icon(Icons.person),
                        ),
                        validator: (v) {
                          return v!.trim().isNotEmpty ? null : "用户名不能为空";
                        })
                  ],
                ),
              ),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('登录'),
                      ),
                      onPressed: () {
                        if ((_formKey.currentState as FormState).validate()) {
                          print('验证通过');
                        }
                      },
                    ))
                  ],
                ),
              ),
              // 模糊进度条
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
              //进度条显示50%
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                value: .5,
              ),
              // 模糊进度条(会执行一个旋转动画)
              CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
              //进度条显示50%，会显示一个半圆
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                  value: .5,
                ),
              ),
            ],
          ),
        ));
  }
}
