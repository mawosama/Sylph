# Sylph — Weather & Air

A beautiful weather and air quality app with personality.

## ✨ Features

### Core Functionality ✅
- **Live Weather Data** from OpenWeatherMap API
- **Air Quality Index (AQI)** from WAQI API
- **Real-time Updates** with automatic refresh every 10 minutes
- **Temperature Unit Toggle** (°C / °F)
- **Search History** with local storage (last 20 cities)
- **Detailed Metrics**: Humidity, wind speed, visibility, pressure, UV index

### New Features Added ✅
- **Local Notifications**: 
  - Weather update notifications
  - AQI alerts for unhealthy air quality
  - Scheduled weather check reminders
- **Secure API Key Management**:
  - Uses `--dart-define` environment variables
  - No hardcoded credentials
  - GitHub Secrets integration ready
- **Professional Branding**:
  - Clean "Sylph" logo with proper typography
  - Custom Boldonse font for display text
  - Material Design 3 UI
  - Dark theme with lime green & cyan accents

## 🛠 Built With

- **Flutter** - Cross-platform mobile framework
- **OpenWeatherMap API** - Weather data
- **WAQI API** - Air quality data
- **flutter_local_notifications** - Push notifications
- **shared_preferences** - Local data persistence
- **connectivity_plus** - Network connectivity checks

## 📋 Setup Instructions

### 1. **Clone & Install Dependencies**
```bash
git clone https://github.com/jhon4working/Sylph.git
cd Sylph
flutter pub get
```

### 2. **Get API Keys**

#### OpenWeatherMap
1. Visit: https://openweathermap.org/api
2. Sign up for a free account
3. Get your API key from the dashboard

#### WAQI (Air Quality)
1. Visit: https://waqi.info/api/
2. Register for an account
3. Get your API key

### 3. **Build & Run**

#### Option A: Run with Environment Variables (Recommended)
```bash
flutter run \
  --dart-define=OWM_KEY=your_openweather_api_key \
  --dart-define=WAQI_KEY=your_waqi_api_key
```

#### Option B: Build Release APK
```bash
flutter build apk --release \
  --dart-define=OWM_KEY=your_openweather_api_key \
  --dart-define=WAQI_KEY=your_waqi_api_key
```

#### Option C: GitHub Actions CI/CD
1. Add secrets in **Settings → Secrets and variables → Actions**:
   - `OWM_KEY` = your OpenWeatherMap API key
   - `WAQI_KEY` = your WAQI API key
2. Secrets are used automatically in GitHub Actions workflows

## 📱 Permissions Required (Android)

- `INTERNET` - API calls
- `ACCESS_NETWORK_STATE` - Network connectivity
- `POST_NOTIFICATIONS` - Local notifications (Android 13+)
- `SCHEDULE_EXACT_ALARM` - Scheduled weather checks

## 🎨 UI Features

### Home Screen
- Large city name display
- Current temperature with "feels like"
- Weather description
- Local time in the selected city
- Metrics grid (humidity, wind, visibility, pressure, UV index)

### Air Quality Card
- Real-time AQI value
- Color-coded status (Good/Moderate/Unhealthy/etc.)
- Station name

### Search & History
- Search any city by name
- Quick access to last 20 searched cities
- One-tap weather lookup

### Settings
- Custom user name
- Home city (auto-refreshed every 10 minutes)
- Temperature unit preference
- Data export/import
- Clear history option

## 🔐 Security

✅ **No Hardcoded Keys** - All API keys passed via environment variables
✅ **GitHub Secrets** - Safe CI/CD integration
✅ **Local Storage** - User data stored only on device
✅ **HTTPS Only** - All API calls encrypted

## 🚀 Production Checklist

- [x] API keys secured with `--dart-define`
- [x] Local notifications working
- [x] Professional logo & branding
- [x] Android manifest configured
- [x] No console errors or crashes
- [x] Proper error handling & fallbacks
- [x] Build optimization enabled (ProGuard)

## 📦 APK Output

After building, the release APK is located at:
```
build/app/outputs/apk/release/app-release.apk
```

## 📝 License

MIT

---

**Made with ❤️ by Vijayarka**
