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
yay -Sy android-sdk android-sdk-build-tools android-sdk-cmdline-tools-latest android-platform android-sdk-platform-tools
```

```sh
sudo cp -R /opt/android-sdk ~
```

```sh
cd ~
sudo goroupadd android-sdk
sudo chown -R loc:android-sdk android-sdk
```

#### Setting Environment Variables

```sh
export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
```

## References

- [How to setup Flutter on Arch linux](https://medium.com/@rajgadhiya011/how-to-setup-flutter-on-arch-linux-with-android-sdk-a-step-by-step-guide-f40450b55669)
- [Discussion](https://www.reddit.com/r/neovim/comments/14c5e6o/how_to_set_up_dartflutter_with_neovim/)
