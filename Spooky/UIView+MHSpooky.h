@import Foundation;
@import UIKit;
@class MHSpookyView;

@interface UIView(MHSpooky)

@property(nonatomic, strong) MHSpookyView *snowView;

-(void)makeItSnow;

-(void)stopSnowing;

@end
