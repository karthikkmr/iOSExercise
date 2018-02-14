//
//  ViewController.h
//  iOSExercise
//
//  Created by Admin on 11/02/18.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkHandler.h"
#import "Utilities.h"

@interface ViewController : UIViewController <NetworkHandlerDelegate, UITableViewDelegate, UITableViewDataSource>{
    CGRect screenRect;
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    Utilities *utilities;
    
    
    UITableView *dataTable;
    UIRefreshControl *refreshControl;
    
    NetworkHandler *myHandler;
}

@property(nonatomic) BOOL checkConnection;
@property(nonatomic) NSInteger rowsCount;
@property(nonatomic) NSMutableArray *itemscount;
@property(nonatomic) NSString *webAPIURl;
@property(nonatomic) NSString *titleString;


-(void)didFinishDetails:(NSDictionary*) resultDictionary;

-(void)connectionCheck;
-(void)tableItemcount;
-(void)apiURlMethod;
-(void)webDataMethod;

@end

