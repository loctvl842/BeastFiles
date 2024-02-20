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
sudo cp -R /opt/android-sdk ~
```

```sh
cd ~
sudo groupadd android-sdk
sudo chown -R $(whoami):android-sdk android-sdk
```

#### Setting up emulator

- Install a system image for the emulator
```sh
sdkmanager "system-images;android-30;google_apis;x86_64"
```

- Create an Android Virtual Device (AVD) using above system image
```sh
avdmanager create avd -n test -k "system-images;android-30;google_apis;x86_64"
```

- Check the list of AVDs
```sh
avdmanager list
```

- Create a new emulator
```sh
emulator -avd test
```

#### Setting Environment Variables

```sh
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
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
