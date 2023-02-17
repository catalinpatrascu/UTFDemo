# UTFDemo
Unit Testing Fundamentals Presentation Demo for `SwiftAnytime` Community

**Usage:**

1. Inside `SceneDelegate.swift` on line 22, just replace `factoryMathView` with `factoryWeatherView`, depending on which of the 2 demos you want to run.

2. Inside `APIKeys.swift` you can change the city used for the demo and also you need to add a valid API key from `openweathermap.org` for the WeatherDemo to work.

**Notes on the unit testing:**

1. The tests from within `WeatherServiceBadTests.swift` are disabled so that they aren't executed (consuming the daily API quota); just enable them back if you need them.

2. The `ViewModels` and `Services` from both demos have a code coverage of `100%`.

3. The tests are executed in parallel and random order for an extra layer of confidence regarding their atomic and independent behaviour.

4. Both `UIViewControllers` are not tested.

**Final note:**

Don't hesitate to reach me on Twitter on @cpatrascudev for any suggestions or updated for this codebase.
