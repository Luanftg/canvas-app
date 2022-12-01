import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/views/components/custom_bottom_navigation_bar.dart';
import 'package:flutter_application_1/src/views/components/custom_drawer.dart';
import 'package:flutter_application_1/src/views/pages/circular_canvas_page.dart';
import 'package:flutter_application_1/src/views/pages/custom_linear_chart.dart';
import 'package:flutter_application_1/src/views/pages/todo_list_page.dart';
import 'package:flutter_application_1/src/views/widgets/donut_chart_widget.dart';
import 'package:flutter_application_1/src/views/widgets/one_page.dart';
import 'package:flutter_application_1/src/views/widgets/radial_progress_widget.dart';

import '../../model/data_item.dart';
import 'blob_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double percentage = 100;
  int indexPage = 0;
  final PageController pageController = PageController();

  //generate data for LinearChart
  var random = Random();

  //generate data for pieChart
  List<DataItem> dataset = [
    DataItem(value: 0.3, label: 'Home', color: Colors.green),
    DataItem(value: 0.2, label: 'Transport', color: Colors.amber),
    DataItem(value: 0.4, label: 'Studies', color: Colors.blue),
    DataItem(value: 0.1, label: 'Others', color: Colors.red),
  ];
  @override
  Widget build(BuildContext context) {
    var data =
        List<double>.generate(100, (index) => random.nextDouble() * 100.0);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'App do Murílo',
            textAlign: TextAlign.center,
          ),
        ),
        drawer: CustomDrawer(indexPage, pageController: pageController),
        body: PageView(
          controller: pageController,
          children: [
            const OnePage(),
            const TodoListPage(),
            const CircularCanavasPage(),
            DonutChartWidget(dataset: dataset),
            RadialProgressWidget(percentage),
            const BlobPage(),
            CustomLinearChart(data),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          indexPage,
          controller: pageController,
        ));
  }
}
