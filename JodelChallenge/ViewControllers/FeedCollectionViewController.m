//
//  FeedCollectionViewController.m
//  Coon
//
//  Created by Michal Ciurus on 12/05/17.
//  Copyright © 2017 CoonAndFriends. All rights reserved.
//

#import "FeedCollectionViewController.h"
#import "FlickrApi.h"
#import "CollectionCell.h"

@interface FeedCollectionViewController ()
@property (nonatomic) NSArray <NSURL *> *photos;
@end

@implementation FeedCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [FlickrApi fetchPhotosWithCompletion:^(NSArray *photos, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        self.photos = photos;
        NSLog(@"result %@ error %@", photos, error);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    [cell setupWithPhoto:self.photos[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _Bool isPortrait = [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait;
    
    if (isPortrait) {
    return CGSizeMake(CGRectGetWidth(collectionView.frame), (CGRectGetHeight(collectionView.frame)/2));
    } else {
            return CGSizeMake(CGRectGetWidth(collectionView.frame)/2, (CGRectGetHeight(collectionView.frame)/2));
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
 
    [self.collectionView reloadData];
}


@end
