//
//  ViewController.m
//  deleteBackground
//
//  Created by mt010 on 2020/9/18.
//  Copyright © 2020 image. All rights reserved.
//

#import "ViewController.h"
#import "image/cubeMap.c"
#define KdeviceWidth UIScreen.mainScreen.bounds.size.width
#define Kdeviceheight UIScreen.mainScreen.bounds.size.height
#define statusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

@interface ViewController ()
@property (nonatomic,strong)UIImageView *personImage;
@property (nonatomic,strong)UIImageView *createImage;
@property (nonatomic,strong)UIColor *willChangeColor;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}
- (void)setUI{
    self.view.backgroundColor = UIColor.whiteColor;
    UIButton *choosePhoto = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    [choosePhoto setTitle:@"生成单色底照片" forState:UIControlStateNormal];
    choosePhoto.center = CGPointMake(KdeviceWidth / 2, Kdeviceheight / 2);
    [choosePhoto addTarget:self action:@selector(chooseImage:) forControlEvents:UIControlEventTouchUpInside];
    choosePhoto.backgroundColor = UIColor.redColor;
    
    UILabel *oldLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, statusBarHeight + 45, KdeviceWidth, 15)];
    oldLabel.text = @"原图";
    oldLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:oldLabel];
    self.personImage = [[UIImageView alloc]initWithFrame:CGRectMake(KdeviceWidth / 2 - 75, statusBarHeight + 80, 150, 180)];
    self.personImage.image = [UIImage imageNamed:@"3.jpeg"];
    [self.view addSubview:self.personImage];
    self.view.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:choosePhoto];
    
    self.createImage = [[UIImageView alloc] init];
    [self.createImage setFrame:CGRectMake(KdeviceWidth / 2 - 75, Kdeviceheight / 2 + 110, 150, 180)];
    self.createImage.image = [UIImage imageNamed:@"3.jpeg"];
    [self.view addSubview:self.createImage];
}
- (void)chooseImage:(UIButton *)btn{
    UIAlertController *chooseAlert = [UIAlertController alertControllerWithTitle:@"请选择" message:@"选择将要生成的底色照片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *red = [UIAlertAction actionWithTitle:@"红底" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.willChangeColor = [UIColor redColor];
        [self CreateImage];
    }];
    UIAlertAction *blue = [UIAlertAction actionWithTitle:@"蓝底" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.willChangeColor = [UIColor systemBlueColor];
        [self CreateImage];
    }];
    UIAlertAction *white = [UIAlertAction actionWithTitle:@"白底" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.willChangeColor = [UIColor colorWithWhite:20 alpha:1];
        [self CreateImage];
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [chooseAlert addAction:red];
    [chooseAlert addAction:blue];
    [chooseAlert addAction:white];
    [chooseAlert addAction:cancle];
    [self presentViewController:chooseAlert animated:YES completion:nil];
}
- (void)CreateImage{
    NSLog(@"点击按钮");
    if (!self.willChangeColor){
        UIAlertController *TishiAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"未选择要生成的底色" preferredStyle:UIAlertControllerStyleActionSheet];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [TishiAlert addAction:okAction];
        [self presentViewController:TishiAlert animated:YES completion:nil];
    }
    CGPoint leftTopPoint = CGPointMake(self.personImage.frame.origin.x + 10, self.personImage.frame.origin.y + 10);
    NSArray *colorRGBArray = [self colorAtPoint:leftTopPoint];
    UIImage *outImage = [self removeColorWithMaxR:[colorRGBArray[0] floatValue] +20.0 MinR:[colorRGBArray[0] floatValue] -20.0 MaxG:[colorRGBArray[1] floatValue] + 20.0 MixG:[colorRGBArray[1] floatValue] - 20.0 MaxB:[colorRGBArray[2] floatValue] + 20.0 MinB:[colorRGBArray[2] floatValue] - 20.0 image:self.personImage.image];
    self.createImage.image = outImage;
    self.createImage.backgroundColor = self.willChangeColor;
    
    UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Kdeviceheight / 2 + 75, KdeviceWidth, 15)];
    newLabel.text = @"生成图";
    newLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:newLabel];
}
- (UIImage *)removeColorWithMaxR:(float)MaxR MinR:(float)MinR MaxG:(float)MaxG MixG:(float)MinG MaxB:(float)MaxB MinB:(float)MinB image:(UIImage *)image{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++ , pCurPtr++) {
        uint8_t* ptr = (uint8_t*)pCurPtr;
        if (ptr[3] >= MinR && ptr[3] <= MaxR
            && ptr[2] >= MinG && ptr[2] <= MaxG
            && ptr[1] >= MinB && ptr[1] <= MaxB){
            ptr[0] = 0;
        }else{
            
        }
    }
    CGDataProviderRef dataProviderRef = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProviderRef, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProviderRef);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultImage;
}
//- (UIImage *)removeColorWithMinHueAngle:(float)minHueAngle maxHueAngle:(float)maxHueAngle image:(UIImage *)originalImage{
//    CIImage *image = [CIImage imageWithCGImage:originalImage.CGImage];
//
//    CIContext *context = [CIContext contextWithOptions:nil];// kCIContextUseSoftwareRenderer : CPURender
//    /** 注意
//     *  UIImage 通过CIimage初始化，得到的并不是一个通过类似CGImage的标准UIImage
//     *  所以如果不用context进行渲染处理，是没办法正常显示的
//     */
//    CIImage *renderBgImage = [self outputImageWithOriginalCIImage:image minHueAngle:minHueAngle maxHueAngle:maxHueAngle];
//    CGImageRef renderImg = [context createCGImage:renderBgImage fromRect:image.extent];
//    UIImage *renderImage = [UIImage imageWithCGImage:renderImg];
//    return renderImage;
//}
//- (CIImage *)outputImageWithOriginalCIImage:(CIImage *)originalImage minHueAngle:(float)minHueAngle maxHueAngle:(float)maxHueAngle{
//
//    struct CubeMap map = createCubeMap(minHueAngle, maxHueAngle);
//    const unsigned int size = 64;
//    // Create memory with the cube data
//    NSData *data = [NSData dataWithBytesNoCopy:map.data
//                                        length:map.length
//                                  freeWhenDone:YES];
//    CIFilter *colorCube = [CIFilter filterWithName:@"CIColorCube"];
//    [colorCube setValue:@(size) forKey:@"inputCubeDimension"];
//    // Set data for cube
//    [colorCube setValue:data forKey:@"inputCubeData"];
//
//    [colorCube setValue:originalImage forKey:kCIInputImageKey];
//    CIImage *result = [colorCube valueForKey:kCIOutputImageKey];
//
//    return result;
//}
//根据某个像素点 获取到该像素点的rgb
- (NSArray *)colorAtPoint:(CGPoint)point{
    if(!CGRectContainsPoint(CGRectMake(0, 0, KdeviceWidth, Kdeviceheight), point)){
        NSLog(@"超出屏幕范围");
        return nil;
    }
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = [self.personImage.image CGImage];
    NSUInteger width = self.personImage.frame.size.width;
    NSUInteger height = self.personImage.frame.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);

    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);

    // 把[0,255]的颜色值映射至[0,1]区间
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [[NSArray alloc] initWithObjects:[NSNumber numberWithFloat:(CGFloat)pixelData[0]],[NSNumber numberWithFloat:(CGFloat)pixelData[1]],[NSNumber numberWithFloat:(CGFloat)pixelData[2]],[NSNumber numberWithFloat:(CGFloat)pixelData[3]], nil];
}
@end
