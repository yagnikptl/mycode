//
//  DBHandler.m
//  InsertData
//
//  Created by r shah on 29/08/13.
//  Copyright (c) 2013 r shah. All rights reserved.
//


#import "DBHandler.h"
static DBHandler *sharedInstance = nil;
@implementation DBHandler

+(DBHandler*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance checkDBAndCopy];
        
    }
    return sharedInstance;
}
- (id)init
{
    if (self = [super init]) {
        arrData=[[NSMutableArray alloc]init];
        str = [[NSMutableString alloc]init];
        isSuccess = NO;
        
        [self checkDBAndCopy];

//        userID = 0;
    }
    return self;
}

-(void)checkDBAndCopy
{
    NSArray *dirPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *connectionPath=[dirPath objectAtIndex:0];
    strDBPath=[connectionPath stringByAppendingPathComponent:@"formdb.sqlite"];
    NSLog(@"DBPath :- %@",strDBPath);
    NSFileManager *filemanager=[[NSFileManager alloc]init];
    if (![filemanager fileExistsAtPath:strDBPath]) {
        NSString *databasePathFromApp=[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"formdb.sqlite"];
        
        [filemanager copyItemAtPath:databasePathFromApp toPath:strDBPath error:nil];
    }
}
-(BOOL)upDate:(NSString*)query
{
    isSuccess = NO;
    
    [self checkDBAndCopy];
    
    if(sqlite3_open([strDBPath UTF8String],&contactDB) == SQLITE_OK)
    {
         sqlite3_stmt *statement=nil;
        
        if(sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &statement, NULL)== SQLITE_OK)
        {
            sqlite3_step(statement);
            isSuccess = YES;            
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(contactDB);
    
    return isSuccess;
}

-(BOOL)insertData:(NSString*)query
{
   isSuccess = NO;
    
    [self checkDBAndCopy];

    if (sqlite3_open([strDBPath UTF8String], &contactDB)==SQLITE_OK)
    {
        
        sqlite3_stmt *statement=nil;
        
        if (sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &statement, nil)==SQLITE_OK) {
            
            sqlite3_step(statement);
            isSuccess =YES;
            
        }sqlite3_finalize(statement);
        
    }
    sqlite3_close(contactDB);
    
    return isSuccess;
}
-(BOOL)DeleteRecord:(NSString *)query
{
   isSuccess = NO;
    
    ////[self checkDBAndCopy];
    
    if (sqlite3_open([strDBPath UTF8String], &contactDB)==SQLITE_OK) {
        
        sqlite3_stmt *compileStatement;
        
        if (sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &compileStatement, NULL)==SQLITE_OK) {
            
            sqlite3_step(compileStatement);
            isSuccess = YES;
        
        }sqlite3_finalize(compileStatement);
    }
    sqlite3_close(contactDB);
    
    return isSuccess;
}
#pragma mark - GetUSerID
-(int)getUserID:(NSString *)query{

   if (sqlite3_open([strDBPath UTF8String], &contactDB)==SQLITE_OK) {
        
        sqlite3_stmt *complieStmt;
        
        if (sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &complieStmt, NULL)==SQLITE_OK) {
            
            while (sqlite3_step(complieStmt)==SQLITE_ROW)
            {
                userID = sqlite3_column_int(complieStmt, 0);
            }
            sqlite3_finalize(complieStmt);
        }
        sqlite3_close(contactDB);
    }
    return userID;
}
-(BOOL)getemailID:(NSString *)query
{
    
    if (sqlite3_open([strDBPath UTF8String], &contactDB)==SQLITE_OK) {
        
        sqlite3_stmt *complieStmt;
        
        if (sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &complieStmt, NULL)==SQLITE_OK) {
            
            while (sqlite3_step(complieStmt)==SQLITE_ROW)
            {
                return YES;
            }
            sqlite3_finalize(complieStmt);
        }
        sqlite3_close(contactDB);
    }
    return NO;
}

