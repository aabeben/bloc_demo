import 'dart:async';

// create enum for button event
enum ButtonEvent {
  increment,
  decrement,
  reset,
}

class CounterBloc {
  int counter = 0;
  final _stateStreamController = StreamController<int>();

  CounterBloc() {
    _eventStream.listen((event) {
      // decide what to do based on button event
      switch (event) {
        case ButtonEvent.increment:
          counter++;
          break;
        case ButtonEvent.decrement:
          counter--;
          break;
        case ButtonEvent.reset:
          counter = 0;
      }
      // use the value of counter or adding it to another stream controller
      // in this case state stream controller
      _counterSink.add(counter);
    });
  }

  StreamSink<int> get _counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  // create another stream controller for the event

  final _eventStreamController = StreamController<ButtonEvent>();
  // create event sink
  StreamSink<ButtonEvent> get eventSink => _eventStreamController.sink;

  // create event stream
  Stream<ButtonEvent> get _eventStream => _eventStreamController.stream;

  void dispose() {
    // close any instance of stream controller
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
