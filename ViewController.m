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
//#import "Group.h"
//#import "Student.h"


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
    
    //tableView.editing = YES;// включем режим редактирования
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //СОЗДАЕМ ТАБЛИЦУ
    
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
    
    self.navigationItem.title = @"TV Programms";//заголовок в navigation
    
    //создаем кнопку
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    self.navigationItem.rightBarButtonItem = editButton; //размещаем кнопку справа
    
    //создаем кнопку
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                target:self
                                                                                action:@selector(actionAddSection:)];
    self.navigationItem.leftBarButtonItem = addButton; //размещаем кнопку слева
    
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

#pragma mark - Actions
//метод для editButton (меняем кнопку для редактирования)
- (void) actionEdit:(UIBarButtonItem*) sendler {
    BOOL isEditing = self.tableView.editing;//узнаем находимся ли в режиме редактирования
    [self.tableView setEditing:!isEditing animated:YES];//
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit; // будет эта кнопка если не редактируется
    
    if (self.tableView.editing) {
        item = UIBarButtonSystemItemDone;//будет кнопка если редактирвуется
    }
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    //self.navigationItem.rightBarButtonItem = editButton; //размещаем кнопку справа без анимации
    [self.navigationItem setRightBarButtonItem:editButton animated:YES]; // c анимацией

}

-(void) actionAddSection:(UIBarButtonItem*) sender { // Метод добавляет ТВ канал при нажатии на кнопку (+)
    
    Channel *channal = [[Channel alloc] init];
    channal.channelName = [NSString stringWithFormat:@"Channal %lu", [self.channelArray count] +1];
    channal.programms = @[[TVProgramm randomProgramm], [TVProgramm randomProgramm]];//добавляем по два рендномных канала за раз
    
    NSInteger newSectionIndex = 0;
    
    [self.channelArray insertObject:channal atIndex:newSectionIndex];//вставляем новый канал в начало
    
    //[self.tableView reloadData];// презагружаем таблицу
    
    [self.tableView beginUpdates]; //начинаем внутри анимации
    
    NSIndexSet* insertSection = [NSIndexSet indexSetWithIndex:newSectionIndex]; //создаем набор куда доваляем новую секцию
    
    [self.tableView insertSections:insertSection withRowAnimation:UITableViewRowAnimationLeft]; //анимация слева
    
    [self.tableView endUpdates];
    
    //запрещаем игнорируем любые нажатия в приложении
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {//если игнорируется
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];//заканчиваем игнорировать нажатия через 0.3 секунды
        }
    });
}

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
    return [chanal.programms count] +1; //плюс 1 ломает программу+
    //return 5;
    //Group * group = [self.groupsArrey objectAtIndex:section];
    //return [group.studrnts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString* addProgramIidentifier = @"AddProgrammCell";
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:addProgramIidentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addProgramIidentifier]; //если менять цвета, шрифт и т.д. лучше делать это здесь
            cell.textLabel.textColor = [UIColor blueColor];
            cell.textLabel.text = @"Add programm";
    }
        return  cell;
        
    } else {
        
        static NSString* programIidentifier = @"ProgrammCell";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:programIidentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:programIidentifier]; //если менять цвета, шрифт и т.д. лучше делать это здесь
        }
        
        Channel* chanal = [self.channelArray objectAtIndex:indexPath.section];//канал соответсвует секции
        TVProgramm* programm = [chanal.programms objectAtIndex:indexPath.row - 1];//программа это ряд
        
        cell.textLabel.text = [NSString stringWithFormat:@" %@", programm.programmName];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f",programm.timeIntrval];
        
        return cell;
    }
    
}


/*
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
    cell.textLabel.text = [NSString stringWithFormat:@" %@", programm.programmName];
    //cell.textLabel.text = [NSString stringWithFormat:@"Studrnt %@ %@", student.lastName, student.firstName];
    
    
    //cell.detailTextLabel.text = @"Value";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f",programm.timeIntrval];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f",student.averageGrade];
    return cell;
}
*/
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row > 0;//разрешаем перемещать
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath { // метод для реализации перемещения объектов между секциями!
    //источик канал откуда берем данные(программы) для перемещения
    Channel* sourceChannel = [self.channelArray objectAtIndex:sourceIndexPath.section];//секция соответствует каналу
    TVProgramm* programm = [sourceChannel.programms objectAtIndex:sourceIndexPath.row - 1];//строка соответствует программе
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sourceChannel.programms];
    
    if (sourceIndexPath.section == destinationIndexPath.section) { //если находятся в одной секции
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row - 1 withObjectAtIndex:destinationIndexPath.row - 1];// меняем строки местами
        sourceChannel.programms = tempArray;
    } else {
        
        [tempArray removeObject:programm];//удаляем программу
        sourceChannel.programms = tempArray;
        
        //Берем канал куда будет перемещатся программа
        Channel *destinationChannal = [self.channelArray objectAtIndex:destinationIndexPath.section];
        
        tempArray = [NSMutableArray arrayWithArray:destinationChannal.programms];
        [tempArray insertObject:programm atIndex:destinationIndexPath.row - 1];
        destinationChannal.programms = tempArray;
    }
    
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;//убираем красный шарик для редактирования
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO; //не двигается строка слева при редактировании
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath { // метод который информирует, куда положится строка после перемещения.
    
    if (proposedDestinationIndexPath.row == 0) { // Не даем ряду встать под индексом 0, так как этот индекс закреплен за кнопкой добавления программы на канал.
        
        return sourceIndexPath;
        
    } else {
        
        return proposedDestinationIndexPath;
    }

}
@end