-(NSMutableArray *)getData:(NSString *)strQuery
{
    strLastDate = @"";
    if (arrData.count != 0)
    {
        [arrData removeAllObjects];
    }
    
    if (sqlite3_open([strDBPath UTF8String], &contactDB)==SQLITE_OK) {
        
        
        sqlite3_stmt *complieStmt=nil;
        
        
        if (sqlite3_prepare_v2(contactDB, [strQuery UTF8String], -1, &complieStmt, NULL)==SQLITE_OK) {
            
            while (sqlite3_step(complieStmt)==SQLITE_ROW) {
                
                //[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 2)];
                
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                //[dict setObject:@"query1" forKey:@"name"];
                //[dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 0)] forKey:@"cid"];
                //[dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 0)] forKey:@"eid"];
                //[dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 1)] forKey:@"cid"];
                 [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 1)] forKey:@"name"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 2)] forKey:@"email"];
                
                
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 3)] forKey:@"phone"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 4)] forKey:@"address"];
                 [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 5)] forKey:@"gender"];
                
                 [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 6)] forKey:@"hobbies"];
                 [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 7)] forKey:@"birthdate"];
                 [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 8)] forKey:@"rating"];
                 [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 9)] forKey:@"photos"];
                 [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 10)] forKey:@"country"];
                 [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 11)] forKey:@"state"];
                 [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 12)] forKey:@"city"];
//                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 5)] forKey:@"comment"];
//                 [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 6)] forKey:@"allimages"];
                //[dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 8)] forKey:@"creationdate"];
                //[dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 7)] forKey:@"password"];
                //[dict setValue:(((char *) sqlite3_column_text(complieStmt, 2)) == NULL)? @"":[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 2)] forKey:@"name"];
                
                //                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 0)] forKey:@"rowId"];
                //                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 1)] forKey:@"id"];
                //
                //                [dict setValue:[NSString stringWithUTF8String:(const char *) sqlite3_column_text(complieStmt, 5)] forKey:@"sent"];
                //                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 6)] forKey:@"sender"];
                //                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 7)] forKey:@"receiver"];
                //                [dict setValue:[NSString stringWithUTF8String:(const char *) sqlite3_column_text(complieStmt, 8)] forKey:@"mediaPathLocal"];
                //                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 9)] forKey:@"mediaPathServer"];
                //                [dict setValue:[NSString stringWithUTF8String:(const char *) sqlite3_column_text(complieStmt, 10)] forKey:@"mediaStatus"];
                //                [dict setValue:[NSString stringWithUTF8String:(const char *) sqlite3_column_text(complieStmt, 14)] forKey:@"section"];
                [arrData addObject:dict];
                
                //strLastDate = [[arrData objectAtIndex:arrData.count-1] valueForKey:@"sent"];
                dict = nil;
            }
            
            sqlite3_finalize(complieStmt);
        }
        sqlite3_close(contactDB);
    }
    return arrData;
    

}
-(NSMutableArray *)GetAllData:(NSString *)strQuery
{
    
    strLastDate = @"";
    if (arrData.count != 0)
    {
        [arrData removeAllObjects];
    }
    
    if (sqlite3_open([strDBPath UTF8String], &contactDB)==SQLITE_OK) {
        
        
        sqlite3_stmt *complieStmt=nil;
        
        
        if (sqlite3_prepare_v2(contactDB, [strQuery UTF8String], -1, &complieStmt, NULL)==SQLITE_OK) {
            
            while (sqlite3_step(complieStmt)==SQLITE_ROW) {
                
                //[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 2)];
                
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                //[dict setObject:@"query1" forKey:@"name"];
                //[dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 0)] forKey:@"cid"];
                //[dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 0)] forKey:@"eid"];
                //[dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 1)] forKey:@"cid"];
                //[dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 0)] forKey:@"name"];
                //[dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 3)] forKey:@"position"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 1)] forKey:@"name"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 2)] forKey:@"email"];
                
                
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 3)] forKey:@"phone"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 4)] forKey:@"address"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 5)] forKey:@"gender"];
                
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 6)] forKey:@"hobbies"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 7)] forKey:@"birthdate"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 8)] forKey:@"rating"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 9)] forKey:@"photos"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 10)] forKey:@"country"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 11)] forKey:@"state"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 12)] forKey:@"city"];
                //[dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 5)] forKey:@"address"];
                //[dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 6)] forKey:@"phone"];
                //[dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 5)] forKey:@"email"];
                //[dict setValue:(((char *) sqlite3_column_text(complieStmt, 2)) == NULL)? @"":[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 2)] forKey:@"name"];
                
                //                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 0)] forKey:@"rowId"];
                //                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 1)] forKey:@"id"];
                //
                //                [dict setValue:[NSString stringWithUTF8String:(const char *) sqlite3_column_text(complieStmt, 5)] forKey:@"sent"];
                //                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 6)] forKey:@"sender"];
                //                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 7)] forKey:@"receiver"];
                //                [dict setValue:[NSString stringWithUTF8String:(const char *) sqlite3_column_text(complieStmt, 8)] forKey:@"mediaPathLocal"];
                //                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 9)] forKey:@"mediaPathServer"];
                //                [dict setValue:[NSString stringWithUTF8String:(const char *) sqlite3_column_text(complieStmt, 10)] forKey:@"mediaStatus"];
                //                [dict setValue:[NSString stringWithUTF8String:(const char *) sqlite3_column_text(complieStmt, 14)] forKey:@"section"];
                [arrData addObject:dict];
                
                //strLastDate = [[arrData objectAtIndex:arrData.count-1] valueForKey:@"sent"];
                dict = nil;
            }
            
            sqlite3_finalize(complieStmt);
        }
        sqlite3_close(contactDB);
    }
    return arrData;
    
}

