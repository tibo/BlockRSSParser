Pod::Spec.new do |s|
  s.name         = "BlockRSSParser"
  s.version      = "3.0"
  s.summary      = "AFNetworking based RSS parser."
  s.homepage     = "https://github.com/tibo/BlockRSSParser"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Thibaut LE LEVIER" => "thibaut@lelevier.fr" }

  s.source       = { :git => "https://github.com/tibo/BlockRSSParser.git", :tag => "3.0" }

  s.requires_arc = true

  s.platform     = :ios
  s.ios.deployment_target = '7.0'

  s.source_files = 'Classes', 'RSSParser/*.{h,m}'

  s.dependency 'AFNetworking', '~> 3.0'
end
