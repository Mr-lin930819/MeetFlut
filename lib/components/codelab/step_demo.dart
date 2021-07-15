import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StepDemoState();
}

class _StepDemoState extends State<StepDemo> {
  int _currentStep = 0;
  final List<int> stepIndexList = List.generate(5, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("步骤组件"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        height: 96,
        child: Row(
          children: stepIndexList
              .map((e) => _Step(
                    "${e + 1}",
                    e <= _currentStep,
                    stepPosition: _getPosition(e),
                    onStepTap: () {
                      setState(() {
                        _currentStep = e;
                      });
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  _StepPosition _getPosition(int index) {
    if (index == 0) {
      return _StepPosition.head;
    }
    if (index == stepIndexList.length - 1) {
      return _StepPosition.tail;
    }
    return _StepPosition.middle;
  }
}

enum _StepPosition { head, middle, tail }

class _Step extends StatelessWidget {
  final String stepName;
  final bool isCompleted;
  final _StepPosition stepPosition;
  final VoidCallback? onStepTap;

  _Step(this.stepName, this.isCompleted,
      {this.stepPosition = _StepPosition.middle, this.onStepTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onStepTap?.call(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildStepIcon(isCompleted, stepPosition),
            Spacer(),
            Text(
              stepName,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            )
          ],
        ),
      ),
      flex: 1,
    );
  }

  Widget _buildStepIcon(bool isCompleted, _StepPosition position) {
    Color lineColor =
        isCompleted ? Colors.blue : Colors.grey[300] ?? Colors.grey;
    Color fillColor =
        isCompleted ? Colors.white : Colors.grey[300] ?? Colors.grey;
    final duration = Duration(milliseconds: 300);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Offstage(
            offstage: position == _StepPosition.head,
            child: AnimatedContainer(
              height: 5,
              duration: duration,
              decoration: BoxDecoration(color: lineColor),
            ),
          ),
        ),
        AnimatedContainer(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: fillColor,
              border: Border.all(color: lineColor, width: 4)),
          duration: duration,
        ),
        Expanded(
          flex: 1,
          child: Offstage(
            offstage: position == _StepPosition.tail,
            child: AnimatedContainer(
              height: 5,
              decoration: BoxDecoration(color: lineColor),
              duration: duration,
            ),
          ),
        ),
      ],
    );
  }
}
