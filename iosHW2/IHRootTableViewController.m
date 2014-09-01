//
//  IHRootTableViewController.m
//  iosHW2
//
//  Created by Claire Hsu on 2014/8/26.
//  Copyright (c) 2014年 livebricks. All rights reserved.
//

#import "IHRootTableViewController.h"
#import "IHTableViewCell.h"
#import "IHLargeImageViewController.h"

#define JSON_URL @"http://www.indexbricks.com/data/get_update.php?function_code=Profile&store=livebricks&version=0&language=TW"


@interface IHRootTableViewController ()

@end


@implementation IHRootTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.center = self.tableView.center;
    [indicatorView startAnimating];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:indicatorView];
    
    imgPaths = [[NSMutableArray alloc]init];
    
    
    
    //Async
    if ([jsonDataAll count]<=0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
            NSURL *url = [NSURL URLWithString:JSON_URL];
            NSData *jsonData = [NSData dataWithContentsOfURL:url];
            NSError *jsonError = nil;
            
            jsonDataAll = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
            //NSLog(@"Json data:%@",[jsonDataAll description]);
            itemsArr = [jsonDataAll objectForKey:@"livebricks"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
               
                
            });
            
        });
        
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    

}

-(void)updateUI:(IHTableViewCell *)cell index:(int)rowIndex{
    
    
    NSLog(@"in %d", rowIndex);
    //NSLog(@"items_num:%d",[itemsArr count]);
    if ([jsonDataAll count]>0) {
        [indicatorView removeFromSuperview];
        NSDictionary *itemsDic = [itemsArr objectAtIndex:rowIndex];
        NSString* catDescStr = [itemsDic objectForKey:@"category_description"];
        NSString* nameTitleStr = [itemsDic objectForKey:@"name_title"];
        NSString* nameStr = [itemsDic objectForKey:@"name"];
        cell.catDscLabel.text = catDescStr;
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ : %@",nameTitleStr,nameStr];
        
        
        //img
        NSString *imgFilePath = [itemsDic objectForKey:@"image_filepath"];
        __block NSData *imgData;
        
        //Check img file in Cache
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachesDirectory = [paths objectAtIndex:0];
        
        NSString *cacheImgPath = [cachesDirectory stringByAppendingPathComponent:imgFilePath];
        [imgPaths addObject:cacheImgPath];
        NSString *imgUrlStr = [itemsDic objectForKey:@"category_image_url"];
        
        
        if (![[NSFileManager defaultManager]fileExistsAtPath:cacheImgPath]) {
            cell.imgView.image = [UIImage imageNamed:@"asset@2x.png"];
            //Download img file __Async
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
                
                imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrlStr]];
                [imgData writeToFile:cacheImgPath atomically:YES];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imgView.image = [UIImage imageWithContentsOfFile:cacheImgPath];

                });
                
            });
         
            
        }else{
            
            imgData = [NSData dataWithContentsOfFile:cacheImgPath];
            cell.imgView.image = [UIImage imageWithData:imgData];
            
        }
        
    }
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"numberOfRowsInSection called!");
    if ([itemsArr count]>0) {
        return [itemsArr count];
    }else{
        return 5;
    }
    
}

#pragma mark - Table view delegate


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath called!");
    NSString *cellIdentifier = @"Cell";
    IHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[IHTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    
//    if (indexPath.row ==2) {
//        cell.catDscLabel.text = @"tqwertyuiosdfgdfghopfghjklcvbnmdfghjertyu45678klx00000000000000000cvbnm,dfghjklthjkl,";
//    }else{
//        cell.catDscLabel.text = @"test";
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     [self updateUI:cell index:indexPath.row];
  
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}



 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
     [tableView reloadData];
     
 // Navigation logic may go here, for example:
 // Create the next view controller.
    
 IHLargeImageViewController *largeImgViewController = [[IHLargeImageViewController alloc] initWithNibName:@"IHLargeImageViewController" bundle:nil];
 
 // Pass the selected object to the new view controller.
     largeImgViewController.imgFilePath = [imgPaths objectAtIndex:indexPath.row];
     // Push the view controller.
 [self.navigationController pushViewController:largeImgViewController animated:YES];
 }
 


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



@end
