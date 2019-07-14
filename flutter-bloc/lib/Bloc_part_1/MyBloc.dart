import 'dart:async';

class MyBloc {
  StreamController<double> controller = StreamController();
  
  Stream<double>  getStream() {
    return controller.stream;
  }
  
  doSum(double num1, double num2) {
    double a = num1 + num2;
    controller.sink.add(a);
  }
  
  void dispose() {
    controller.close();
  }
}