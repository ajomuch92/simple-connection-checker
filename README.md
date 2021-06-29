# Simple Connection Checker

A simple package to check when the device is connected to internet.

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

**Note**: You can pass an optional parameter named *lookUpAddress* to pass an especific URL to make the lookup operation and check the internet connection.