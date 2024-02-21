## Flutter

### Setup Dart

#### Install Dart SDK

```sh
yay -Sy dart-sdk-dev
```

#### Sample Dart Code

```dart
// test.dart
void main() {
  print('Hello, World!');
}
```

Run above code:

```sh
dart test.dart
```

### Download Flutter SDK

```sh
yay -Sy flutter
```

### Downloading Android SDK and Related Packages

```sh
yay -Sy android-sdk android-sdk-build-tools android-sdk-cmdline-tools-latest android-platform android-sdk-platform-tools android-sdk-emulator
```

```sh
cd ~
sudo groupadd android-sdk
sudo chown -R $(whoami):android-sdk /opt/android-sdk
```

#### Setting up emulator

- Install a system image for the emulator
```sh
sdkmanager "system-images;android-30;google_apis;x86_64"
```

- Verify the system image is installed
```sh
sdkmanager --list_installed
```

- Create an Android Virtual Device (AVD) using above system image
```sh
avdmanager create avd -n test -k "system-images;android-30;google_apis;x86_64" -d 1
```

**NOTE:** `1` is the device id for `Galaxy Nexus`
Check it out using `avdmanager list device`

- Check the list of AVDs
```sh
avdmanager list
```

- To remove an AVD
```sh
avdmanager delete avd -n test
```

- Create a new emulator
```sh
/opt/android-sdk/emulator/emulator -avd test
```

#### Setting Environment Variables

```sh
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
```

### Accepting Android Licenses

```sh
yes | flutter doctor --android-licenses
```

### Creating a Flutter Project

```sh
flutter create flutter_starter
```

### Running the Flutter Project
```sh
cd flutter_starter
flutter run
```

To run the app on an emulator, first start the emulator and then run the app.
```sh
/opt/android-sdk/emulator/emulator -avd test
```

### Building Flutter App

```sh
flutter run -d <device_id>
```

To list available devices:
```sh
flutter devices
```

```Sample
Found 2 connected devices:
  sdk gphone x86 64 (mobile) • emulator-5554 • android-x64 • Android 11 (API 30) (emulator)
  Linux (desktop)            • linux         • linux-x64   • Arch Linux 6.7.5-arch1-1
```

Then the `<device_id>` can be `emulator-5554` or `linux`.

#### Troubleshooting

##### You may encounter an error like this when running `flutter run`:
```sh
fatal: detected dubious ownership in repository at '/opt/flutter'
To add an exception for this directory, call:

        git config --global --add safe.directory /opt/flutter
Launching lib/main.dart on Linux in debug mode...
Building Linux application...
CMake Error at /usr/share/cmake/Modules/CMakeDetermineCXXCompiler.cmake:48 (message):
  Could not find compiler set in environment variable CXX:

  clang++.

Call Stack (most recent call first):
  CMakeLists.txt:3 (project)


CMake Error: CMAKE_CXX_COMPILER not set, after EnableLanguage
Exception: Unable to generate build files
```

**How to Fix**:

1. Install `clang`:

```sh
sudo pacman -S clang
```

2. Set `CXX` environment variable:
```sh
export CXX=clang++
```

## References

- [How to setup Flutter on Arch linux](https://medium.com/@rajgadhiya011/how-to-setup-flutter-on-arch-linux-with-android-sdk-a-step-by-step-guide-f40450b55669)
- [Discussion](https://www.reddit.com/r/neovim/comments/14c5e6o/how_to_set_up_dartflutter_with_neovim/)
- [Android Variables](https://developer.android.com/tools/variables#envar)
