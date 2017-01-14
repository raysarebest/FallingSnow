@import UIKit;

@interface MHSpookyView : UIView

@property(nonatomic, retain) NSMutableArray *flakesArray;
@property(nonatomic, assign) NSInteger flakesCount;
@property(nonatomic, assign) CGFloat flakeWidth;
@property(nonatomic, assign) CGFloat flakeHeight;
@property(nonatomic, assign) CGFloat flakeMinimumSize;
@property(nonatomic, assign) CGFloat animationDurationMin;
@property(nonatomic, assign) CGFloat animationDurationMax;

-(void)beginSpooking;

@end
