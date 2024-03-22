import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Body(maxNumber: maxNumber),
              _Footer(
                onButtonPressed: onButtonPressed,
                onSliderChanged: OnSliderChanded,
                maxNumber: maxNumber,
              )
            ],
          ),
        ),
      ),
    );
  }

  void OnSliderChanded(double val) {
    setState(() {
      maxNumber = val; //선언한 maxNumber 변수에 들어온 val값을 넘겨준다,
      //슬라이더를 움직일때마다(onchanged 가 불릴때 마다) 새로운 build를 그려줘야해서 setState를 사용한다
    });
  }

  void onButtonPressed() {
    Navigator.of(context).pop(maxNumber
        .toInt()); //뒷 페이지로 가는것, parameter 값으로 maxNumber를 Toint값으로 변경해서 넘겨주고 있음
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({
    required this.maxNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: maxNumber
            .toInt()
            .toString()
            .split('')
            .map(
              (e) => Image.asset(
                'asset/img/$e.png',
                width: 50.0,
                height: 70.0,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double>? onSliderChanged;
  final VoidCallback onButtonPressed;

  const _Footer({
    required this.onSliderChanged,
    required this.maxNumber,
    required this.onButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value:
              maxNumber, //build 실행이 되면 setState도 재실행이 된다. 될때마다 새로운 값이 들어간다. 변경된 maxNumber의 값으로 새로 불린다
          min: 1000,
          max: 100000,
          onChanged: onSliderChanged,
        ), //val을 어디에 저장해둬야 사용이 가능하다
        ElevatedButton(
          onPressed: onButtonPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: redcolor,
            foregroundColor: Colors.white,
          ),
          child: Text('저장!'),
        ),
      ],
    );
  }
}
