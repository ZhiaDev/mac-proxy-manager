# MacOS Proxy Manager
 <image src="https://raw.githubusercontent.com/ZhiaDev/mac-proxy-manager/master/assets/github-proxy-manager-cover.jpg">

## About
Proxy Manager is a Flutter application for managing proxy settings on your MacOS MenuBar.  It allows you to easily enable or disable HTTP, HTTPS, and SOCKS proxy settings with a single click.

## Features

- Easily configure and enable/disable HTTP, HTTPS, and SOCKS proxies.
- Bypass Proxy Management - Set and clear custom bypass list.
- User-friendly interface for managing proxy settings.
- Real-time status indicators for proxy connections.
- Timer functionality to track proxy usage time.
- Simple and efficient.

## Details

- **MVC design pattern**: for separation of concerns and maintainability.
- **GetX for state management**: for efficient and reactive state management.
- **System commands via** `Process.run()`: to manage mac proxy settings.
- `audioplayers` **package**: for implementing click sounds.
- `google_fonts` **package**: to customize the app's fonts.
- **Designed with** `Figma`: for a user-friendly and visually appealing interface.


## Getting Started

### 🔗 Download: 
You can download the latest release of the app by clicking the button below:

<a href="https://github.com/ZhiaDev/mac-proxy-manager/releases/download/v1.0.0/Proxy-Manager-macos-universal.dmg">
  <img src="https://raw.githubusercontent.com/ZhiaDev/mac-proxy-manager/master/assets/github-download-for-macos.png" width=200>
</a>

</br>

### 🛠 Build: 
To build the app on your system, follow these steps:
```
git clone --depth 1 https://github.com/ZhiaDev/mac-proxy-manager.git
cd mac-proxy-manager
flutter pub get
flutter run
```

## Support

If you like this project, please ⭐ it and share with friends! For questions or assistance, [open an issue here](https://github.com/ZhiaDev/mac-proxy-manager/issues).

## License

You are free to use this code under the [MIT License](LICENSE).
