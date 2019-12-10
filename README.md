## 配置环境

##### 添加国内镜像,[然后官网下载flutter包解压](https://codecov.io/gh/theyakka/fluro),并配置环境变量
```sh
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export FLUTTER_HOME=/Users/mollet/Library/flutter
export PATH=$FLUTTER_HOME/bin:$PATH
source $HOME/.bash_profile
```

### 运行flutter doctor 检查其他依赖项是否安装
```sh
flutter doctor
```

## 运行项目
```sh
git clone https://github.com/yuanmaole/flutter_boss_app.git
cd ${your path}/flutter_boss_app
flutter pub get
flutter run
```
 video_player: ^0.10.3+3
  cached_network_image: ^1.1.3
  flutter_swiper: ^1.1.6
  flutter_screenutil: ^0.6.1
  dio: ^3.0.0
  fluro: ^1.5.1

### 项目第三方库
```yml
  video_player: ^0.10.3+3 #视频播放
  cached_network_image: ^1.1.3 #网络图片
  flutter_swiper: ^1.1.6 #轮播
  flutter_screenutil: ^0.6.1 #屏幕适配
  dio: ^3.0.0 #Http请求
  fluro: ^1.5.1 #路由
  provider: ^3.1.0 #状态管理
  shared_preferences: ^0.5.3+4 #本地键值存储
```