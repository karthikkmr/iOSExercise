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
    BOOL checkConnection;
    NSMutableArray *itemscount;
    UITableView *dataTable;
    UIRefreshControl *refreshControl;
    
    NetworkHandler *myHandler;
}

-(void)didFinishDetails:(NSDictionary*) resultDictionary;

@end

