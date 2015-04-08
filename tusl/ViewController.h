//
//  ViewController.h
//  tusl
//
//  Created by Krunal on 4/8/15.
//  Copyright (c) 2015 KM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSMutableArray *items;
}

@property (weak, nonatomic) IBOutlet UITextField *txtItem;

@property (weak, nonatomic) IBOutlet UITableView *tblItems;


- (IBAction)addItemPressed:(id)sender;

@end

