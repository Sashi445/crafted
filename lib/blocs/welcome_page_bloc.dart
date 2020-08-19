import 'dart:async';

class WelcomeBloc{

  bool setData = false;

  StreamController<bool> _controller = StreamController();

  Stream get screenController => _controller.stream;

  void screenChanger(){

    _controller.sink.add(setData);
    Future.delayed(Duration(seconds: 1)).then((value) => _controller.sink.add(!setData));
  }

}