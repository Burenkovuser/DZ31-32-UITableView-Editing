//
//  ViewController.m
//  DZ31-32 UITableview Editing
//
//  Created by Vasilii on 13.02.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "ViewController.h"
#import "Channel.h"
#import "TVProgramm.h"
#import "Group.h"
#import "Student.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property(weak, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *channelArray;



//для студента
@property(strong, nonatomic) NSMutableArray *groupsArrey;

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
    //self.tableView.backgroundColor = [UIColor redColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.channelArray = [NSMutableArray array];
    
    //создает ТВ каналы рендомно
    for (int i = 0; i < (arc4random() % 6 + 5); i++) {
        
        Channel *channal = [[Channel alloc] init];
        channal.channelName = [NSString stringWithFormat:@"Channal %@",@(i)];
        
        NSMutableArray* array = [NSMutableArray array];
        
        //создаем ТВ программы
        for (int j = 0; j < (arc4random() % 11 + 15); j++) {
            [array addObject:[TVProgramm randomProgramm]];
        }
        channal.programms = array; // в каналы добаляем программы
        [self.channelArray addObject:channal];//добавляем программу в массив каналов
    }
    [self.tableView reloadData]; //презагружаем дынные в tableView
/*
    self.groupsArrey = [NSMutableArray array];
    
    for (int i = 0; i < (arc4random() % 6 + 5); i++) {
        Group *group = [[Group alloc] init];
        group.name = [NSString stringWithFormat:@"Group %@",@(i)];
  
        NSMutableArray* array = [NSMutableArray array];

        for (int j = 0; j < (arc4random() % 11 + 15); j++) {
            [array addObject:[Student randomStudent]];
        }
        group.studrnts = array;
        [self.groupsArrey addObject:group];
}
    [self.tableView reloadData]; */
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
    return [self.channelArray count];//равно количеству каналов
    //return 5;
    //return self.groupsArrey.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.channelArray objectAtIndex:section] channelName];
    //return [NSString stringWithFormat:@"Sextion %ld Heder", (long)section];
    return [[self.groupsArrey objectAtIndex:section] name];
    //Group *group=self.groupsArray[section] name];
    //return [NSString stringWithFormat:@"%@",group.name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { // количество рядов в секции соответсует количеству программ в канале
    Channel* chanal = [self.channelArray objectAtIndex:section];
    return [chanal.programms count];
    //return 5;
    //Group * group = [self.groupsArrey objectAtIndex:section];
    //return [group.studrnts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier]; //если менять цвета, шрифт и т.д. лучше делать это здесь
    }
    
    Channel* chanal = [self.channelArray objectAtIndex:indexPath.section];//канал соответсвует секции
    TVProgramm* programm = [chanal.programms objectAtIndex:indexPath.row];//программа это ряд
    //Group* group = [self.groupsArrey objectAtIndex:indexPath.section];
    //Student* student = [group.studrnts objectAtIndex:indexPath.row];
    
    //Group *group=self.groupsArray[indexPath.section];
    //Student *student=group.students[indexPath.row];
    //cell.textLabel.text = [NSString stringWithFormat:@"Section %ld", indexPath.section];
    cell.textLabel.text = [NSString stringWithFormat:@"Section %@", programm.programmName];
    //cell.textLabel.text = [NSString stringWithFormat:@"Studrnt %@ %@", student.lastName, student.firstName];
    
    
    //cell.detailTextLabel.text = @"Value";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f",programm.timeIntrval];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f",student.averageGrade];
    return cell;
}


@end
