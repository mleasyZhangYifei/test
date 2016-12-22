//
//  ViewController.m
//  test
//
//  Created by juefeng on 16/12/21.
//  Copyright © 2016年 张毅斐. All rights reserved.
//

#import "ViewController.h"
#import "TestHeader.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _TableView;
    MJRefreshHeader *MJHeader;
}
@property(nonatomic,strong) NSString *Canada;
@property(nonatomic,strong) NSMutableArray *DataSource;
@end

@implementation ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _DataSource = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUI];
}
- (void)initUI{
    
    [self initdata];
    
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, MAINSCREEN.size.width, MAINSCREEN.size.height-20)];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    [_TableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_TableView];
    
    _TableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initdata)];
   
}
-(void)initdata{
    [HTTPTools facts:nil success:^(TitleBean *Title) {
        [_TableView.header endRefreshing];
        self.Canada=Title.title;
        self.DataSource=Title.rows;
        _TableView.hidden = NO;
        [_TableView reloadData];
    } failure:^(NSString *error) {
        NSLog(@"%@",error);
        if ([error isEqualToString:@"0"]) {
            _TableView.hidden = YES;
          [self.view addSubview:[self labelfuyong:@"无数据" x:10 y:MAINSCREEN.size.height/4 width:MAINSCREEN.size.width-20 height:25 fontsizi:FONTSHIBA Color:[UIColor blueColor]]];
        }
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _DataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    TitleData * title = _DataSource[indexPath.row];
    NSString * titleStr,*descripStr,*imageHrefStr;
    int X1;
    
    titleStr = [title.title isKindOfClass:[NSNull class]] ? @"":title.title;
    
    imageHrefStr = [title.imageHref isKindOfClass:[NSNull class]] ? @"":title.imageHref;
    X1 = [title.imageHref isKindOfClass:[NSNull class]] ? 20:130;
    
    descripStr = [title.Description isKindOfClass:[NSNull class]] ? @"":title.Description;
    
    [cell.contentView addSubview:[self labelfuyong:titleStr x:10 y:5 width:MAINSCREEN.size.width-20 height:25 fontsizi:FONTSHIBA Color:[UIColor blueColor]]];
    [cell.contentView addSubview:[self labelfuyong:descripStr x:10 y:30 width:MAINSCREEN.size.width-X1 height:65 fontsizi:FONTSHIWU Color:[UIColor blackColor]]];
    [cell.contentView addSubview:[self imagefuyong:imageHrefStr x:MAINSCREEN.size.width-120 y:30 width:100 height:65]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewRowAnimationNone;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}
-(UILabel *)labelfuyong:(NSString *)text x:(int)x y:(int)y width:(int)width height:(int)height fontsizi:(UIFont *)fontsizi Color:(UIColor *)Color
{
    UILabel * Label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    Label.text = text;
    Label.backgroundColor = [UIColor clearColor];
    Label.textColor = Color;
    Label.textAlignment = NSTextAlignmentLeft;
    Label.font = fontsizi;
    Label.numberOfLines = 0;
    return Label;
}
-(UIImageView *)imagefuyong:(NSString *)imageUrl x:(int)x y:(int)y width:(int)width height:(int)height
{
    UIImageView * imagevc = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [imagevc setImageWithURL:[NSURL URLWithString:imageUrl]];
    return imagevc;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
