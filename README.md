## KXTools

自己由于工作需要而封装的一些基本控件<br/>
大家多多交流，多多指教，遇到问题可以联系我QQ: 381377046 ，备注KXTools 我会尽快优化

## DEMO
![image](https://github.com/KitsGithub/KXTools/blob/master/Screenshots/KXToolsScreenShot.gif)


## 目录
- BaseNavigationController、BaseViewController的介绍
- 模仿微信的ActionSheet 和 带特殊点击事件的AlertView
- URL的编码与解码
- 自定义封装的加密工具类
- 二次封装系统KeyChain方便使用
- TouchID的自封装



### 更新日志
> 2.17 去除UIButton分类，新增UINavigation、UIViewController的基类，实现不同颜色导航栏之间的无缝对接，KXCodingManager 新增zip解压方法（后台数据采取gzip格式返回）
>
> 2.16 新增之前封装好的仿微信的弹框提示，actionSheet 和 alertView
>
> 2.15 重新整理了ReadMe 和 调整了价格Label的具体实现
>


### BaseNavigationController 基类
```objc
/**
设置NavBar底部线条是否隐藏

@param isHiden 是否隐藏
*/
- (void)setBottomLineViewHiden:(BOOL)isHiden;
```

```objc
/**
设置NavBar底部线条的颜色

@param color 颜色
*/
- (void)setBottomLineViewColor:(UIColor *)color;
```
BaseNavigationController 同时内部实现了statusBar的childViewController


### BaseViewController （UIViewController基类）
```objc
- (void)viewWillAppear:(BOOL)animated
- (void)viewWillDisappear:(BOOL)animated
```
实现了在willAppear里记录上一界面的nav状态，及在willDisappear里恢复上一界面的状态

### 自定义的ActionSheet 和 alertView
样式模仿微信弹框

#### KXActionSheet
初始化方法，与系统alertView类似
```objc
/**
构造方法

@param titleName   标题
@param delegate    代理
@param cancelTitle 取消位置
@param titles      其他按钮（数组形式）
*/
- (instancetype)initWithTitle:(NSString *)titleName delegate:(id <KXActionSheetDelegate>)delegate cancellTitle:(NSString *)cancelTitle andOtherButtonTitles:(NSArray *)titles;
```

为了方便，我提供了两个方法设置标题内容<br/>
一个是自定义一个富文本传进去，但是会覆盖之前设置的文本内容
```objc
/**
设置标题字体

@param attributedStr 标题富文本
*/
- (void)setTitleColorWithAttributedStr:(NSMutableAttributedString *)attributedStr;
```

另一个是提供了一个block 把titleLabel传出来了,可以在这里设置标题文本
```objc
typedef void(^SetTitleBlock)(UILabel *_titleLabel);

- (void)setTitleColorWithAttributedStrWithBlock:(SetTitleBlock)block;
```

由于业务关系，经常会重点标注某一行，以显示其重要性<br/>
因此也提供了一个方法用以标红某一行
```objc
/**
标红字体方法

@param index 第几行需要标红
*/
- (void)setImportanceTitleAtIndex:(NSUInteger)index;
```

同样的由于业务的复杂性，我也提供了一个为某一行添加图片的方法
```objc
/**
给某一行设置文字图片

@param index       第几行
@param image       图片
@param edgInsets   图片距文字的边距
@param aligment    按钮的编辑方式
*/
- (void)setSubTitleImageWithIndex:(NSUInteger)index image:(UIImage *)image titleEdgeInsets:(UIEdgeInsets)edgInsets  WithAligment:(UIControlContentHorizontalAlignment)aligment;
```

展示方法
```objc
/**
展示动画
*/
- (void)show;
```

#### KXAlertView
初始化方法与系统alertView类似</br>
这里使用了MLabel，大家可以去他的github查看用法 https://github.com/molon/MLLabel
```objc
/**
初始化方法

@param title       标题
@param message     提示
@param cancel      取消按钮
@param andSubTitle 另外一个按钮

@return 实例化对象
*/
- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message delegate:(id <KXAlertViewDelegate>)delegate andCancelButton:(NSString *)cancel andSubTitle:(NSString *)andSubTitle;
```

```objc
/**
设置提示文本中的特殊的点击效果

@param targetStr 目标文本
*/
- (void)setSpacialLinkWithTargetStr:(NSString *)targetStr;
```

展示方法
```objc
/**
展示动画
*/
- (void)show;
```



###  NSString+urlCoding
如题所示， url的编码与解码
前一段时间，在项目中遇到再URL请求的时候带上了中文，然后导致编码问题，以致于后台前端都无法接收，因此在传输/解析之前，需要对中文部分进行编码/解码
```objc
/**
*  中文编码
*/
+ (instancetype)URLEncodedString:(NSString *)str;

/**
*  中文解码
*/
+ (instancetype)URLDecodedString:(NSString *)str;
```
利用以上2个方法就可以进行URL的编码/解码啦



### UINavigationBar+Awesome
由于NavBar是单例的，因而我常常在碰到需要随时更变导航条的颜色的时候，总是很蛋疼<br/>
有时候是因为进场动画、有时候是因为退场动画
```objc
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;  //更换导航栏的背景颜色
```
我们在退场的时候需要调用，让导航条重置为之前的状态
```objc
- (void)lt_reset; 
```
### FMDBManager
```objc
未完成 
```
因为现在的项目接触到FMDB这个类
因而就根据这个类，对操作指令做出了一下封装，方便新的接触者使用


### KXCodingManager
需要导入libz.tbd<br/>
base64、AES加密的工具类<br/>
使用这个方法进行Manager初始化
```objc
- (instancetype)initWithSequreKey:(NSString *)privateKey;
```

> 主要功能
>>Base64编码
```objc
/**
*  Base64编码
*  enCodingContent  编码字符串
*  return  内容经过Base64编码之后的字符串
*/
- (NSString *)base64Encoding:(NSString *)enCodingContent;
```
>>Base64解码
```objc
/**
*  Base64解码
*  deCodingContent  待解码字符串
*  return  内容经过Base64解码之后的字符串
*/
- (NSString *)base64Decoding:(NSString *)deCodingContent;
```
>>AES编码
```objc
/**
*  AES编码 + base64编码
*  一个字符串，经过 _privateKey 进行AES加密并进行Bser64加密
*  _privateKey 私钥  通过initWithSequreKey创建
*  enCodingContent  编码内容
*  return  编码后的内容
*/
- (NSString *)AESEncoding:(NSString *)enCodingContent;
```
>>AES解码
```objc
/**
*  AES解码 + base64解码
*  一个经过AES编码过的字符串，通过 _privateKey 解码
*  _privateKey :私钥  通过initWithSequreKey创建
*  deCodingContent  解码内容
*  return 解码后的字符串
*/
- (NSString *)AESDecoding:(NSString *)deCodingContent;
```

>>ZIP解码 
```objc
/**
ZIP解码

@param zipData zip 编码后的数据
@return zip解码后的数据
*/
- (NSData *)decodeZipData:(NSData *)zipData;
```

### KXKeyChainManager  二次封装系统KeyChain
核心方法
```objc
保存
+ (void)save:(NSString *)service data:(id)data;

读取
+ (id)load:(NSString *)service;

删除
+ (void)delete:(NSString *)service;
```


### KXTouchIDManager
初步封装TouchID 的流程和操作指令

