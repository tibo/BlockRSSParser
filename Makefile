test:
	gem install --no-ri --no-rdoc cocoapods xcpretty
	cd RSSParser_Sample; pod install
	cd RSSParser_Sample; xcodebuild -sdk iphonesimulator -workspace RSSParser_Sample.xcworkspace -scheme RSSParser_Sample clean test | xcpretty -c
