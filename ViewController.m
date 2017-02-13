//
//  ViewController.m
//  DZ31-32 UITableview Editing
//
//  Created by Vasilii on 13.02.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property(weak, nonatomic) UITableView *tableView;

@end

@implementation ViewController

#pragma mark - My metods

-(void) loadView {
    
    [super loadView];
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;// так делают стандартно фрейм
    
    // Инициализировали таблицу на нашей вьюхе
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];//можно установить другой стиль
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];// добавляем на экран
    self.tableView = tableView; //добавляем наше проперти
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { //количество секций
    return 5;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %ld Header", (long)section];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %ld Footer", (long)section];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier]; //если менять цвета, шрифт и т.д. лучше делать это здесь
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Section %ld , Row %ld", indexPath.section, (long)indexPath.row];
    cell.detailTextLabel.text = @"Value";
    
    return cell;
}


@end
