@import QuartzCore;
#import "UIView+MHSpooky.h"
#import "MHSpookyView.h"
#import <objc/runtime.h>

@implementation UIView(MHSpooky)

-(void)makeItSnow{
    if(self.snowView){
        [self stopSnowing];
    }
    MHSpookyView *snowView = [[MHSpookyView alloc] initWithFrame:self.frame];
    [self addSubview:snowView];
    snowView.layer.zPosition = MAXFLOAT;
    [snowView beginSpooking];
    [self setSnowView:snowView];
}


-(void)stopSnowing{
    [self.snowView stopSnowing];
    [self.snowView removeFromSuperview];
    self.snowView = nil;
}


-(void)setSnowView:(MHSpookyView *)snowView{
    objc_setAssociatedObject(self, @selector(snowView), snowView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(MHSpookyView *)snowView{
    MHSpookyView *snowView = objc_getAssociatedObject(self, @selector(snowView));
    return snowView;
}

@end
