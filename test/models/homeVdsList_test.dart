import 'package:flutter_test/flutter_test.dart';
import 'package:yt_popular/models/homeVdsList.dart';

void main() {
  group('get readable duration', () {
    test('GIVEN iso format, WHEN convert it to readable format, THEN duration',
        () {
      //INITIAL ARRANGE
      HomeVdsList hvl = new HomeVdsList();

      //all one digit
      String isoData = "PT1H3M7S";
      //ACT
      isoData = hvl.getReadableDuration(isoData);
      //ASSERT
      expect(isoData, "1h:3m:7s");

      //all two digits
      isoData = "PT10H30M27S";
      //ACT
      isoData = hvl.getReadableDuration(isoData);
      //ASSERT
      expect(isoData, "10h:30m:27s");

      //only m and s
      isoData = "PT3M27S";
      //ACT
      isoData = hvl.getReadableDuration(isoData);
      //ASSERT
      expect(isoData, "3m:27s");

      //only s
      isoData = "PT27S";
      //ACT
      isoData = hvl.getReadableDuration(isoData);
      //ASSERT
      expect(isoData, "27s");
    });
  });

  group('shorten statistics count', () {
    test('GIVEN count, WHEN shorten it, THEN count', () {
      //INITIAL ARRANGE
      HomeVdsList hvl = new HomeVdsList();

      String count = "0";
      //ACT
      count = hvl.shortenCount(count);
      //ASSERT
      expect(count, "0");

      //ARRANGE
      count = "999";
      //ACT
      count = hvl.shortenCount(count);
      //ASSERT
      expect(count, "999");

      //ARRANGE
      count = "1222";
      //ACT
      count = hvl.shortenCount(count);
      //ASSERT
      expect(count, "1.2 K");

      //ARRANGE
      count = "999999";
      //ACT
      count = hvl.shortenCount(count);
      //ASSERT
      expect(count, "999.9 K");

      //ARRANGE
      count = "1999999";
      //ACT
      count = hvl.shortenCount(count);
      //ASSERT
      expect(count, "1.99 M");

      //ARRANGE
      count = "221999999";
      //ACT
      count = hvl.shortenCount(count);
      //ASSERT
      expect(count, "221.99 M");

      //ARRANGE
      count = "999999999";
      //ACT
      count = hvl.shortenCount(count);
      //ASSERT
      expect(count, "999.99 M");

      //ARRANGE
      count = "2999999999";
      //ACT
      count = hvl.shortenCount(count);
      //ASSERT
      expect(count, "2.99 B");
    });
  });
}
