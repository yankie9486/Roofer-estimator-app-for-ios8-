//
//  TableViewController.m
//  RooferEstimator
//
//  Created by Giancarlo on 5/20/14.
//  Copyright (c) 2014 NFAS. All rights reserved.
//

#import "TableViewController.h"
#import "CustomerCell.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSLog(@"init TableViewController");
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *color = [[UIColor alloc] initWithRed:53 green:127 blue:52 alpha:1.0];
    
    self.navigationController.navigationBar.barTintColor = color;
    
    
    // Add an edit button to the "add" button in the
    // rightBarButtonItems array.
    self.navigationItem.rightBarButtonItems =
    @[self.navigationItem.rightBarButtonItem, self.editButtonItem];
    
    self.content = [[NSMutableArray alloc] init];
    self.RoofE = [[RoofEstimate alloc] init];
    
    xmlFO = [[XMLFileOps alloc] init];
    
    if ([xmlFO doesFileExist])
        self.content = [xmlFO LoadXml];
    
    //RoofEstimate *re = [self.content objectAtIndex:0];
    //NSLog(@"%lu",(unsigned long)re.RoofType.RoofSize.count);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomerCellIdentifier = @"CustomerCell";
    
    CustomerCell *cell = (CustomerCell *)[tableView
                                          dequeueReusableCellWithIdentifier:CustomerCellIdentifier];
    RoofEstimate *re = [self.content objectAtIndex:indexPath.row];
    cell.nameLabel.text =  re.Name;
    cell.phoneLabel.text = re.Phone;
    
    if ( [re.Address  isEqual: @""] && [re.City  isEqual: @""] && [re.State  isEqual: @""] && [re.Zip  isEqual: @""]  )
    {
        
        cell.addressLabel.text = [NSString stringWithFormat:@" "];
        
        
    }
    else if ( [re.State  isEqual: @""]  )
    {
        cell.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ ",re.Address,re.City,re.State,re.Zip];
    }
    else
    {
        cell.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@, %@ ",re.Address,re.City,re.State,re.Zip];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source first…
        @autoreleasepool
        {
            NSMutableArray *tempContent = [self.content mutableCopy];
            [tempContent removeObject:[tempContent                                                                objectAtIndex:indexPath.row]];
            self.content = tempContent;
        }
        //now delete the row from the table view:
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [xmlFO saveToXML:self.content];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    avc.RoofE = [self.content objectAtIndex:indexPath.row];
    avc.Row = indexPath.row;
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"adding"])
    {
        avc = segue.destinationViewController;
        avc.title = @"Roof Measurement";
        avc.segueAD = @"adding";
        avc.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"detail"])
    {
        avc = segue.destinationViewController;
        avc.title = @"Roof Measurement";
        avc.segueAD = @"detail";
        avc.delegate = self;
    }
    else
    {
        NSLog(@"ERROR: Unknown segue identifier!");
        exit(1);
    }
}


#pragma mark - AddingController Delegate

- (void)addingControllerDidCancel:(AddingController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addingController:(AddingController *)controller didAddRoofInfo:(RoofEstimate *)roofEstimate
{
    
	[self.content addObject:roofEstimate];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[self.content count]-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    [xmlFO saveToXML:self.content];
    
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addingController:(AddingController *)controller didAddRoofInfo:(RoofEstimate *)roofEstimate Row:(NSInteger)row
{
    [self.content removeObjectAtIndex:row];
    [self.content insertObject:roofEstimate atIndex:row];
    [xmlFO saveToXML:self.content];
    
    [self.tableView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}





@end
