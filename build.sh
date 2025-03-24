#!/bin/bash

# Exit immediately if any command fails
set -e

SCHEME="Debug"
PROJECT="Coin.xcodeproj"
DESTINATION="platform=iOS Simulator,name=iPhone 16,OS=latest"

echo "🚀 Running Unit Tests for $SCHEME scheme..."

# Run tests
xcodebuild test \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -destination "$DESTINATION" \
  -only-testing:"YourAppTests" \
  -configuration Debug \
  | xcpretty

echo "✅ Tests completed!"
