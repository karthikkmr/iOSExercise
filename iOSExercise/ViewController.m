//
//  ViewController.m
//  iOSExercise
//
//  Created by Admin on 11/02/18.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

NSString *const webserviceAPI = @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json";

@interface ViewController ()

@end

@implementation ViewController
@synthesize itemscount;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"iOS Exercise";
    
    itemscount = [[NSMutableArray alloc] init];
    utilities = [[Utilities alloc] init];
    myHandler = [[NetworkHandler alloc] init];
    myHandler.delegate = self;
    
    // Get Current Screen Size
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    // TableView Allocation
    dataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
    dataTable.delegate = self;
    dataTable.dataSource = self;
    dataTable.bounces = true;
    dataTable.allowsSelection = false;
    [self.view addSubview:dataTable];
    
//    dataTable.rowHeight = UITableViewAutomaticDimension;
//    dataTable.estimatedRowHeight = 400;
    
    [dataTable registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"MyIdentifier"];
    [dataTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    // Refresh Control
    refreshControl = [[UIRefreshControl alloc]init];
    [dataTable addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

//-(void)setNeedsLayout{
//    [self.view layoutIfNeeded];
//    [dataTable reloadData];
//}

-(void)viewWillAppear:(BOOL)animated{
    // Check Internet Connection and load data
    [self connectionCheck];
}

-(void)connectionCheck{
    self.checkConnection = [utilities connectedToNetwork];
    if (!self.checkConnection) {
        UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"No internet" message:@"No internet connection found. Please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        [myHandler didFinishWebService:webserviceAPI];
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([dataTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [dataTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([dataTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [dataTable setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)refreshTable {
    //TODO: refresh your data
    [refreshControl endRefreshing];
    [self connectionCheck];
}
#pragma Tableview Delegate and Datasource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemscount.count;    //count number of row
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyIdentifier";
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.backgroundColor = [UIColor whiteColor];

    // Load details from Array
    NSDictionary *dict = [itemscount objectAtIndex:indexPath.row];
    NSString *headingStr = [dict valueForKey:@"title"];
    NSString *descriptionStr = [dict valueForKey:@"description"];
    NSString *imageStr = [dict valueForKey:@"imageHref"];
    
    // Heading Label
    if (!([headingStr isEqual:[NSNull null]] || headingStr == nil )) {
        cell.headingLbl.text = headingStr;
    }else{
        cell.headingLbl.text = @"";
    }
    // Description Label
    if (!([descriptionStr isEqual:[NSNull null]] || descriptionStr == nil )) {
        cell.descriptionLbl.text = descriptionStr;
    }else{
        cell.descriptionLbl.text = @"";
    }
    
    // Thumb image
    if (!([imageStr isEqual:[NSNull null]] || imageStr == nil )) {
        NSURL *imgURL = [NSURL URLWithString:imageStr];
        NSLog(@"%@",imgURL);
        dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        dispatch_async(backgroundQueue, ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgURL]];
            // only update UI on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.thumbImg.image = image;
            });
        });
    }else{
        cell.thumbImg.image = [UIImage imageNamed:@""];
    }
    
//    [cell.contentView setNeedsLayout];
//    [cell.contentView layoutIfNeeded];

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
//    {
//        return 200;
//    }else{
//        return 150;
//    }
//    return UITableViewAutomaticDimension;
//}

// For Dynamic Tableview cell height


// NetworkHandler DidFinish Delegate Method
-(void)didFinishDetails:(NSDictionary*) resultDictionary{
    
    //UINavigationBar Title Text chages Here
    self.titleString = [resultDictionary valueForKey:@"title"];
    self.navigationController.navigationBar.topItem.title = self.titleString;
    itemscount = [resultDictionary valueForKey:@"rows"];
    // UI update should be done on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        [dataTable reloadData];
    });
}

-(void)tableItemcount{
    self.rowsCount = itemscount.count;
}
-(void)apiURlMethod{
    self.webAPIURl = webserviceAPI;
}
-(void)webDataMethod{
    self.titleString = @"About Canada";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
