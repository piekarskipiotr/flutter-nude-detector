# flutter_nude_detector

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

An easy-to-use nudity detector build
with [google_mlkit_image_labeling][mlkit_pub_link] package and using a pre-build
.tflite model by [nipunru][nipunru_github]
from [nsfw-detector-android][nipunru_repo] repository.

### Installation

Add package to your flutter project

```
flutter pub add flutter_nude_detector
```

Download .tflite [model][model_link] and save it in:

```xpath
project/
    assets/
        ml_models/
            nude.tflite
```

Modify pubspec.yaml file

```yaml
flutter:
  assets:
    - assets/ml_models/
```

Now you are ready to use the package 🎉

### 🧑🏻‍💻 Usage

```dart
final imageFile = File(path);
final hasNudity = await FlutterNudeDetector.hasNudity(image: imageFile);
```

### Function properties — hasNudity

| Property name   | Type   | Description                                                             |
|-----------------|--------|-------------------------------------------------------------------------|
| image           | File   | required argument                                                       |
| threshold       | double | optional argument, default value is set to 0.7                          |
| modelAssetsPath | String | optional argument, default value is set to assets/ml_models/nude.tflite |

<!-- links -->

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://github.com/piekarskipiotr/flutter-nude-detector/blob/master/LICENSE
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[mlkit_pub_link]: https://pub.dev/packages/google_mlkit_image_labeling
[nipunru_github]: https://github.com/nipunru
[nipunru_repo]: https://github.com/nipunru/nsfw-detector-android
[model_link]: https://github.com/piekarskipiotr/flutter-nude-detector/raw/master/assets/ml_models/nude.tflite