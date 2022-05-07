import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_task/exception/launch_stream_exception.dart';
import 'package:url_launcher/url_launcher.dart';

// using riverpod Stream provider to provide a stream of launch result (point #3)
final launchStreamProvider = StreamProvider((ref) => launchStream());

/// a function to map between the sampleStream data and filter the data as
///  - if AsyncValue from sampleStream have no data return an empty Stream.
///   - if AsyncValue from sampleStream have data run launchUrl and return it's value.
///   - if returned value is false then throw LaunchUrlException
Stream<AsyncValue<void>> launchStream() async* {
  await for (final value in sampleStream) {
    // stream value has no data or null
    if (value.value == null || value.value == '') {
      yield const AsyncValue.data(null);
    } else {
      // calling launchUrl and wait for the result
      var result = await launchUrl(
        Uri.parse(
          value.value!,
        ),
      );

      // if true then it success opened the url
      if (result) {
        yield AsyncData(result);
      } else {
        // if false then throw a LaunchUrlException with a message
        throw LaunchUrlException('the url ${value.value} is not valid');
      }
    }
  }
}

// a mockup provided in the test note that also can simulate a stream of urls
late final Stream<AsyncValue<String>> sampleStream = Stream.value(null).map((_) {
  return const AsyncValue.data('https://google.com');
});
