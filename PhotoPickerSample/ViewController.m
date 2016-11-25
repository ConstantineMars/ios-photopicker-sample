//
//  ViewController.m
//  PhotoPickerSample
//
//  Created by Constantine Mars on 11/25/16.
//  Copyright © 2016 Constantine Mars. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) PHImageRequestOptions* requestOptions;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    QBImagePickerController *imagePickerController = [QBImagePickerController new]; imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection=YES;
    imagePickerController.modalPresentationStyle= UIModalPresentationCurrentContext;
    [self presentViewController:imagePickerController animated:YES completion:NULL];
}

-(void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    for(PHAsset *asset in assets) {
        //display only first image for the sake of sample
        [self displayAsset:asset];
        break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)displayAsset:(PHAsset*) asset {
    PHImageManager *manager = [PHImageManager defaultManager];
//    __block UIImageView* imageView = _imageView;
    
    self.requestOptions = [[PHImageRequestOptions alloc] init];
    self.requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
    self.requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    // this one is key
    self.requestOptions.synchronous = true;
    
    [manager requestImageForAsset:asset
                       targetSize:PHImageManagerMaximumSize
                      contentMode:PHImageContentModeDefault
                          options:self.requestOptions
                    resultHandler:^void(UIImage *image, NSDictionary *info) {
                        [_imageView setImage:image];
                    }];
}


@end
