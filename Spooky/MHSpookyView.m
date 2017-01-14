@import QuartzCore;
#import "MHSpookyView.h"

@implementation MHSpookyView

-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;

        // Set default values
        self.flakesCount = 160;
        self.flakeWidth = 20;
        self.flakeHeight = 23;
        self.flakeMinimumSize = .4;
        self.animationDurationMin = 6;
        self.animationDurationMax = 12;
    }
    return self;
}


-(void)beginSpooking{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Clean up if we go to the background as CABasicAnimations tend to do odd things then
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopSpookingFromNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];

    // Prepare Rotation Animation
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.repeatCount = INFINITY;
    rotationAnimation.autoreverses = NO;
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];	// 360 degrees in radians

    // Prepare Vertical Motion Animation
    CABasicAnimation *fallAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    fallAnimation.repeatCount = INFINITY;
    fallAnimation.autoreverses = NO;

    for(UIImageView *flake in self.flakesArray){
        CGPoint flakeStartPoint = flake.center;
        CGFloat flakeStartY = flakeStartPoint.y;
        CGFloat flakeEndY = self.frame.size.height;
        flakeStartPoint.y = flakeEndY;
        flake.center = flakeStartPoint;

        // Randomize the time each flake takes to animate to give texture
        CGFloat timeInterval = (self.animationDurationMax - self.animationDurationMin) * arc4random() / UINT32_MAX;
        fallAnimation.duration = timeInterval + self.animationDurationMin;
        fallAnimation.fromValue = [NSNumber numberWithFloat:-flakeStartY];
        [flake.layer addAnimation:fallAnimation forKey:@"transform.translation.y"];

        rotationAnimation.duration = timeInterval * 2; // Makes sure that we don't get super-fast spinning flakes
        [flake.layer addAnimation:rotationAnimation forKey:@"transform.rotation.y"];
    }
}


-(void)stopSpookingFromNotification:(NSNotification *)notification{
    [self stopSpooking];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginSpooking) name:UIApplicationDidBecomeActiveNotification object:nil];
}


-(void)stopSpooking{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for(UIImageView *flake in self.flakesArray){
        [flake removeFromSuperview];
    }
    _flakesArray = nil;
}


-(NSMutableArray *)flakesArray{
    if(!_flakesArray){
        srandomdev();
        self.flakesArray = [[NSMutableArray alloc] initWithCapacity:self.flakesCount];
        NSArray <UIImage *> *flakeImgs = @[[UIImage imageNamed:@"ghost-emoji.png"], [UIImage imageNamed:@"pumpkin.png"], [UIImage imageNamed:@"ghost.png"], [UIImage imageNamed:@"XMASSnowflake.png"]];

        for(int i = 0; i < self.flakesCount; i++){
            // Randomize Flake size
            CGFloat flakeScale = 1.0 * arc4random() / UINT32_MAX;

            // Make sure that we don't break the current size rules
            flakeScale = flakeScale < self.flakeMinimumSize ? self.flakeMinimumSize : flakeScale;
            CGFloat flakeWidth = self.flakeWidth * flakeScale;
            CGFloat flakeHeight = self.flakeHeight * flakeScale;

            // Allow flakes to be partially offscreen
            CGFloat flakeXPosition = self.frame.size.width * arc4random() / UINT32_MAX;
            flakeXPosition -= flakeWidth;

            // enlarge content height by 1/2 view height, screen is always well populated
            CGFloat flakeYPosition = self.frame.size.height * 1.5 * arc4random() / UINT32_MAX;
            // flakes start y position is above upper view bound, add view height
            flakeYPosition += self.frame.size.height;

            CGRect frame = CGRectMake(flakeXPosition, flakeYPosition, flakeWidth, flakeHeight);

            UIImageView *imageView = [[UIImageView alloc] initWithImage:flakeImgs[arc4random_uniform((u_int32_t)flakeImgs.count)]];
            imageView.frame = frame;
            imageView.userInteractionEnabled = NO;

            [self.flakesArray addObject:imageView];
            [self addSubview:imageView];
        }
    }
    return _flakesArray;
}

@end
