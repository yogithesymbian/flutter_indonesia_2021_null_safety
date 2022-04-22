abstract class Cars {
  void drive();
}

class FlyingCar implements Cars {
  @override
  void drive() {
    // TODO: implement drive
  }
}

class BoatingCar implements Cars {
  @override
  void drive() {
    // TODO: implement drive
  }
}

class HuntingCar implements Cars {
  @override
  void drive() {
    // TODO: implement drive
  }
}

class CarRepository {
  void driveAction({required Cars cars}) {
    cars.drive();
  }
}

void main() {
  final _repository = CarRepository();
  _repository.driveAction(cars: FlyingCar());
}
