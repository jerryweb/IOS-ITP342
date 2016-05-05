//
//  PlaceCollectionViewController.m
//  Lab 6
//
//  Created by LJ on 4/25/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "PlaceCollectionViewController.h"
#import "PlaceItemCollectionViewCell.h"
#import "DetailViewController.h"
#import "PlaceModel.h"

@interface PlaceCollectionViewController ()

@property (strong, nonatomic) PlaceModel *model;
@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@end

@implementation PlaceCollectionViewController

static NSString * const reuseIdentifier = @"PlaceItemCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [PlaceModel sharedModel];

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqual:@"webView"]){
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        NSInteger index =  (long)selectedIndexPath.row;
        DetailViewController *inputVC = segue.destinationViewController;
        NSDictionary *temp = [self.model placeAtIndex:index];
        inputVC.place = temp;
    }
}


#pragma mark - Rotation

- (void) willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) [self.collectionView collectionViewLayout];
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if (orientation == UIInterfaceOrientationPortrait){
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
   
    else{
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"number of places %lu", (unsigned long)[self.model numberOfPlaces]);
    return [self.model numberOfPlaces];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlaceItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlaceItemCell" forIndexPath:indexPath];
    
    // Configure the cell
    NSDictionary *place = [self.model placeAtIndex:indexPath.row];
    
    [cell setPlace:place];
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
