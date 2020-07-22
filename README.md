# flutter_app_im

添加腾讯云im的依赖

```yaml
dim: ^0.2.8
```

按照官方说法需要在你的flutter工程的ios项目根目录执行*pod update*[非必须，如果报错建议执行一次]
随后在执行一次*pod install*

但是很多人都表示运行后会报这样的一个错误

～～Error output from Xcode build:
  ↳
      ** BUILD FAILED **
  
  
  Xcode's output:
  ↳
      error: Multiple commands produce '/Users/zhiyi/FlutterPro/TencentIm/flutter_app_im/build/ios/Debug-iphonesimulator/dim/dim.framework/Info.plist':
      1) Target 'dim' (project 'Pods') has copy command from '/Users/zhiyi/Library/flutter/.pub-cache/hosted/pub.flutter-io.cn/dim-0.2.8/ios/Classes/MJExtension/Info.plist' to '/Users/zhiyi/FlutterPro/TencentIm/flutter_app_im/build/ios/Debug-iphonesimulator/dim/dim.framework/Info.plist'
      2) Target 'dim' (project 'Pods') has process command with output '/Users/zhiyi/FlutterPro/TencentIm/flutter_app_im/build/ios/Debug-iphonesimulator/dim/dim.framework/Info.plist'
      note: Using new build systemnote: Planning buildnote: Constructing build descriptionwarning: duplicate output file '/Users/zhiyi/FlutterPro/TencentIm/flutter_app_im/build/ios/Debug-iphonesimulator/dim/dim.framework/Info.plist' on task: ProcessInfoPlistFile /Users/zhiyi/FlutterPro/TencentIm/flutter_app_im/build/ios/Debug-iphonesimulator/dim/dim.framework/Info.plist /Users/zhiyi/FlutterPro/TencentIm/flutter_app_im/ios/Pods/Target Support Files/dim/dim-Info.plist (in target 'dim' from project 'Pods')
  
  Could not build the application for the simulator.
  Error launching application on iPhone 8.～～
  
  好在在github中找到了一个回答案
  方法一共有两种：
  第一种：使用xcode打开ios目录，然后依次打开 File->Workspace Settings ，然后将构建系统修改为 LegacyBuild System
  第二种：
  使用新的Xcode 10构建系統。
  打开 ios/Runner.xcworkspace
  Runner在项目导航器侧栏中选择项目。
  在主视图中，选择Runner目标，然后选择Build Phases选项卡。
  拓展Embed Frameworks阶段，然后Flutter.framework从嵌入入式框架列表中进行选择。
  单机-以Flutter.framework从列表中刪除（请确保保留 App.framework）。
  
  [Issues](https://github.com/flutter/flutter/issues/20685)
  
  如果提示
   ```proguard
  Automatically assigning platform `iOS` with version `8.0` on target `Runner` because no platform was specified. Please specify a platform for this target in your Podfile
  ```
  则需要进入ios目录
  ```cmake
  cd ios 
  vi Podfile 
  ```
  进入这个文件之后按下键盘 的 i 键，进入编辑模式添加：
  ```youtrack
  platform :ios, '8.0'
  ```
  按下 esc 键入
  ```cmake
  :wq
  ```
  保存退出