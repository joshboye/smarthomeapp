import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeapp/model/devices.dart';
import 'package:smarthomeapp/provider/temp_provider.dart';

class DevicesCarousel extends StatefulWidget {
  final int devices;

  DevicesCarousel({required this.devices});

  @override
  State<DevicesCarousel> createState() => _DevicesCarouselState();
}

class _DevicesCarouselState extends State<DevicesCarousel> {
  late PageController _pageController;
  TempProvider tempProvider = TempProvider();
  final Map<int, List<String>> items = Devices().deviceNameAndIcons;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.6);
    _pageController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        int nextIndex = _pageController.page!.round();
        print(nextIndex);
        Provider.of<TempProvider>(context, listen: false).changeindex(nextIndex);
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TempProvider>(
      builder: (context, tempProviderModel, child) => Container(
        height: 280.0,
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.devices,
          itemBuilder: (BuildContext context, int index) {
            return _buildCarouselItem(context, index, tempProviderModel);
          },
        ),
      ),
    );
  }

  Widget _buildCarouselItem(BuildContext context, int index, TempProvider tempProviderModel) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: AnimatedBuilder(
        animation: PageController(viewportFraction: 0.7),
        builder: (BuildContext context, Widget? child) {
          tempProviderModel.changeindex(index);
          return Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Center(child: _device(context, index, items, tempProviderModel)),
            ),
          );
        },
      ),
    );
  }

  Widget _device(BuildContext context, int index, Map<int, List<String>> items, TempProvider tempProviderModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color.fromARGB(255, 231, 229, 229),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(
                  items[index]![1],
                ),
              ),
            ),
            Positioned(
              bottom: 1,
              left: 110,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            items[index]![0],
            style: const TextStyle(color: Colors.black45, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 8,
            thumbShape: SliderComponentShape.noThumb,
          ),
          child: Slider(
            value: tempProviderModel.temp[index],
            activeColor: Colors.yellow,
            inactiveColor: Colors.transparent,
            onChanged: (double newvalue) {
              tempProviderModel.changeindex(index);
              tempProviderModel.changetemp(newvalue, index);
            },
            min: 15,
            max: 100,
          ),
        ),
      ],
    );
  }
}
