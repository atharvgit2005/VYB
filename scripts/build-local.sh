# Fast Local Build Script for VYB
# Run this for quick local APK builds (2-4 minutes after first build)

echo "🚀 Starting local Android build..."
echo ""

# Pre-warm Gradle (optional but speeds up)
# cd android && ./gradlew --daemon

# Build using EAS local
echo "📱 Building APK locally..."
npx eas-cli build --platform android --profile production --local

echo ""
echo "✅ Build complete! APK is ready."
echo "📦 Find your APK in the current directory"
