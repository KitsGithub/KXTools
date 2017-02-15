#KXTools

自己由于工作需要而封装的一些基本控件
大家多多交流，多多指教，遇到问题可以联系我QQ: 381377046 ，我会尽快优化

#目录
- [快速创建图片在上,文字在下的按钮]
- [创建1个带有单位的文本，支持价钱和单位颜色不一样]
- [URL的编码与解码]
- [自定义封装的加密工具类]


## 快速创建图片在上,文字在下的按钮
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

因而开发者们要注意使用



## UILabel+price

创建1个带有单位的文本,支持价钱和单位颜色不一样

##  NSString+urlCoding

如题所示， url的编码与解码

## NSString+size

计算文字长度

## UINavigationBar+Awesome

navBar 的一些灵活用法

# KXCodingManager

base64、AES加密的工具类

# KXCopyView

仿微信的复制、粘贴按钮
