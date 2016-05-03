//
//  PlaceItemCollectionViewCell.m
//  Lab 6
//
//  Created by LJ on 4/25/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "PlaceItemCollectionViewCell.h"


@interface PlaceItemCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@end

@implementation PlaceItemCollectionViewCell

- (void) setPlace:(NSDictionary *)place{
    self.imageView.image = [UIImage imageNamed:[place valueForKey:@"image"]];
    
    self.placeLabel.text = place[@"name"];
}

@end
