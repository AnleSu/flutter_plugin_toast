#import "UcarFlutterToastPlugin.h"
#import "UIView+FlutterToast.h"

static NSString *const CHANNEL_NAME = @"ucar_flutter_toast";

@implementation UcarFlutterToastPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:CHANNEL_NAME
            binaryMessenger:[registrar messenger]];
  UcarFlutterToastPlugin* instance = [[UcarFlutterToastPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"makeToast" isEqualToString:call.method]) {
//    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
      NSLog(@"flutter 传入的参数： %@",call.arguments);
      NSString *message = call.arguments[@"message"];
      NSString *position = call.arguments[@"position"];
      NSString *duration = call.arguments[@"duration"];
      
      NSString *backgroundColor = call.arguments[@"backgroundColor"];
      //暂时没有用到需要toast title的 所以先不支持title的设置
//      NSString *titleColor = call.arguments[@"titleColor"];
      NSString *messageColor = call.arguments[@"messageColor"];
//      NSNumber *titleFont = call.arguments[@"titleFont"];
      NSString *messageFont = call.arguments[@"messageFont"];
     
      CGFloat time = 2.0;
      if (![self _isEmptyObj:duration]) {
          time = [duration floatValue] > 0 ? [duration floatValue] : 2.0;
      }
      id toastPosition = CSToastPositionCenter;
      if ([position isEqualToString:@"top"]) {
          
          toastPosition = CSToastPositionTop;
          
      } else if ([position isEqualToString:@"bottom"]) {
          
          toastPosition = CSToastPositionBottom;
          
      } else {
          
          toastPosition = CSToastPositionCenter;
          
      }
      
      
      CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
//      if (titleFont) {
//          style.titleFont = [UIFont systemFontOfSize:titleFont.floatValue];
//      }
      //backgroundColor = "<null>";
      if (![self _isEmptyObj:messageFont]) {
          
          style.messageFont = [UIFont systemFontOfSize:messageFont.floatValue];
      }
      
      if (![self _isEmptyObj:backgroundColor]) {
          
          style.backgroundColor = HexColor(backgroundColor.integerValue);
      }
      
      if (![self _isEmptyObj:messageColor]) {
          style.messageColor = HexColor(messageColor.integerValue);
          
      }
//      style.titleColor = HexColor(titleColor.integerValue);
      
      [[self _readKeyWindow] flutter_makeToast:message duration:time position:toastPosition style:style];
      
      result([NSNumber numberWithBool:true]);
  } else if ([@"hideToast" isEqualToString:call.method]) {
      [[UIApplication sharedApplication].delegate.window.rootViewController.view flutter_hideAllToasts];
      
      result([NSNumber numberWithBool:true]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}


#pragma mark - read the key window

- (UIWindow *)_readKeyWindow {
    for (UIWindow *window in UIApplication.sharedApplication.windows) {
        if ([window isKindOfClass:UIWindow.class] && window.isKeyWindow && window.windowLevel == UIWindowLevelNormal) {
            return window;
        }
    }
    return nil;
}

- (BOOL)_isEmptyObj:(id)o
{
    if (o==nil) {
        return YES;
    }
    if (o==NULL) {
        return YES;
    }
    if ([o isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([o isKindOfClass:[NSString class]]) {
        return [self _isBlankObject:o];
    }
    if ([o isKindOfClass:[NSData class]]) {
        return [((NSData *)o) length]<=0;
    }
    if ([o isKindOfClass:[NSDictionary class]]) {
        return [((NSDictionary *)o) count]<=0;
    }
    if ([o isKindOfClass:[NSArray class]]) {
        return [((NSArray *)o) count]<=0;
    }
    if ([o isKindOfClass:[NSSet class]]) {
        return [((NSSet *)o) count]<=0;
    }
    return NO;
}

- (BOOL)_isBlankObject:(id)object {
    if (object == nil) {
        return YES;
    }
    if (object == NULL) {
        return YES;
    }
    if ([object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    if ([object isKindOfClass:[NSString class]]) {
        if ([[object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
            return YES;
        } else {
            const char *str = [object UTF8String];
            if (strlen(str) == 0) {
                return YES;
            }
        }
    }
    return NO;
}


static UIColor *HexColor(NSInteger rgbValue){
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}



@end
