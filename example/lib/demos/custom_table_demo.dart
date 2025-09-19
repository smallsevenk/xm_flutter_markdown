// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_implementing_value_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// ignore_for_file: public_member_api_docs

const String _markdownData = '''
| 日期 日期日期日期日期日期日期日期日期日期日期      | 天气   | 温度  | 日期       | 天气   | 温度  | 日期       | 天气   | 温度  |
| ---------- | ------ | ----- | ---------- | ------ | ----- | ---------- | ------ | ----- |
| 2025-09-15 | 晴    | 281°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-16 | 多云   | 27°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | da雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |

''';

class CustomTableDemo extends StatelessWidget {
  const CustomTableDemo({super.key});

  static const String _title = 'Custom Table Demo';

  @override
  Widget build(BuildContext context) {
    var border = BorderSide(color: Colors.grey[200]!, width: 1);
    return Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: SafeArea(
          child: Markdown(
            shrinkWrap: true,
            data: _markdownData,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              tableHead:
                  TextStyle(fontWeight: FontWeight.w600, color: Color(0xff1A1A1A), fontSize: 15),
              tableHeadDecoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              tableHeadAlign: TextAlign.left,
              tableCellConstraints: BoxConstraints(maxWidth: 200),
              tableColumnWidth: IntrinsicColumnWidth(),
              tableBorder: TableBorder(
                horizontalInside: border,
                verticalInside: border,
              ),
            ),
            tableBuilder: (table) {
              return _buildTableConainer(table, context);
            },
          ),
        ));
  }

  Widget _buildTableConainer(Widget child, context) {
    return CSMDTableContanier(
      child: child,
    );
  }
}

class CSMDTableContanier extends StatelessWidget {
  final Widget child;
  const CSMDTableContanier({
    super.key,
    this.child = const MarkdownBody(data: _markdownData),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!, width: 1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(children: [
          Container(
            width: double.infinity,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)), // 只设置顶部圆角
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  '表格',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    // 复制表格内容到剪贴板
                    Clipboard.setData(ClipboardData(text: _markdownData));
                    print('负值成功');
                  },
                  icon: Icon(Icons.copy_all_rounded, size: 20, color: Colors.grey[700]),
                ),
                IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  onPressed: () async {
                    // 1. 设置横屏
                    await SystemChrome.setPreferredOrientations([
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight,
                    ]);
                    // 2. 跳转到全屏表格页面
                    await showDialog(
                      context: context,
                      useSafeArea: false,
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: const Text('全屏表格111'),
                          leading: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () async {
                              // 恢复竖屏
                              await SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitUp,
                                DeviceOrientation.portraitDown,
                              ]);
                              Navigator.of(context).pop();
                            },
                          ),
                          actions: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                // 复制传入的内容到剪贴板
                              },
                              icon: Icon(Icons.copy_all_rounded, size: 20, color: Colors.white),
                            ),
                            // IconButton(
                            //   padding: EdgeInsets.zero,
                            //   visualDensity: VisualDensity.compact,
                            //   onPressed: () {
                            //     // 将表格生成图片保存到相册
                            //   },
                            //   icon: Icon(Icons.copy_all_rounded, size: 20, color: Colors.white),
                            // ),
                          ],
                        ),
                        body: SafeArea(
                            child: SingleChildScrollView(
                          child: child,
                        )), // child 就是表格
                      ),
                    );
                    // 3. 恢复竖屏
                    await SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                      DeviceOrientation.portraitDown,
                    ]);
                  },
                  visualDensity: VisualDensity.compact,
                  icon: Icon(Icons.open_in_full_rounded, size: 20, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          child
        ]));
  }
}
