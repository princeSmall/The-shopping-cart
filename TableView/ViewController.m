//
//  ViewController.m
//  TableView
//
//  Created by iOS on 2017/5/4.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "NumberModel.h"
#import "Masonry.h"
#import "InfoViewController.h"
#import "SettlementViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isSelectedAll;
    NSInteger priceAll;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * numberArray;
@property (nonatomic,strong)NSMutableDictionary * numberDic;
@property (nonatomic,strong)TableViewCell * ViewCell;
@property (nonatomic,strong)NumberModel * numberModel;
@property (nonatomic,strong) UIBarButtonItem  * leftItem;
@property (nonatomic,strong) UIBarButtonItem * centerItem;


@property (nonatomic,strong)UIButton * btn;
@property (nonatomic,strong)UIButton * editBtn;
@property (nonatomic,strong)UIButton * Vbtn;
@property (nonatomic,strong)UILabel * VlabP;



@end

@implementation ViewController

static NSString * identifer = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addModelInfo];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:identifer];
    
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.scrollsToTop = NO;
//    [self footView];
    self.navigationController.toolbarHidden = NO;
    [self.navigationController.toolbar setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem * space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem * fixed =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    
    UIImage * image =[UIImage imageNamed:@"choose"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.leftItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(selecteALL)];
    isSelectedAll = NO;
    UIBarButtonItem  * Item = [[UIBarButtonItem alloc]initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:nil];

    
    NSInteger i = 0;
    priceAll = 0;
    
    NSString * str = [NSString stringWithFormat:@"合计:￥%ld 不含运费",i];
    self.centerItem = [[UIBarButtonItem alloc]initWithTitle:str style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"结算" style:UIBarButtonItemStylePlain target:self action:@selector(settleAccounts)];
    rightItem.tintColor = [UIColor orangeColor];
    self.toolbarItems = @[ fixed,self.leftItem,Item,space,self.centerItem,space,rightItem,fixed];
    
    // Do any additional setup after loading the view, typically from a nib.
}
// 自定义View替代的toolbar，被系统的取代了
-(void)footView{
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-80, self.view.frame.size.width, 80)];
    footView.backgroundColor = [UIColor whiteColor];
    footView.layer.borderColor = [UIColor grayColor].CGColor;
    footView.layer.borderWidth = 1;
    self.Vbtn = [[UIButton alloc]init];
    
    [footView addSubview:self.Vbtn];
    [self.Vbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footView).offset(10);
        make.left.mas_equalTo(footView).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];

    [self.Vbtn setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    [self.Vbtn setTitle:@"   全选" forState:UIControlStateNormal];
    [self.Vbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.Vbtn addTarget:self action:@selector(selecteALL) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * VlabT = [[UILabel alloc]init];
    [footView addSubview:VlabT];
    [VlabT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footView.mas_centerX).offset(-50);
        make.top.mas_equalTo(footView).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    VlabT.text = @"合计";
    VlabT.font = [UIFont fontWithName:@"Arial" size:12];
    VlabT.textAlignment = NSTextAlignmentCenter;
    VlabT.textColor =[UIColor blackColor];
    
    self.VlabP = [[UILabel alloc]init];
    [footView addSubview:self.VlabP];
    [self.VlabP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footView.mas_centerX);
        make.top.mas_equalTo(footView).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    self.VlabP.text = @"$ 0";
    self.VlabP.font = [UIFont fontWithName:@"Arial" size:12];
    self.VlabP.textAlignment = NSTextAlignmentCenter;
    self.VlabP.textColor = [UIColor orangeColor];
    
    UILabel * VlabI = [[UILabel alloc]init];
    [footView addSubview:VlabI];
    [VlabI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footView.mas_centerX).offset(50);
        make.top.mas_equalTo(footView).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    VlabI.text = @"不含运费";
    VlabI.textAlignment = NSTextAlignmentCenter;
    VlabI.font = [UIFont fontWithName:@"Arial" size:12];
    VlabI.textColor = [UIColor blackColor];
    
    
    UIButton * VbtnS = [[UIButton alloc]init];
    [footView addSubview:VbtnS];
    [VbtnS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(footView.mas_right);
        make.top.mas_equalTo(footView);
        make.size.mas_equalTo(CGSizeMake(100, 50));

    }];
    [VbtnS setTitle:@"结算" forState:UIControlStateNormal];
    [VbtnS setBackgroundColor:[UIColor orangeColor]];
}

