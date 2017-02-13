//
//  TVProgramm.m
//  DZ31-32 UITableview Editing
//
//  Created by Vasilii on 13.02.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "TVProgramm.h"

@implementation TVProgramm

static NSString* programmName[] = {
    @"Главные новости",
    @"РБК. Спорт",
    @"Новости недели",
    @"Новости. Отрасли",
    @"Главные новости. Пресс-карта",
    @"РБК. Рынки",
    @"Новости компаний",
    @"РБК. Ежедневник",
    @"Главные новости. Спорт",
    @"РБК. Рынки",
    @"Мир сегодня",
    @"Пресс-карта",
    @"Рынок онлайн",
    @"Спорт",
    @"Токарев. Дело",
    @"РБК. Эксперт"
    @"Хрупова. Лидеры рынка",
    @"Демидович. Реальная экономика"
    @"Бабич. Тренд"
    @"Левченко. Ракурс"
    @"Таманцев. Итоги"
    @"РБК. Прайм-Тайм"
};

static int programmCount = 23;


+(TVProgramm*) randomProgramm {
    TVProgramm* programm = [[TVProgramm alloc] init];
    programm.programmName = programmName[arc4random() % programmCount];
    programm.timeIntrval = ((float)(arc4random() % 700 + 801)) /100;
    
    return programm;
}
@end


