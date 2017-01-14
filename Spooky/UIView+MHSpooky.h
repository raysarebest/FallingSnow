@import Foundation;
@import UIKit;
@class MHSpookyView;

@interface UIView(MHSpooky)

@property(nonatomic, strong) MHSpookyView *spookyView;

-(void)spook;

-(void)stopSnowing;

@end
