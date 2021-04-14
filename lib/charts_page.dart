import 'package:flutter/cupertino.dart';
import 'package:meet_flut/components/charts/charts_bloc.dart';
import 'package:meet_flut/components/charts/line_charts.dart';
import 'package:meet_flut/components/charts/line_charts_ex.dart';

class ChartsPage extends StatelessWidget {
  final _processNumBloc = ChartsBloc(
    timeStart: DateTime.now().subtract(Duration(days: 3)),
      baseUrl:
          "https://spmmon.51zcm.cc/api/datasources/proxy/1/api/v1/query_range?query=sum%20by%20(node)%20(kubelet_running_container_count)");
  final _memoryBloc = ChartsBloc(
      timeStart: DateTime.now().subtract(Duration(days: 3)),
      baseUrl:
          "https://spmmon.51zcm.cc/api/datasources/proxy/1/api/v1/query_range?query=avg%20by%20(node%2C%20device)%20(node_filesystem_free_bytes%7Bdevice!~%22HarddiskVolume.%2B%22%7D)");
  final _totalBloc = ChartsBloc(
      timeStart: DateTime.now().subtract(Duration(days: 3)),
      baseUrl:
          "https://spmmon.51zcm.cc/api/datasources/proxy/1/api/v1/query_range?query=sum%20(container_memory_working_set_bytes%7Bcontainer_name!%3D%22%22%2Ccontainer_name!%3D%22POD%22%7D)%20*%20100%20%2F%20sum(node_memory_MemTotal_bytes)%20",
      combineBaseUrl:
          "https://spmmon.51zcm.cc/api/datasources/proxy/1/api/v1/query_range?query=sum%20(rate(container_cpu_usage_seconds_total%7Bcontainer_name!%3D%22%22%2Ccontainer_name!%3D%22POD%22%7D%5B5m%5D))");

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: ApmLineChart.useFlChart(
                  _processNumBloc,
                  title: "进程数",
                ),
              ),
              Expanded(
                child: ApmLineChart.useFlChart(
                  _memoryBloc,
                  title: "磁盘使用情况",
                  yMapper: (value) => value / 1024 / 1024 / 1024,
                ),
              ),
            ],
          )),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: ApmLineChart.useFlChart(
                _totalBloc,
                title: "环境变化趋势概览",
              ))
            ],
          )),
          Expanded(child: SizedBox())
        ],
      );
}
