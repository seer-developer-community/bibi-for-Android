币比源码说明 
====
币比是SEER运营团队打造的一款“样板房”式的DAPP，同时也起到SEER手机钱包的作用。SEER用户可以使用币比来参与各种主题的预测，使用SEER的各项功能。社区开发者也能通过币比来了解基于SEER的DAPP开发。

币比也是一个开源项目，对于开发者来说，币比是一个开发验证和实验的工具。币比开发团队将使用目前移动端常用的webapp、安卓原生、IOS原生等技术分别对币比进行实现。

此处开源的是币比的移动版DApp版本:


项目说明:
====
1:
币比源码使用Android Studio进行开发

若您是第一次使用Android Stuio,首先从https://developer.android.google.cn/studio 下载Android studio安装包,然后进行傻瓜式的安装

Android studio 入门教程 https://blog.csdn.net/liqz666/article/details/80243836 

2:

 (1)添加图片或者更改图片资源，在如下图的箭头1位置放置图片资源,然后再把对应的图片名称在xml文件下更改掉.

 (2)修改页面文字等内容,找到CurrencyRatio/app/src/main/res/layout/目录下的.xml文件即可,即如下图的箭头2

 ![image](https://github.com/HaiRong1186026575/CurrencyRatio/blob/gitSeerHigh/app/src/main/res/drawable/create.png)
3:

 (1)更改代码,在CurrencyRatio/app/src/main/java目录下找到对应的java文件,即如下图的箭头1
 
  比如币比项目中的创建钱包,编写该页面的java文件 如下图的箭头3,在每个java文件都有个加载getLayoutId方法,该方法是加载每个页面的资源文件xml,如果要修改页面内容等,从这里点击进入也可以修改页面资源，如下图的箭头4.
 
 (2)打包APK,则通过AS的build - build bundle - build apks来发布debug版apk，要打包release版apk，需要在build - Generate signed bundle / apk 新建一个jks，然后发布release版apk 如下图的箭头2
 
 ![image](https://github.com/HaiRong1186026575/CurrencyRatio/blob/gitSeerHigh/app/src/main/res/drawable/recorders.png)
 
功能说明：
 ====
 
  1：查询固定平台下的房间作为列表信息展示(更改房间平台id以及项目节点)
 
    查询平台房间 java文件在 com.nyzc.gdm.currencyratio.homePacakage.HomeFragment
    
    该文件下的initRoom()方法里的list和listEn集合是放置中文和英文平台id.可以在集合里更改平台id.
    
    项目节点java文件位置在 com.nyzc.gdm.currencyratio.Utils.HttpUrl .
    
  2：查询对应资产下的信息(更改资产id)
  
     查询资产的接口封装的Java文件在 com.nyzc.gdm.currencyratio.BiBiPacakage.BitsharesWalletWraper
    
     BitsharesWalletWraper里的lookup_asset_symbols方法就是传入资产id,展示对应的资产信息.
     
     该项目用到所有接口都封装在该BitsharesWalletWraperjava文件中.
     
     调用：BitsharesWalletWraper.getInstance().lookup_asset_symbols("0.0.0");
  
  3：创建钱包/导入钱包(信息保存在手机本地文件)
 
    (1)创建钱包的java文件在 com.nyzc.gdm.currencyratio.uipacakage.CreateWalletActivity 
    
    (2)导入钱包的java文件在 com.nyzc.gdm.currencyratio.uipacakage.ImportWalletActivity 
    
  4：查询账户余额,近期转账交易记录以及转账，充值功能
 
    (1)查询账户余额以及近期转账的java文件在 com.nyzc.gdm.currencyratio.accountPacakage.TranstionRecorderActivity 

    (2)转账功能的java文件在 com.nyzc.gdm.currencyratio.accountPacakage.TransferAccountActivity
 
    (3)充值的java 文件在 com.nyzc.gdm.currencyratio.accountPacakage.TransferAccountActivity.RechargeActivity
 
  5：预测功能
 
    预测的java文件在 com.nyzc.gdm.currencyratio.homePacakage.ForeCastActivity

  6：查询订单信息功能
 
    查询订单信息java文件在 com.nyzc.gdm.currencyratio.OrderPacakage.OrderFragment
 
 使用Android Studio构建币比项目时可能遇到的一些问题:
  ====
  1: 连接不上gradle的问题
  
  报错提示：No cached version of com.android.tools.build:gradle:3.1.4
  
  解决方法：
  
  这是因为设置中默认使用offline work，改为use defalut gradle wrapper(recommended)即可。
  
![image](https://github.com/HaiRong1186026575/CurrencyRatio/blob/gitSeerHigh/app/src/main/res/drawable/gradle.jpg)
  
  2:SDK版本问题
  
  报错提示：Failed to install the following Android SDK packages as some licences have not been accepted.
  
  解决方法：
  
  Android Studio > Preferences > Appearance & Behaviour > System Settings > Android SDK
  
![image](https://github.com/HaiRong1186026575/CurrencyRatio/blob/gitSeerHigh/app/src/main/res/drawable/sdk.jpg)
 
 3:AAPT2报错
 
 解决方法：打开gradle.properties，添加如下内容 android.enableAapt2=false
 
![image](https://github.com/HaiRong1186026575/CurrencyRatio/blob/gitSeerHigh/app/src/main/res/drawable/aadp.jpg)

 4:下载最新的AndroidStuio,可能Gradle版本和币比项目中的Gradle不一致,从而可能会导致项目运行不成功.如下图的箭头1

解决方法:复制币比项目中的gradle替换掉您的Android stuio里的Gradle,并且打开build gradle文件更改gradle版本，如下图的箭头2和3

![image](https://github.com/HaiRong1186026575/CurrencyRatio/blob/gitSeerHigh/app/src/main/res/drawable/gradles.png)