#pragma mark GetAllData
-(NSMutableArray *)arrGetAllData:(NSString *)strQuery
{

    strLastDate = @"";
    if (arrData.count != 0)
    {
        [arrData removeAllObjects];
    }
    
    if (sqlite3_open([strDBPath UTF8String], &contactDB)==SQLITE_OK) {
        
       
         sqlite3_stmt *complieStmt=nil;
        
        
        if (sqlite3_prepare_v2(contactDB, [strQuery UTF8String], -1, &complieStmt, NULL)==SQLITE_OK) {
            
            while (sqlite3_step(complieStmt)==SQLITE_ROW) {
                
                //[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 2)];
               
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                //[dict setObject:@"query1" forKey:@"name"];
                //[dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 0)] forKey:@"cid"];
                //[dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 0)] forKey:@"eid"];
                //[dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 1)] forKey:@"cid"];
                [dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 0)] forKey:@"name"];
                //[dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 3)] forKey:@"position"];
                //[dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 4)] forKey:@"email"];
                //[dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 5)] forKey:@"address"];
                //[dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 6)] forKey:@"phone"];
                //[dict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 7)] forKey:@"password"];
              //[dict setValue:(((char *) sqlite3_column_text(complieStmt, 2)) == NULL)? @"":[NSString stringWithUTF8String:(char *)sqlite3_column_text(complieStmt, 2)] forKey:@"name"];
                
//                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 0)] forKey:@"rowId"];
//                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 1)] forKey:@"id"];
//
//                [dict setValue:[NSString stringWithUTF8String:(const char *) sqlite3_column_text(complieStmt, 5)] forKey:@"sent"];
//                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 6)] forKey:@"sender"];
//                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 7)] forKey:@"receiver"];
//                [dict setValue:[NSString stringWithUTF8String:(const char *) sqlite3_column_text(complieStmt, 8)] forKey:@"mediaPathLocal"];
//                [dict setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(complieStmt, 9)] forKey:@"mediaPathServer"];
//                [dict setValue:[NSString stringWithUTF8String:(const char *) sqlite3_column_text(complieStmt, 10)] forKey:@"mediaStatus"];
//                [dict setValue:[NSString stringWithUTF8String:(const char *) sqlite3_column_text(complieStmt, 14)] forKey:@"section"];
                [arrData addObject:dict];
                
                //strLastDate = [[arrData objectAtIndex:arrData.count-1] valueForKey:@"sent"];
                dict = nil;
            }
            
            sqlite3_finalize(complieStmt);
        }
        sqlite3_close(contactDB);
    }
    return arrData;

}

- (NSString *)checkDataFromDB:(NSString *)strQuery
{
    if (sqlite3_open([strDBPath UTF8String], &contactDB)==SQLITE_OK) {
        
        sqlite3_stmt *statement;
        
        if (sqlite3_prepare_v2(contactDB, [strQuery UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            
            while (sqlite3_step(statement)==SQLITE_ROW) {
                
                str = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
          
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(contactDB);
    
    return str;
}


@end
