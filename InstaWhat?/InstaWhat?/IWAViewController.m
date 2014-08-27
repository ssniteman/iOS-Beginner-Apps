//
//  IWAViewController.m
//  InstaWhat?
//
//  Created by Shane Sniteman on 8/21/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "IWAViewController.h"
#import "IWAFilterViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface IWAViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation IWAViewController
{
    UIImagePickerController * imagePicker;
    NSMutableArray * photos;
    ALAssetsLibrary * library;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    photos = [@[] mutableCopy];
    
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.view.frame = self.view.frame;
    imagePicker.showsCameraControls = NO;
    imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    imagePicker.view.frame = CGRectMake(0, 0, 320, 320);
    imagePicker.delegate = self;
    

    
    UIButton * takePictureButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 370, 100, 100)];
    takePictureButton.backgroundColor = [UIColor blackColor];
    [takePictureButton addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:takePictureButton];
    

    
//    dispatch_after(dispatsch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [imagePicker takePicture];
    
//    });
    
    
    // BRINGS UP THIS APP WANTS TO ACCESS YOUR PHOTOS
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(100, 100);
    
    UICollectionView * photoCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 320, 320, [UIScreen mainScreen].bounds.size.height - 320) collectionViewLayout:layout];
    
    photoCollection.delegate = self;
    photoCollection.dataSource = self;
    
    [photoCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:photoCollection];
    
    library = [[ALAssetsLibrary alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            
            //NSLog(@"type %@",[result valueForProperty:ALAssetPropertyType]);
            
            // adding our photo library to an array
            
            if(result) [photos addObject:result];
            
            // putting data onto screen
            
            [photoCollection reloadData];
            
            
            [self.view addSubview:imagePicker.view];
            [self addChildViewController:imagePicker];
           
        }];
        
    } failureBlock:^(NSError *error) {
        
    }];
    

}


-(void)takePicture
{
    [imagePicker takePicture];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return photos.count;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    // info is a dictionary - need to get the key/value pair
    
//    imageView.image = info[UIImagePickerControllerOriginalImage];
//    
//    [self.view addSubview:imageView];
    
    // push view controller
    
    [self showFilterWithImage:info[UIImagePickerControllerOriginalImage]];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ALAsset * photo = photos[indexPath.item];
    
    UIImageView * thumbnailView = [[UIImageView alloc] initWithFrame:cell.bounds];
    
    thumbnailView.image = [UIImage imageWithCGImage:photo.thumbnail];
    
    [cell.contentView addSubview:thumbnailView];
    
    return cell;
}

// picking the image

// reporting malestation -- collection view is touched -- photo collection child of view, needed to give delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UIImageView * bigView = [[UIImageView alloc] initWithFrame:imagePicker.view.frame];

    ALAsset * photo = photos[indexPath.item];
    
    ALAssetRepresentation * representation = photo.defaultRepresentation;
//    
//    bigView.image = [UIImage imageWithCGImage:representation.fullResolutionImage];
//    [self.view addSubview:bigView];
    
    // push view controller
    
    [self showFilterWithImage:[UIImage imageWithCGImage:representation.fullResolutionImage]];


}


- (void)showFilterWithImage:(UIImage *)image
{
    IWAFilterViewController * filterVC = [[IWAFilterViewController alloc] init];
    
    filterVC.originalImage = image;
    
    [self.navigationController pushViewController:filterVC animated:YES];
}



@end
