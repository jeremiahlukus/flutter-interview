# Otto Flutter Core Infrastructure
The Flutter Core will power services to be used by all Otto flutter products, currently it handles:
- HTTP API services
- Firebase service
- GraphQL service and any other service that needs communication to the outside world

# Folder Structure
This folder structure explains what goes into where, and help a new developer/testers easily navigate the project.

## **Config**
The `/config` folder is responsible for housing global configuration for the core infrastructure.
- **DI** - all dependency used in core are registered here and exposed to product through a top level function.
```dart
void setupDI()
```
- **service** - All service configuration goes in the service folder, currently we have the api configuration

## **Connectivity**
Checks the connectivity status of the device, if it is connected to the internet or not.

## **Service exception**
This class handles possible exceptions from service layer, this can be:
- ApiExceptions
- Firebase Exceptions
- GraphQl Exceptions

## **Service result**
The service result class are majorly used in product and will have 2 or more network response scenario (Success or failure), engineers can then decide what to do based of the scenario that is returned.

This is where freezed Union/Sealed classes come in Read more about Freezed, it goodies and the Unions/Sealed classes [here](https://pub.dev/packages/freezed#unionssealed-classes)

## **Services**
- **Api**
    - Dio Client
- **Firebase**
    - Auth Service <Firebase Authentication>
    - Firestore Service <Firebase Firestore>
    - Storage Service <Firebase Cloud Storage>
- **Local Storage**
    - Shared Preferences/Hive

## **Use cases**
Mixin class to handle use case classes on the domain layer of each product use case can eiather be an async/await future call or a listening to stream of data.

   The Use case is expected to have 2 generic types.

   - An `/Object` T which is the expected return type
   - A `/Parameter` Which is also an object which is the parameter the api expects.
