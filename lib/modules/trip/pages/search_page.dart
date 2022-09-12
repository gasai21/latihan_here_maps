part of 'pages.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  //inisialisasi
  final SearchController c = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: const Color(0xffE3E8F6),
          child: Column(
            children: [
              navigatowWidget(context),
              const SizedBox(height: 10),
              hereMapsWidget(context),
              const SizedBox(height: 10),
              buttonSelectWidget(context),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // SET WIDGET
  Widget navigatowWidget(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: const SizedBox(
              child: Icon(Icons.arrow_back),
            ),
          ),
          const SizedBox(width: 10),
          Theme(
            data: ThemeData(
              primaryColor: Colors.redAccent,
              primaryColorDark: Colors.red,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width - 2 * 20 - 10 - 30,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: autocompleteWidget(),
            ),
          )
        ],
      ),
    );
  }

  Widget autocompleteWidget() {
    return TypeAheadField<SearchModelEntity?>(
      key: c.formKey,
      textFieldConfiguration: TextFieldConfiguration(
        controller: c.alamatController,
        autofocus: false,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: "Input Alamat",
          labelStyle: TextStyle(color: Colors.black38),
          border: InputBorder.none,
        ),
      ),
      suggestionsCallback: (pattern) async {
        return (pattern == "")
            ? []
            : await SearchService.doSearchLocation2(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: Text((suggestion!.label != null) ? suggestion.label : "-"),
        );
      },
      onSuggestionSelected: (suggestion) {
        c.alamatController.text = suggestion!.label;
        c.myGeoCoordinates = GeoCoordinates(suggestion.lat, suggestion.lon);
        c.addMapMarker(c.myGeoCoordinates);
      },
    );
  }

  Widget hereMapsWidget(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width - 2 * 14,
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: HereMap(
        onMapCreated: c.onMapCreated,
      ),
    );
  }

  Widget buttonSelectWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.back(result: "testtt");
        // Get.off(() => const LocationPage());
        c.addAddressToList();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width - 2 * 14,
        decoration: BoxDecoration(
          color: Colors.blue[400],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          "Pilih Alamat",
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

  // void _navigateAndRefresh(BuildContext context) async {
  //   final result = await Get.to(() => LocationPage());
  //   if (result != null) {
  //     print("ini hasilnyaa" +
  //         result); // call your own function here to refresh screen
  //   }
  // }
}
