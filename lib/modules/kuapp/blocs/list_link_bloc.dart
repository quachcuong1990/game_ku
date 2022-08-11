import 'package:demo_bloc_ku/modules/kuapp/repos/list_links_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../models/link.dart';
class ListLinkRxDartBloc{
  final _linkControler = BehaviorSubject<Links>.seeded(Links());
  Stream<Links> get linksStream => _linkControler.stream;
  Future<void> getLinks()async{
    try{
      final res = await LinkRepo().getLink();
      if(res!=null){
        _linkControler.sink.add(res);
      }
    }catch(e){
      print('e123 : $e');
      _linkControler.sink.addError('error link');
    }
  }
}