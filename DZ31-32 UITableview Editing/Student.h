//
//  Student.h
//  DZ31-32 UITableview Editing
//
//  Created by Vasilii on 14.02.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property(strong, nonatomic) NSString* firstName;
@property(strong, nonatomic) NSString* lastName;
@property(assign, nonatomic) float averageGrade;

+(Student*) randomStudent;

@end
