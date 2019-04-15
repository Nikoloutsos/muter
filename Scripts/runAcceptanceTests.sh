#!/bin/sh
echo "📴📴📴📴📴📴📴 Acceptance Testing has started 📴📴📴📴📴📴📴"

echo "Setting up environment for testing..."

echo "Running Muter on a codebase with a test suite..."
cd ./Repositories/ExampleApp
../../.build/x86_64-apple-macosx/debug/muter > ../../AcceptanceTests/muters_output.txt
../../.build/x86_64-apple-macosx/debug/muter --output-xcode > ../../AcceptanceTests/muters_xcode_output.txt
cd ../..

echo "Running Muter on an empty example codebase..."
cd ./Repositories/EmptyExampleApp
../../.build/x86_64-apple-macosx/debug/muter > ../../AcceptanceTests/muters_empty_state_output.txt
cd ../..

echo "Running Muter on an example test suite that fails..."
cd ./Repositories/ProjectWithFailures
../../.build/x86_64-apple-macosx/debug/muter > ../../AcceptanceTests/muters_aborted_testing_output.txt
cd ../..

echo "Running Muter's init on an uninitialized project..."
cd ./Repositories/UninitializedApp
rm muter.conf.json
../../.build/x86_64-apple-macosx/debug/muter init
cp ./muter.conf.json ../../AcceptanceTests/created_config.json
cd ../..

echo "Running Muter's help command..."
cd ./Repositories/UninitializedApp
../../.build/x86_64-apple-macosx/debug/muter help > ../../AcceptanceTests/muters_help_output.txt
cd ../..

echo "Running tests..."
swift package generate-xcodeproj
xcodebuild -scheme muter -only-testing:muterAcceptanceTests test

echo "📳📳📳📳📳📳📳 Acceptance Testing has finished 📳📳📳📳📳📳📳"
