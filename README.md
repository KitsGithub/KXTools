#KXTools

自己由于工作需要而封装的一些基本控件
大家多多交流，多多指教，遇到问题可以联系我QQ: 381377046 ，我会尽快优化

#目录
- 快速创建图片在上,文字在下的按钮
- 创建1个带有单位的文本，支持价钱和单位颜色不一样
- URL的编码与解码
- 自定义封装的加密工具类
- 二次封装系统KeyChain方便使用
- TouchID的自封装


### 更新日志
> 2.16 新增之前封装好的仿微信的弹框提示，actionSheet 和 alertView  \n
> 2.15 重新整理了ReadMe 和 调整了价格Label的具体实现


### 快速创建图片在上,文字在下的按钮
快速创建的方式
```ruby
[button setImage:[UIImage imageNamed:@"xxx"] withSize:CGSizeMake(44, 44) andSubTtitle:@"测试按钮" andFont:13 withType:KXCustomButtonVerticalType stata:UIControlStateNormal];
```
其中
```ruby
typedef enum : NSUInteger {
KXCustomButtonHorizontalType = 0,  /** 水平样式  */
KXCustomButtonVerticalType = 1,    /** 垂直样式   */
} kXCustomButtonType;
```
`
因而开发者们要注意指定图片的位置

### UILabel+price (已更换实现)
创建1个带有单位的文本,支持价钱和单位颜色不一样
之前通过runTime 去手动创建2个不一样的label，这种方法太绕了
所以现在更换了另一种实现方式，去掉了price的Label分类
通过
```ruby
NSMutableAttributedString  //设置文本的动态属性
```
去达到之前的目的
核心代码
```ruby
NSString *targetStr = [price stringByAppendingString:unit];
//设置价钱的渲染
NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:targetStr];
[attStr setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:[targetStr rangeOfString:price]];
//设置单位部分的渲染
[attStr setAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor] , NSFontAttributeName : [UIFont systemFontOfSize:13]} range:[targetStr rangeOfString:unit]];
```

###  NSString+urlCoding
如题所示， url的编码与解码
前一段时间，在项目中遇到再URL请求的时候带上了中文，然后导致编码问题，以致于后台前端都无法接收，因此在传输/解析之前，需要对中文部分进行编码/解码
```ruby
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


### NSString+size
计算文字长度
老生常谈了，也不是什么新鲜的东西，不多作说明了


### UINavigationBar+Awesome
由于NavBar是单例的，因而我常常在碰到需要随时更变导航条的颜色的时候，总是很蛋疼
有时候是因为进场动画、有时候是因为退场动画
```ruby
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;  //更换导航栏的背景颜色
```
我们在退场的时候需要调用，让导航条重置为之前的状态
```ruby
- (void)lt_reset; 
```
### FMDBManager
```ruby
未完成 
```
因为现在的项目接触到FMDB这个类
因而就根据这个类，对操作指令做出了一下封装，方便新的接触者使用


### KXCodingManager
base64、AES加密的工具类
使用这个方法进行Manager初始化
```ruby
- (instancetype)initWithSequreKey:(NSString *)privateKey;
```

> 主要功能
>>Base64编码
```ruby
/**
*  Base64编码
*  enCodingContent  编码字符串
*  return  内容经过Base64编码之后的字符串
*/
- (NSString *)base64Encoding:(NSString *)enCodingContent;
```
>>Base64解码
```ruby
/**
*  Base64解码
*  deCodingContent  待解码字符串
*  return  内容经过Base64解码之后的字符串
*/
- (NSString *)base64Decoding:(NSString *)deCodingContent;
```
>>AES编码
```ruby
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
```ruby
/**
*  AES解码 + base64解码
*  一个经过AES编码过的字符串，通过 _privateKey 解码
*  _privateKey :私钥  通过initWithSequreKey创建
*  deCodingContent  解码内容
*  return 解码后的字符串
*/
- (NSString *)AESDecoding:(NSString *)deCodingContent;
```

### KXTouchIDManager
初步封装TouchID 的流程和操作指令

