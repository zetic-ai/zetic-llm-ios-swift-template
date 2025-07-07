# Zetic LLM Template for iOS Swift App

A LLM iOS application template built with Swift, following current iOS development best practices.

## 📱 Project Structure

```
zetic-llm-ios-swift-template/
├── README.md
├── LICENSE
├── .gitignore
├── ZeticMLangeLLMSample/
│   ├── ContentView.swift
│   ├── ZeticMLangeLLMSampleApp.swift
│   ├── Core/
│   │   └── Constants
|   │   │   └── Constants.swift
│   ├── Domain/
│   │   └── Message.swift
│   ├── Views/
│   │   └── ChatBubble.swift
│   ├── ViewModel/
│   │   └── LLMChatViewModel.swift
│   └── Assets.xcassets/
│       ├── AppIcon.appiconset/
│       ├── AccentColor.colorset/
│       └── Contents.json
├── PodSpecs/
│   └── ZeticMLange.podspec
├── Podfile
├── Podfile.lock
└── AppName.xcodeproj/
```

## 🚀 Quick Start

### 1. Clone the Project

```bash
git clone https://github.com/zetic-ai/zetic-llm-ios-swift-template.git
cd zetic-llm-ios-swift-template
```

### 2. Install Dependencies

```bash
# Install CocoaPods if you haven't already
sudo gem install cocoapods

# Install project dependencies
pod install

# Open the workspace
open ZeticMLangeLLMSample.xcworkspace
```

### 3. Configure Credentials

Update your API credentials in `ZeticMLangeLLMSample/Core/Constants/Constants.swift`:
> If you have no token for SDK, Check [ZeticAI personal settings](https://mlange.zetic.ai/settings?tab=pat)

```swift
struct Constants {
    // TODO: Replace with your actual credentials
    struct MLANGE {
        static let personalAccessKey = "YOUR_PERSONAL_ACCESS_KEY"
        static let modelKey = "YOUR_MODEL_KEY"
    }
}
```

### 4. Customize App Details

#### Update Bundle Identifier
1. Open `ZeticMLangeLLMSample.xcworkspace` in Xcode
2. Select your project in the navigator
3. Under "General" tab, change:
   - **Display Name**: Your App Name
   - **Bundle Identifier**: com.yourcompany.appname

### 5. Build and Run

1. Open `ZeticMLangeLLMSample.xcworkspace` (NOT .xcodeproj)
2. Select your target device or simulator(**IOS only** NOT MACOS)
3. Press `Cmd + R` to build and run

## 📦 Dependencies

### Core Dependencies (via CocoaPods)
```ruby
# Podfile
target 'ZeticMLangeLLMSample' do
  use_frameworks!
  
  pod 'ZeticMLange', :podspec => './Podspecs/ZeticMLange.podspec'
end
```

## 🔧 Development Setup

### 1. Xcode Configuration
- Enable automatic code signing
- Set up your development team
- Configure provisioning profiles

## 📚 Documentation & Support

- [ZeticAI Guide](https://docs.zetic.ai) - Zetic AI Docs
- Feel free to ask us. Create an issue or mail to us([software@zetic.ai](mailto:software@zetic.ai))


## 📄 License

This project is licensed under the MIT License - see the [MIT LICENSE](LICENSE) file for details.
