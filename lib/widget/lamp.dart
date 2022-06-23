import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Lamp extends StatefulWidget {
  const Lamp({Key? key}) : super(key: key);

  @override
  State<Lamp> createState() => _LampState();
}

class _LampState extends State<Lamp> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          width: 160,
          height: 120,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Text(
                name[0],
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              ToggleSwitch(
                changeOnTap: false,
                animationDuration: 300,
                minWidth: 60,
                minHeight: 40.0,
                initialLabelIndex: db[0],
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                icons: const [
                  Icons.lightbulb_outline,
                  Icons.lightbulb,
                ],
                totalSwitches: 2,
                iconSize: 30.0,
                activeBgColors: const [
                  [Colors.black45, Colors.black26],
                  [Colors.yellow, Colors.orange]
                ],
                animate: true,
                curve: Curves.bounceInOut,
                onToggle: (value) async {
                  try {
                    if (db[2] == 1) {
                      context.read<LoadingProvider>().setLoad(true);
                      await wdb.update({name[0]: value});
                      context.read<LoadingProvider>().setLoad(false);
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please select manual mode!',
                          gravity: ToastGravity.CENTER);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              ToggleSwitch(
                changeOnTap: false,
                animationDuration: 300,
                radiusStyle: true,
                minWidth: 60,
                minHeight: 20.0,
                initialLabelIndex: db[2],
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                activeBgColors: const [
                  [Colors.green, Colors.amberAccent],
                  [Colors.green, Colors.amberAccent],
                ],
                totalSwitches: 2,
                labels: const ['AUTO', 'MANUAL'],
                fontSize: 8,
                iconSize: 30.0,
                animate: true,
                curve: Curves.bounceInOut,
                onToggle: (value) async {
                  try {
                    context.read<LoadingProvider>().setLoad(true);
                    await wdb.update({name[2]: value});
                    context.read<LoadingProvider>().setLoad(false);
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          width: 160,
          height: 120,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Text(
                name[1],
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              ToggleSwitch(
                changeOnTap: false,
                animationDuration: 300,
                minWidth: 60,
                minHeight: 40.0,
                initialLabelIndex: db[1],
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                icons: const [
                  Icons.flash_off_rounded,
                  Icons.flash_on_rounded,
                ],
                totalSwitches: 2,
                iconSize: 30.0,
                activeBgColors: const [
                  [Colors.black45, Colors.black26],
                  [Colors.yellow, Colors.orange]
                ],
                animate: true,
                curve: Curves.bounceInOut,
                onToggle: (value) async {
                  try {
                    if (db[3] == 1) {
                      context.read<LoadingProvider>().setLoad(true);
                      await wdb.update({name[1]: value});
                      context.read<LoadingProvider>().setLoad(false);
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please select manual mode!',
                          gravity: ToastGravity.CENTER);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              ToggleSwitch(
                changeOnTap: false,
                animationDuration: 300,
                radiusStyle: true,
                minWidth: 60,
                minHeight: 20.0,
                initialLabelIndex: db[3],
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                activeBgColors: const [
                  [Colors.green, Colors.amberAccent],
                  [Colors.green, Colors.amberAccent],
                ],
                totalSwitches: 2,
                labels: const ['AUTO', 'MANUAL'],
                fontSize: 8,
                iconSize: 30.0,
                animate: true,
                curve: Curves.bounceInOut,
                onToggle: (value) async {
                  try {
                    context.read<LoadingProvider>().setLoad(true);
                    await wdb.update({name[3]: value});
                    context.read<LoadingProvider>().setLoad(false);
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
