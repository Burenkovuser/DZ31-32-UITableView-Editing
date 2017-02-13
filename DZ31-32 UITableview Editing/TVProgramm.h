//
//  TVProgramm.h
//  DZ31-32 UITableview Editing
//
//  Created by Vasilii on 13.02.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVProgramm : NSObject

@property(strong, nonatomic) NSString* programmName;
@property(assign, nonatomic) float timeIntrval;

+(TVProgramm*) randomProgramm;

@end
