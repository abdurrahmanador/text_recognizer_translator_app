# Text Recognition & Translation App 📱

A Flutter application that combines Google ML Kit's text recognition capabilities with MyMemory Translation API to extract and translate text from images.

## 🌟 Features

- **Image Text Recognition**: Extract text from images using Google ML Kit
- **Real-time Translation**: Translate extracted text to multiple languages using MyMemory API
- **Multiple Language Support**: Support for various languages through MyMemory API
- **No API Key Required**: Uses free tier of MyMemory Translation API


## 🚀 Getting Started

### Prerequisites

- Flutter (Latest Version)
- Android Studio / VS Code
- Android SDK
- iOS Development tools (for iOS deployment)

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_ml_kit: ^0.19.0
  get: ^4.6.6
  image_picker: ^1.1.2
  http: ^1.2.2
```

### Installation

1. Clone the repository
```bash
git clone https://github.com/abdurrahmanador/text_recognizer_translator_app
```

2. Navigate to project directory and install dependencies
```bash
cd text_recognizer
flutter pub get
```

3. Run the app
```bash
flutter run
```

## 🛠️ Technical Implementation

### Architecture

The app follows a clean architecture pattern using GetX for state management:

```
lib/
  ├── controllers/
  │   └── home_page_controller.dart
  ├── views/
  │   └── home_page_view.dart
  └── main.dart
```

### Key Components

1. **HomePageController**: Manages state and business logic
   - Image picking
   - Text recognition
   - Translation processing
   - Error handling

2. **HomePageView**: UI implementation
   - Image display
   - Text display
   - Translation controls
   - Loading indicators

## 🔄 How It Works

1. User selects an image from gallery
2. Google ML Kit processes the image and extracts text
3. Extracted text is sent to MyMemory Translation API
4. Translated text is displayed to user

## 🌍 Supported Languages

The app supports translation to various languages including:
- Bengali (bn)
- Hindi (hi)
- Arabic (ar)
- Spanish (es)
- French (fr)


## ⚠️ Limitations

- MyMemory API Free Tier Limits:
  - 5000 words per day
  - 500 requests per day
- Image quality affects text recognition accuracy
- Internet connection required for translation

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



## 🙏 Acknowledgments

- Thanks to Google ML Kit for text recognition capabilities
- MyMemory Translation API for translation services
- Flutter team for the amazing framework
- GetX library for state management solutions

## 📞 Contact

Abdur Rahman
abiabdullahinshaalloh@gmai.com

## 🐛 Known Issues

If you discover any bugs or issues, please report them in the issues section of this repository.
