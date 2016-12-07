//
//  ViewController.m
//  简述详情页
//
//  Created by mibo02 on 16/12/7.
//  Copyright © 2016年 mibo02. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *bottomButtonView;
@property (nonatomic, assign)CGFloat offsetY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"峰峰";
    self.offsetY = 0.0;
    [self initTableView];
    [self createButton];
}

- (void)initTableView
{
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (void)createButton
{
    self.bottomButtonView = [[UIView alloc] init];
    self.bottomButtonView.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    [self.view addSubview:self.bottomButtonView];
   
    UIButton  *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =  CGRectMake(0, 0, self.view.frame.size.width / 2, 50);
    [button setTitle:@"LeftButton" forState:UIControlStateNormal];
    button.backgroundColor =[UIColor orangeColor];
    button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    button.layer.borderWidth = 1;
    [self.bottomButtonView addSubview:button];
    
    UIButton  * butn= [UIButton buttonWithType:UIButtonTypeCustom];
    butn.frame =  CGRectMake(button.frame.size.width , 0, self.view.frame.size.width / 2, 50);
    [butn setTitle:@"RightButton" forState:UIControlStateNormal];
    butn.backgroundColor =[UIColor redColor];
    butn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    butn.layer.borderWidth = 1;
    [self.bottomButtonView addSubview:butn];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIndetifi = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifi];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndetifi];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
}
//scrollviewDelegate
//
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //contentOffset是UIScrollView当前显示区域的顶点相对于frame顶点的偏移量
    self.offsetY = scrollView.contentOffset.y;
    // NSLog(@"偏移量是多少== %f",self.offsetY);
}
//当滑动将要减速的时候
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
   //  NSLog(@"scrollView的偏移量是多少== %f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > self.offsetY) {//向上滑动
        [UIView transitionWithView:self.bottomButtonView duration:0.1 options:(UIViewAnimationOptionTransitionNone) animations:^{
            self.bottomButtonView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50);
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        } completion:nil];
    }else if (scrollView.contentOffset.y < self.offsetY){
        [UIView transitionWithView:self.bottomButtonView duration:0.1 options:(UIViewAnimationOptionTransitionNone) animations:^{
            self.bottomButtonView.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        } completion:nil];
    }//向下滑动
   
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //1、拍击UITapGestureRecognizer (任意次数的拍击)
    //2、向里或向外捏UIPinchGestureRecognizer (用于缩放)
    //3、摇动或者拖拽UIPanGestureRecognizer (拖动)
    //4、擦碰UISwipeGestureRecognizer (以任意方向)
    //5、旋转UIRotationGestureRecognizer (手指朝相反方向移动)
    //6、长按UILongPressGestureRecognizer (长按)
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    NSLog(@"%f",translation.y);
    if (translation.y>0) {
        //按钮出现
        [UIView transitionWithView:self.bottomButtonView duration:0.2 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButtonView.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        } completion:NULL];
    }else if(translation.y<0){
        //按钮消失
        [UIView transitionWithView:self.bottomButtonView duration:0.2 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButtonView.frame = CGRectMake(0, self.view.frame.size.height , self.view.frame.size.width, 50);
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        } completion:NULL];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
