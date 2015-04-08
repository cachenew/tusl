//
//  ViewController.m
//  tusl
//
//  Created by Krunal on 4/8/15.
//  Copyright (c) 2015 KM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadShoppingList];
}

-(void) loadShoppingList{
    items = [[NSMutableArray alloc] initWithContentsOfFile:[self shoppingFileName]];
    if(items == nil){
        items = [[NSMutableArray alloc] init];
    }
}

-(NSString *) shoppingFileName{
    return [NSHomeDirectory() stringByAppendingString:@"/Documents/myList.plist"];
}

- (IBAction)addItemPressed:(id)sender {
    if([_txtItem.text isEqualToString:@""]){
        return;
    }
    
    [self addItemsToShoppingList: _txtItem.text];
    _txtItem.text = @"";
    [self.view endEditing:YES];
}

-(void) addItemsToShoppingList:(NSString *)item{
    NSMutableDictionary *newItem = [[NSMutableDictionary alloc] init];
    [newItem setObject:item forKey:@"Item"];
    [newItem setObject:[NSDate date] forKey:@"DateAdded"];
    [items addObject:newItem];
    [self saveListAndRefresh];
}

-(void) saveListAndRefresh{
    [items writeToFile:[self shoppingFileName] atomically:YES];
    [_tblItems reloadData];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)aTableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section{
    return items.count;
}

-(UITableViewCell *) tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"myCell";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    NSMutableDictionary *currentItem = [items objectAtIndex:indexPath.row];
    cell.textLabel.text = [currentItem objectForKey:@"Item"];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    
    cell.detailTextLabel.text = [df stringFromDate:[currentItem objectForKey:@"DateAdded"]];
    return cell;
}

-(void) tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [items removeObjectAtIndex:indexPath.row];
        [self saveListAndRefresh];
    }
}

@end
