// ignore_for_file: prefer_const_constructors, must_be_immutable, no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Temp extends StatefulWidget {
  List temp;
  Temp({Key? key, required this.temp}) : super(key: key);
  @override
  _TempState createState() => _TempState(temp);
}

class _TempState extends State<Temp> {
  List temp;
  _TempState(this.temp);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints.expand(
          height:
              Theme.of(context).textTheme.headline4!.fontSize! * 0.5 + 300.0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(221, 255, 255, 255),
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfRadialGauge(
            title: GaugeTitle(
                borderWidth: 10,
                text: 'TEMPERATURE',
                textStyle: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold)),
            axes: <RadialAxis>[
              RadialAxis(
                showLastLabel: true,
                showAxisLine: true,
                axisLineStyle: AxisLineStyle(
                  cornerStyle: CornerStyle.bothCurve,
                  thickness: 0.1,
                  thicknessUnit: GaugeSizeUnit.factor,
                  gradient: const SweepGradient(colors: <Color>[
                    Color.fromARGB(255, 95, 195, 228),
                    Color.fromARGB(255, 229, 93, 135)
                  ], stops: <double>[
                    0.25,
                    0.75
                  ]),
                ),
                minimum: 10,
                maximum: 40,
                pointers: <GaugePointer>[
                  RangePointer(
                    value: temp[0],
                    enableAnimation: true,
                    gradient: const SweepGradient(colors: <Color>[
                      Color.fromARGB(255, 229, 93, 135),
                      Color.fromARGB(255, 95, 195, 228),
                    ], stops: <double>[
                      0.25,
                      0.75
                    ]),
                    cornerStyle: CornerStyle.bothCurve,
                  ),
                  NeedlePointer(
                    value: temp[0],
                    enableAnimation: true,
                    needleStartWidth: 1,
                    needleEndWidth: 3,
                    knobStyle: KnobStyle(
                        color: Colors.white,
                        knobRadius: 0.07,
                        borderColor: Colors.black,
                        borderWidth: 0.02),
                    tailStyle: TailStyle(
                        width: 2,
                        length: 20,
                        lengthUnit: GaugeSizeUnit.logicalPixel,
                        color: Colors.white,
                        borderWidth: 3,
                        borderColor: Colors.black),
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Text('${temp[0].toString()}  ํc',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      angle: 90,
                      positionFactor: 0.7)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
