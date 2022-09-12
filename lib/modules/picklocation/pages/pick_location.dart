part of 'pages.dart';

class PickLocation extends StatelessWidget {
  PickLocation({Key? key}) : super(key: key);

  //inisialisasi
  final PickLocationController c = Get.put(PickLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: HereMap(
          onMapCreated: c.onMapCreated,
        ),
      ),
    );
  }
}
