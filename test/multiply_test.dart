import 'package:flutter_test/flutter_test.dart';
import 'package:online_food/multiply.dart';

void main() {
  test("Testing multiplication", () {
    final multiple = Multiply();
    var m = multiple.multiply(10, 3);

    expect(m, 20);
  });
}
