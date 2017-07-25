//
//  DBHandler.h
//  InsertData
//
//  Created by r shah on 29/08/13.
//  Copyright (c) 2013 r shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DBHandler : NSObject
{
    sqlite3 *contactDB;
    NSString *strDBPath;
    NSString *str;
    NSString *strUSerID;
    NSMutableArray *arrData;
    NSMutableDictionary *dicData;
    BOOL isSuccess;
    int userID;
    NSDateFormatter *dateFormat;
    NSString *strLastDate;
}
+(DBHandler*)getSharedInstance;

- (int)getUserID:(NSString *)query;
-(BOOL)getemailID:(NSString *)query;

-(NSMutableArray *)getData:(NSString *)strQuery;
-(NSMutableArray *)GetAllData:(NSString *)strQuery;
//-(NSMutableArray *)GetAllData:(NSString *)strQuery;
- (NSMutableArray *)arrGetAllData:(NSString *)strQuery;
- (NSString *)checkDataFromDB:(NSString *)strQuery;
- (void)checkDBAndCopy;
- (BOOL)insertData:(NSString*)query;
- (BOOL)DeleteRecord:(NSString *)query;
- (BOOL)upDate:(NSString*)query;

//////
@end
