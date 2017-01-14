@import QuartzCore;
#import "UIView+MHSpooky.h"
#import "MHSpookyView.h"
#import <objc/runtime.h>

@implementation UIView(MHSpooky)

-(void)spook{
    if(self.spookyView){
        [self stopSnowing];
    }
    MHSpookyView *spookyView = [[MHSpookyView alloc] initWithFrame:self.frame];
    [self addSubview:spookyView];
    spookyView.layer.zPosition = MAXFLOAT;
    [spookyView beginSpooking];
    [self setSpookyView:spookyView];
}


-(void)stopSnowing{
    [self.spookyView stopSnowing];
    [self.spookyView removeFromSuperview];
    self.spookyView = nil;
}


-(void)setSpookyView:(MHSpookyView *)spookyView{
    objc_setAssociatedObject(self, @selector(spookyView), spookyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(MHSpookyView *)spookyView{
    MHSpookyView *spookyView = objc_getAssociatedObject(self, @selector(spookyView));
    return spookyView;
}

@end
