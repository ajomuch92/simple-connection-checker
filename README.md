# Simple Connection Checker

A simple package to check when the device is connected (connectivity) to internet. Also provide a method to listen for connection status changes.

## Demo
<img src="https://raw.githubusercontent.com/ajomuch92/simple-connection-checker/master/assets/demo.gif" width="200" height="429"/>

## Instalation
Include `simple_connection_checker` in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  simple_connection_checker: version
```

## Usage

To use this package, just import it into your file and call the static method *isConnectedToInternet* as follows:

```dart
import 'package:simple_connection_checker/simple_connection_checker.dart';

...

bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();

...

```

**Note**: You can pass an optional parameter named *lookUpAddress* to pass an especific URL to make the lookup operation and check the internet connection. By default, this value is *www.google.com*. Do not use the protocol on the URL string passed (http:// or https://).

## New 💥

Now you can listen for internet connection changes. Here is the example

```dart
import 'package:simple_connection_checker/simple_connection_checker.dart';

...
StreamSubscription? subscription;
bool? _connected;

@override
void initState() {
  super.initState();
  SimpleConnectionChecker _simpleConnectionChecker = SimpleConnectionChecker()
      ..setDuration(Duration(seconds: 1)) // Optional method to pass a duration for every checking loop
      ..setLookUpAddress('pub.dev'); //Optional method to pass the lookup string
  subscription = _simpleConnectionChecker.onConnectionChange.listen((connected) {
    setState(() {
      _connected = connected;
    });
  });
}

@override
void dispose() {
  subscription?.cancel();
  super.dispose();
}

...

```

**Note**: Don't forget to cancel the subscription

# Demo
<img src="https://raw.githubusercontent.com/ajomuch92/simple-connection-checker/master/assets/demo-listen.gif" width="200" height="429"/>