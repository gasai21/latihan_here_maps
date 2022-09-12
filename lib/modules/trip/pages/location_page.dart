part of 'pages.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final SearchController c = Get.put(SearchController());
  List<SearchModelEntity> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xffE3E8F6),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              cardListAddressWidget(context),
              buttonRouteWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  // VARIABLE WIDGET
  Widget buttonRouteWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width - 2 * 24,
        decoration: BoxDecoration(
          color: Colors.blue[400],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          "Show Route",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget listAddressWidget() {
    return Column(
      children: data
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(top: 10),
              child: ListTile(
                title: Text(e.label),
                subtitle: Text(
                    "Lat: " + e.lat.toString() + " Lon: " + e.lon.toString()),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget buttonAddAddressWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: const Text(
            "+",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () async {
            final result = await Get.to(() => SearchPage());
            if (result != null) {
              setState(() {
                data = c.dataSearch;
              }); // call your own function here to refresh screen
            }
          },
          child: const SizedBox(
            child: Text("Add New Location"),
          ),
        )
      ],
    );
  }

  Widget cardListAddressWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 2 * 24,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            child: Text("Input Location"),
          ),
          Container(
            height: 2,
            width: double.infinity,
            color: Colors.black.withOpacity(0.1),
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          listAddressWidget(),
          buttonAddAddressWidget(),
        ],
      ),
    );
  }
}
