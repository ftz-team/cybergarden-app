import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:rxdart/rxdart.dart';

class CollectorsBloc{

  List <CollectorModel> _collectors= [];
  CollectorsBloc(){}

  final _collectorsFetcher = PublishSubject<List<CollectorModel>>();
  Stream<List<CollectorModel>> get collectors => _collectorsFetcher.stream;

  loadCollectors() async{
    _collectors = await getCollectors();
    _collectorsFetcher.add(_collectors);
  }

}

CollectorsBloc collectorsBloc = new CollectorsBloc();