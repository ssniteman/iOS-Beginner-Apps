//
//  IWAFilterViewController.m
//  InstaWhat?
//
//  Created by Shane Sniteman on 8/25/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "IWAFilterViewController.h"
#import "IWACaptionViewController.h"


@interface IWAFilterViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation IWAFilterViewController
{
    UIImageView * imageView;
    
    UICollectionView * filterCollection;
    
    NSArray * filters;
    
    NSMutableDictionary * filterImages;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        filterImages = [@{} mutableCopy];
        
        filters = @[
                    @"CIColorCrossPolynomial",
                    @"CIColorCube",
                    @"CIColorCubeWithColorSpace",
                    @"CIColorInvert",
                    @"CIColorMonochrome",
                    @"CIColorPosterize",
                    @"CIFalseColor",
                    @"CIMaskToAlpha",
                    @"CIMaximumComponent",
                    @"CIMinimumComponent",
                    @"CIPhotoEffectChrome",
                    @"CIPhotoEffectFade",
                    @"CIPhotoEffectInstant",
                    @"CIPhotoEffectMono",
                    @"CIPhotoEffectNoir",
                    @"CIPhotoEffectProcess",
                    @"CIPhotoEffectTonal",
                    @"CIPhotoEffectTransfer",
                    @"CISepiaTone",
                    @"CIVignette",
                    @"CIVignetteEffect",
                    ];
        
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        
        [self.view addSubview:imageView];
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake(100, 100);
        
        filterCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 320, 320, [UIScreen mainScreen].bounds.size.height - 320) collectionViewLayout:layout];
        
        filterCollection.dataSource = self;
        filterCollection.delegate = self;
        
        // need to register anytime we use a for index path
        
        [filterCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [self.view addSubview:filterCollection];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)setOriginalImage:(UIImage *)originalImage
{
    _originalImage = originalImage;
    
    imageView.image = originalImage;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return filters.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString * filterName = filters[indexPath.item];
    
    UIImageView * filterView = [[UIImageView alloc] initWithFrame:cell.bounds];
    
    // cut out the lag in the filters
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        UIImage * filterImage = [self filterImageWithFilterName:filterName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            filterView.image = filterImage;
            
            if (!filterImage)
            {
                NSLog(@"Found a fricking nil image for %d for filtername %@",  (int)indexPath.item, filterName);
                
            }
            else
            {
                NSLog(@"Adding image %d", (int)indexPath.item);
            }
            [filterImages setObject:filterImage forKey:[NSString stringWithFormat:@"%d",(int)indexPath.item]];
            
        });
        
    });
    
    
    [cell addSubview:filterView];
    
    return cell;
}




-(UIImage *)filterImageWithFilterName:(NSString *)filterName
{
    //turn uiimage into ciimage
    
    CIImage * ciImage = [CIImage imageWithCGImage:self.originalImage.CGImage];
    
    //create cifilter with filterName
    
    CIFilter * filter = [CIFilter filterWithName:filterName];
    
    //add ciimage to the filter
    
    //we add THE IMAGE to the FILTER
    
    [filter setValue:ciImage forKeyPath:kCIInputImageKey];
    
    //get filtered image from filter
    
    CIImage * ciResult = [filter outputImage];
    
    //setup context to turn ciimage into cgimage
    
    CIContext * ciContext = [CIContext contextWithOptions:nil];
    
    //init uiimage with cgiamge
    
    return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self showFilteredImageWithCaption:filterImages[[NSString stringWithFormat:@"%d",(int)indexPath.item]]];
    
}


-(void)showFilteredImageWithCaption:(UIImage *)image
{
    IWACaptionViewController * captionView = [[IWACaptionViewController alloc] init];
    
    captionView.filteredImage = image;
    
    [self.navigationController pushViewController:captionView animated:YES];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
