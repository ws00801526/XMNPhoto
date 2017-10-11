Pod::Spec.new do |s|
  s.name             = 'XMNPhoto'
  s.version          = '1.2.7'
  s.summary          = 'XMNPhoto 图片相关集合工具包含图片选择列库, 基于YYWebImage封装的一款简单的图片浏览类库'
  s.homepage         = 'https://github.com/ws00801526/XMNPhoto'
  s.screenshots     = 'https://camo.githubusercontent.com/711c2776179af97c37ce0dda617642f45f55449b/687474703a2f2f37786c74316a2e636f6d312e7a302e676c622e636c6f7564646e2e636f6d2f584d4e50686f746f5069636b65724672616d65776f726b2e676966', 'https://camo.githubusercontent.com/8a60aa309935ccf57bc141fe12021f8f892ef387/687474703a2f2f37786c74316a2e636f6d312e7a302e676c622e636c6f7564646e2e636f6d2f584d4e50686f746f5069636b65724672616d65776f726b5f42726f777365722e676966'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'XMFraker' => '3057600441@qq.com' }
  s.source           = { :git => 'https://github.com/ws00801526/XMNPhoto.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.default_subspec = 'Picker','Browser'

  s.subspec 'Picker' do |ss|
    ss.source_files = "XMNPhoto/Classes/XMNPhotoPicker/*.{h,m}","XMNPhoto/Classes/XMNPhotoPicker/**/*.{h,m}"
    ss.resource_bundles = {'XMNPhotoPicker' => ['XMNPhoto/Assets/XMNPhotoPicker/*.png','XMNPhoto/Assets/XMNPhotoPicker/*.xib']}
    ss.dependency 'YYImage'
  end

  s.subspec 'Browser' do |ss|
    ss.source_files = "XMNPhoto/Classes/XMNPhotoBrowser/*.{h,m}","XMNPhoto/Classes/XMNPhotoBrowser/**/*.{h,m}"
    ss.dependency 'YYWebImage'
  end
end