-(void)addModelInfo{
    NumberModel * model =[[NumberModel alloc]init];
    
    model.ID = 1;
    model.price = 100;
    model.number = 1;
    model.title = @"1111111";
    model.info = @"night";
    model.useInfo = @"这是小李子家 >";
    model.photoImage = [UIImage imageNamed:@"icon_night"];
    [self.numberArray addObject:model];
    
    NumberModel * model2 =[[NumberModel alloc]init];
    
    model2.ID = 2;
    model2.price = 200;
    model2.number = 1;
    model2.title = @"2222222";
    model2.info = @"alternate";
    model2.useInfo = @"这是小张子家 >";
    model2.photoImage = [UIImage imageNamed:@"icon_rainbow_alternate"];
    [self.numberArray addObject:model2];
    
    NumberModel * model3 =[[NumberModel alloc]init];
    
    model3.ID = 3;
    model3.price = 300;
    model3.number = 1;
    model3.title = @"333333";
    model3.info = @"gradinet";
    model3.useInfo = @"这是小王子家 >";
    model3.photoImage = [UIImage imageNamed:@"icon_rainbow_gradinet"];
    [self.numberArray addObject:model3];
    
    NumberModel * model4 =[[NumberModel alloc]init];
    
    model4.ID = 4;
    model4.price = 400;
    model4.number = 1;
    model4.title = @"444444";
    model4.info = @"romantic";
    model4.useInfo = @"这是小童子家 >";
    model4.photoImage = [UIImage imageNamed:@"icon_romanticc"];
    [self.numberArray addObject:model4];
    
}
-(NSMutableArray *)numberArray{
    if (_numberArray == nil) {
        _numberArray = [NSMutableArray array];
    }
    return _numberArray;
}
-(NSMutableDictionary *)numberDic{
    if (_numberDic == nil) {
        _numberDic = [NSMutableDictionary dictionary];
    }
    return _numberDic;
}
-(void)selecteALL{
    NSInteger i = 0 ;
    priceAll = 0;
    if (isSelectedAll == NO) {
        UIImage * image =[UIImage imageNamed:@"choose_on"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.leftItem setImage:image ];
        
        for (NumberModel * model in self.numberArray) {
            model.isSelected = YES;
            
        }
        for (int j =0 ; j < self.numberArray.count; j ++) {
            NumberModel * m = self.numberArray[j];
            i = i + m.price * m.number;
        }
        NSString * str = [NSString stringWithFormat:@"合计:￥%ld 不含运费",i];
        priceAll = i;
        self.centerItem.title = str;
         [self.tableView reloadData];
        
        isSelectedAll = YES;
    }else{
        UIImage * image =[UIImage imageNamed:@"choose"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.leftItem setImage:image];
        for (NumberModel * model in self.numberArray) {
            model.isSelected = NO;
            
        }
        NSString * str = [NSString stringWithFormat:@"合计:￥%ld 不含运费",i];
        priceAll = i;
        self.centerItem.title = str;
        [self.tableView reloadData];
        isSelectedAll = NO;
    }
}
-(void)settleAccounts{
    SettlementViewController * settleView =[[SettlementViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:settleView];
    settleView.title = [NSString stringWithFormat:@"%ld",priceAll];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}
-(void)editAndFinish:(id)sender{
    self.editBtn = (UIButton *)sender;
    NumberModel * model = self.numberArray[self.editBtn.tag - 200];
    model.isEdit = !model.isEdit;
    [self updateCurrentCell:self.editBtn.tag - 200];
}
-(void)updateCurrentCell:(NSInteger)number{
    // update row
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:number];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   self.ViewCell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    self.ViewCell.model = self.numberArray[indexPath.section];
    self.numberModel = self.numberArray[indexPath.section];
    
    [self.ViewCell.btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    self.ViewCell.btn.tag = 100 + indexPath.section;
    if (self.numberModel.isEdit == YES) {
        [self.editBtn setTitle:@"Finish" forState:UIControlStateNormal];
                self.ViewCell.topLab.hidden = YES;
                self.ViewCell.topView.hidden = NO;
    }else{
        [self.editBtn setTitle:@"Edit" forState:UIControlStateNormal];
        self.ViewCell.topLab.hidden = NO;
        self.ViewCell.topView.hidden = YES;
    }
    
    if (self.numberModel.isSelected == YES) {
        [self.btn setBackgroundImage:[UIImage imageNamed:@"choose_on"] forState:UIControlStateNormal];
        [self.ViewCell.btn setBackgroundImage:[UIImage imageNamed:@"choose_on"] forState:UIControlStateNormal];
    }else{
        [self.btn setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
        [self.ViewCell.btn setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    }
    self.ViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.ViewCell updateUI:indexPath];

    return self.ViewCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InfoViewController * infoView = [[InfoViewController alloc]init];
    infoView.model = self.numberArray[indexPath.section];
    [self.navigationController pushViewController:infoView animated:YES];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
        /* 首先调用父类的方法 */
        [super setEditing:editing animated:animated];
        /* 使tableView出于编辑状态 */
        [self.tableView setEditing:editing animated:animated];
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.numberArray removeObjectAtIndex:indexPath.section];
        [self.tableView reloadData];
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:tableView.tableHeaderView.frame];
    
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 1;
    
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    self.btn.tag = 100 + section;
    [view addSubview:self.btn];
    
     UILabel * infoLab = [[UILabel alloc]initWithFrame:CGRectMake(50 , 10, 150, 30)];
    infoLab.textColor = [UIColor blackColor];
    
    NumberModel * model = [[NumberModel alloc]init];
    
        model = self.numberArray[section];
        infoLab.text = model.useInfo;
        [view addSubview:infoLab];
    
    self.editBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 10, 60, 30)];
    [self.editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editAndFinish:) forControlEvents:UIControlEventTouchUpInside];
    self.editBtn.tag = 200 + section;
    [view addSubview:self.editBtn];
    return view;
}
-(void)btnSelected:(id)sender{
    
    NSInteger i = 0;
    priceAll = 0;
    self.btn = (UIButton *)sender;
    // 找到cell对应model
    NumberModel * model = self.numberArray[self.btn.tag - 100];
    model.isSelected = !model.isSelected;
    // 遍历选择的model，计算总价格
    for (NumberModel * m in self.numberArray) {
        if (m.isSelected == YES) {
            i = i + m.price * m.number;
        }
    }
    NSString * str = [NSString stringWithFormat:@"合计:￥%ld 不含运费",i];
    self.centerItem.title = str;
    priceAll = i;
    // 刷新指定cell
    [self updateCurrentCell:self.btn.tag - 100];
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.numberArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
