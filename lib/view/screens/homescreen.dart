import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeapp/model/devices.dart';
import 'package:smarthomeapp/provider/temp_provider.dart';
import 'package:smarthomeapp/view/widgets/devices_carousal.dart';

class HomeScreen extends StatelessWidget {
  final Map<int, String> itemimages = Devices().deviceImages;
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TempProvider>(
      builder: (context, tempProviderModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: _noiseFilter(context, BoxFit.cover),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromRGBO(107, 147, 118, 1),
        body: SafeArea(
          child: Stack(
            children: [
              _noiseFilter(context, BoxFit.fill),
              Positioned(
                  top: 80,
                  left: -150,
                  child: Image.asset(
                    itemimages[tempProviderModel.index]!,
                    width: 1000,
                    height: 500,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _backbutton(context),
                      _settingsbutton(context),
                    ],
                  ),
                  _officeText(context),
                  _deviceConnected(context, tempProviderModel.temp.length),
                  _temperature(context, tempProviderModel.temp[tempProviderModel.index].toInt()),
                  _devicecarousal(context, tempProviderModel.temp.length)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingsbutton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.settings,
            size: 40,
            color: Colors.white,
          )),
    );
  }

  Widget _backbutton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Widget _officeText(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 5, left: 50),
      child: Text(
        'Office',
        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _noiseFilter(BuildContext context, BoxFit fit) {
    return Opacity(
      opacity: 0.35,
      child: Image.asset(
        'assets/images/noisy-background.jpg',
        height: double.infinity,
        width: double.infinity,
        fit: fit,
      ),
    );
  }

  Widget _deviceConnected(BuildContext context, int temp) {
    return Padding(
      padding: EdgeInsets.only(left: 50),
      child: Text(
        '$temp devices active',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white),
      ),
    );
  }

  Widget _temperature(BuildContext context, int temp) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, top: 10),
      child: Container(
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(253, 155, 80, 1),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Image.asset('assets/icons/tempicon.png'),
            ),
            Text(
              "$temp\u2103",
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _devicecarousal(BuildContext context, int devices) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: DevicesCarousel(devices: devices),
    );
  }
}
