//
// Created by Dmitry on 14/03/2017.
// Copyright (c) 2017 company. All rights reserved.
//

#import "FlickrApi.h"
#import <UIKit/UIKit.h>
#import <FlickrKit/FlickrKit.h>

@implementation FlickrApi

+ (void)fetchPhotosWithCompletion:(void (^)(NSArray *, NSUInteger, NSUInteger, NSUInteger, NSError *))completion {
    FlickrKit *fk = [FlickrKit sharedFlickrKit];

    [fk initializeWithAPIKey:@"92111faaf0ac50706da05a1df2e85d82" sharedSecret:@"89ded1035d7ceb3a"];

    FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
    interesting.per_page = @"10";
    interesting.page = @"1";
    
    [fk call:interesting completion:^(NSDictionary *response, NSError *error) {
        NSMutableArray *photoURLs = nil;
        
        NSUInteger page = 0, perPage = 0, total = 0;
        if (response) {
            photoURLs = [NSMutableArray array];
            page    = [[response valueForKeyPath:@"photos.page"] intValue];
            perPage = [[response valueForKeyPath:@"photos.perpage"] intValue];
            total   = [[response valueForKeyPath:@"photos.total"] intValue];
            for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
                NSURL *url = [fk photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
                [photoURLs addObject:url];
            }
        }
        if (completion) {
            completion(photoURLs, page, perPage, total, error);
        }
    }];
}
@end
