# Flutter proguard rules
-keep class io.flutter.** { *; }
-keep class com.example.sylph.** { *; }

# HTTP and network libraries
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-keep class com.squareup.okhttp3.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**

# JSON parsing (if used)
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# Keep main activity
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Service
