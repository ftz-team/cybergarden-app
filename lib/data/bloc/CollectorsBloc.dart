import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:rxdart/rxdart.dart';

class CollectorsBloc{

  final List filters = ["Все", "Сбор бумаги", "Сбор батареек"];

  List <CollectorModel> _collectors= [];
  CollectorsBloc(){
    _activeFilter.add(0);
  }

  final _activeFilter = PublishSubject<int>();
  Stream<int> get activeFilter => _activeFilter.stream;


  final _collectorsFetcher = PublishSubject<List<CollectorModel>>();
  Stream<List<CollectorModel>> get collectors => _collectorsFetcher.stream;

  loadCollectors() async{
    _collectors = await getCollectors();
    _collectorsFetcher.add(_collectors);
  }

  setActive(int active) async{
    _activeFilter.add(active);
  }





}

CollectorsBloc collectorsBloc = new CollectorsBloc();