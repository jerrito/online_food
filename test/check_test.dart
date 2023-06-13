import 'package:flutter_test/flutter_test.dart';
import 'package:online_food/check.dart';

void main() {
  test('Check value should add up', () {
    var check = Check();
    check.add();
    expect(check.i, 2);
  });

  test('check should decrease value to zero', () {
    var check = Check();
    check.minus();
    expect(check.i, 0);
  });
  group('Check', () {
    test('check is 1', () {
      final check = Check();
      check.i;
      expect(check.i, 1);
    });
  });
}
