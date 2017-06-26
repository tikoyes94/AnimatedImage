Pod::Spec.new do |s|
  s.name             = 'AnimatedImage'
  s.version          = '0.1.0'
  s.summary          = 'UIImageView subclass optimized for handling animated images.'
  s.description      = <<-DESC
AnimatedImageView is a UIImageView subclass optimized for displaying GIF images with low memory cost and CPU usage.
                       DESC

  s.homepage         = 'https://github.com/tikoyesayan/AnimatedImage'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tigran Yesayan' => 'tikoyes94@gmail.com' }
  s.source           = { :git => 'https://github.com/tikoyesayan/AnimatedImage.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'AnimatedImage/Classes/**/*'
# s.frameworks = 'UIKit', 'ImageIO', 'MobileCoreServices', 'CoreAnimation'
end
