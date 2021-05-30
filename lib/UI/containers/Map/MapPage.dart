import 'dart:async';

import 'package:cybergarden_app/UI/components/BottomSheets/CollectorBottomSheet.dart';
import 'package:cybergarden_app/UI/components/cards/CategoryCard.dart';
import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/UI/containers/Map/CollectorMarker.dart';
import 'package:cybergarden_app/UI/containers/Map/CollectorsList.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  List<CollectorModel> collectors = [];
  late StreamSubscription _subscription;
  late StreamSubscription _subscription2;

  final List filters = [
    'Все',
    'Для пластика',
    'Для стекла',
    'Для бумаги',
    'Для батареек'
  ];
  Set<Marker> _markers = {};
  int activeId = -1;
  bool openedFilters = false;

  toogleOpened() {
    this.setState(() {
      openedFilters = !openedFilters;
    });
  }

  late GoogleMapController mapController;
  String _mapStyle = "";
  final LatLng _center = const LatLng(45.521563, -122.677433);
  Location _location = Location();

  void onMarkerTap(CollectorModel collector) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(collector.point.lat, collector.point.long),
            zoom: 15),
      ),
    );
    this.setState(() {
      activeId = collector.id;
      init();
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(125.0),
          ),
          builder: (context) {
            return CollectorBottomSheet(context, collector);
          });
    });
  }

  void init() async {
    _markers.clear();
    var pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/collectorMarket.png');
    var pinLocationIconActive = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/collectorMarketActive.png');
    var collectorsModels = collectors;
    collectorsModels.forEach((collectorModel) {
      _markers.add(Marker(
          markerId: MarkerId(collectorModel.id.toString()),
          position: LatLng(collectorModel.point.lat, collectorModel.point.long),
          icon: activeId == collectorModel.id
              ? pinLocationIconActive
              : pinLocationIcon,
          onTap: () {
            onMarkerTap(collectorModel);
          }));
    });
    this.setState(() {
      _markers = _markers;
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
    var l = await _location.getLocation();
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
      ),
    );
    init();
  }

  @override
  void initState() {
    _subscription = collectorsBloc.collectors.listen((data) {
      this.setState(() {
        collectors = data;
      });
      init();
    });
    _subscription2 = collectorsBloc.activeCollector.listen((data) {
      onMarkerTap(data);
    });
    collectorsBloc.loadCollectors();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      this._mapStyle = string;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Icon(
              Icons.format_paint,
              color: UIIconColors.active,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    new CupertinoPageRoute(
                        builder: (context) => CollectorsList()));
              },
              child: new Icon(
                Icons.list,
                color: UIIconColors.active,
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            myLocationEnabled: true,
          ),
          Positioned(
              top: 10,
              left: 10,
              height: 33,
              width: displayWidth(context),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: openedFilters || activeId > 0
                        ? MiniGradientButton(
                            child: Text(
                              "Фильтры",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              this.setState(() {
                                toogleOpened();
                              });
                            })
                        : SecondaryButton(
                            child: Text(
                              "Фильтры",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              this.setState(() {
                                toogleOpened();
                              });
                            }),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: SecondaryButton(
                        child: Text(
                          "Только избранные",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {}),
                  )
                ],
              )),
          Positioned(
            top: 60,
            left: 10,
            height: 33,
            width: displayWidth(context),
            child: StreamBuilder(
              stream: collectorsBloc.activeFilter,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: openedFilters
                        ? [
                            for (var filterName in filters)
                              CategoryCard(
                                name: filterName,
                                active: snapshot.data ==
                                    filters.indexOf(filterName),
                                onPressed: () {

                                  collectorsBloc
                                      .setActive(filters.indexOf(filterName));

                                },
                              )
                          ]
                        : [],
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    _subscription2.cancel();
    super.dispose();
  }
}
