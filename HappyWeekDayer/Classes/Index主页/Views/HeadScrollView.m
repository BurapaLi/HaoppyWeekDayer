//滚动图

#import "HeadScrollView.h"
#import "Index.h"
@interface HeadScrollView()<UIScrollViewDelegate>
@property(nonatomic, retain) NSTimer *timer;

@end
@implementation HeadScrollView

- (instancetype)initWithFrame:(CGRect)frame andbannerList:(NSMutableArray *)bannerList{
    if ([super initWithFrame:frame ]) {
        self.bannerList = bannerList;
        [self loadingCustomView];
    }
    return self;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 186)];
        self.scrollView.backgroundColor = [UIColor darkGrayColor];
        self.scrollView.delegate = self;
        //整屏滑动
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 186 - 30, SCREEN_WIDTH, 30)];
        self.pageControl.pageIndicatorTintColor = [UIColor blueColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        
    }
    return _pageControl;
}
- (void)loadingCustomView{
    
#pragma mark 数组图片
    for (int i = 0; i < self.bannerList.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, 186)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.bannerList[i][@"url"]] placeholderImage:nil];
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        touchBtn.frame = imageView.frame;
        touchBtn.tag = 100 + i;
        [self.scrollView addSubview:touchBtn];
    }
    //定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollViewAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

    
}
- (void)scrollViewAction{
    NSInteger i = self.pageControl.currentPage;
    if (i == 4) {
        i = -1;
    }
    i++;
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = i * SCREEN_WIDTH;
    [self.scrollView setContentOffset:offset animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offSet = self.scrollView.contentOffset;
    CGFloat width = self.scrollView.frame.size.width;
    self.pageControl.currentPage = offSet.x / width;
}
//当用户拖拽scrollView的时候，移除定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate], self.timer = nil;
}
//当用户停止拖拽时，添加定时器
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollViewAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//切换视图时，移除定时器
- (void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate], self.timer = nil;
}

@end





















