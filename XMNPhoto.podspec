Pod::Spec.new do |s|
  s.name             = 'XMNPhoto'
  s.version          = '0.0.1'
  s.summary          = 'XMNPhoto 图片相关集合工具包含图片选择列库, 基于YYWebImage封装的一款简单的图片浏览类库'
  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/XMNPhoto'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'XMFraker' => '3057600441@qq.com' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/XMNPhoto.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  # s.source_files = 'XMNPhoto/Classes/**/*'
  # s.resource_bundles = {
  #   'XMNPhoto' => ['XMNPhoto/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.default_subspec = 'Picker','Browser'

  s.subspec 'Picker' do |ss|
    ss.source_files = "XMNPhoto/Classes/XMNPhotoPicker/*.{h,m}","XMNPhoto/Classes/XMNPhotoPicker/**/*.{h,m}"
    ss.resources = ['XMNPhoto/Assets/XMNPhotoPicker/*.png','XMNPhoto/Assets/XMNPhotoPicker/*.xib']
  end

  s.subspec 'Browser' do |ss|
    ss.source_files = "XMNPhoto/Classes/XMNPhotoBrowser/*.{h,m}","XMNPhoto/Classes/XMNPhotoBrowser/**/*.{h,m}"
    ss.public_header_files = 'XMNPhoto/Classes/XMNPhotoBrowser/*.h'
    ss.dependency 'YYWebImage'
  end
end
