# Project Architecture

TrainKoi is composed of a backend and a frontend side. Backend is responsible for storing realtime locations of all the trains,running a graph algorithm for creating a route ,calculating required distance and estimated time between the train and the stations.
And the frontend to allow the user to query their desired train locations and view the route , required distance , estimated time and the nearest stations.


## Prequisities

- Android studio version >= 4.0
- Download Flutter SDK files. [Click Here](https://flutter.dev/docs/development/tools/sdk/releases)
- Setup Dart & Flutter plugin from android studio

## Project Installation Guide:
- After opening the project you might have to configure the flutter SDK path.

- Install all the required plugins using below command.
```
$ pub get
```
Make sure you are on the path where the pubspec.yaml exists.

- Clean build caches using below command-
```
$ flutter clean
```
-  run the project and you are good to go... :)


##### Run Flutter Doctor.[Optional]
```
$ flutter doctor
```
Use above command use to see if there any platform dependencies need to complete the setup.
You can also run this command from android studio IDE.

## References

-  [Google Map API documentation for flutter](https://blog.codemagic.io/creating-a-route-calculator-using-google-maps/ )








