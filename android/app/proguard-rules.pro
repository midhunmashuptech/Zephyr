# Suppress warnings for Parcelize
-dontwarn kotlinx.parcelize.Parcelize

# Keep Parcelize annotation
-keep class kotlinx.parcelize.Parcelize { *; }
-keep class kotlinx.parcelize.** { *; }

# Keep the TpInitParams class
-keep class com.tpstream.player.TpInitParams { *; }