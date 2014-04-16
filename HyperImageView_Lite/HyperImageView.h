//
//  HyperImageView.h
//  HyperImageView 1.0 - Lite Version
//
//  Created by Hamidreza Vakilian on 1/1/2014
//  Copyright (c) 2014 Hamidreza Vakilian. All rights reserved.
//  Website: http://www.infracyber.com/
//  Email:   hyperimageview@gmail.com
//
//
//	This work is licensed under a binpress commercial License. To view a copy of this license, visit http://www.binpress.com/license/view/l/ef565e5081020812550502852790e079
//
//
//
//***************	HyperImageView - Fastest Image Drawing Control in iOS   *****************************
//
//
//	HyperImageView is an alternative for UIImageView where the developer tends to display images (preferably large ones) repeatedly in his application. HyperImageView converts an image into raw pixel data and saves it on the disk with hyperIMG extension (I name this hyperIMG file, cached image file). Then whenever the developer wants to load the corresponding image, HyperImageView reads the hyperIMG file from disk and DIRECTLY loads it into the video memory. That's why HyperImageView has some significant superiorities over UIImageView in many cases. Here I introduce this control:
//
//	1- HyperImageView is thread safe which means it can render the image in a background thread hence it does not block UI interaction, while UIImageView renders the image on the main thread, so it blocks the user interaction while it's rendering, and even gets worse if the image is a large one (e.g. > 500x500).
//
//	2- JPEG is the most popular format for saving images since it has high compression ratio thus developers choose it to get a smaller bundle size for their app. Suppose that we want to display a 1MB JPEG photo with UIImageView. First it loads it into RAM; Then decompresses it which is a heavy CPU bound process and stores the raw pixel bytes into RAM; Then it copies the raw pixel bytes into video memory. Sometimes the live bytes of this process gets over 50mb because it applies various RGBA format conversions on the raw pixel bytes. So UIImageView poorly manages memory. In comparison, HyperImageView decompresses the photo once and saves the raw bytes on the disk. Therefore later displays of the photo using HyperImageView would be extremely fast, since it read the bytes from disk and DIRECTLY loads it into the video memory.
//
//	3- Suppose we want to develop an app to introduce Elise restaurant. We are interested to put an image slider there and display various photos of the Elise restaurant and their foods. So we will have  e.g. 10 images that slide sequentially in 5 seconds intervals. UIImageView will render the photos on each slide: heavy CPU load, huge RAM usage and blocking the main thread, high latency in displaying images. If we use HyperImageView instead: you cache images only once, low RAM usage and no main thread blocking, super fast and light image display.
//
//	Finally, use cases:
//	HyperImageView provides a huge performance improvement in displaying big enough images (e.g. >100x100) and in cases that an image should be displayed multiple times in one run-cycle of the app or constantly being displayed in the app in several runs. (The good example is Elise restaurant intro app). HyperImageView caches an image into a hyperIMG file for a specific width and height. You may resize the image with animation and you will be fine. Also note that sometimes resizing the HyperImageView control may cause regeneration of the hyperIMG file for a new size.
//
//	*** Embedding HyperImageView in your project:
//
//		Just add HyperImageView.h and libHyperImageView.a files to your Xcode project. (add to your target)
//
//	*** Simple usage example:
//
//		HyperImageView*	hyper = [[HyperImageView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
//		[[NSFileManager defaultManager] createDirectoryAtPath:[@"~/Documents/HyperImageViewCache/" stringByExpandingTildeInPath] withIntermediateDirectories:NO attributes:nil error:nil];
//		[hyper setHyperImageViewDefaultDIR:[@"~/Documents/hyperImageViewCache/" stringByExpandingTildeInPath]];
//		[hyper loadImageWithPath:[[NSBundle mainBundle] pathForResource:@"001" ofType:@"jpg"] priority:hyperIMGCachePriority_Default];
//		[self.view addSubview:hyper];
//
// ******** IMPORTANT *********
//	- As said earlier, HyperImageView caches the images on to the disk. You have to be careful about your application bundle size.
//  - To calculate the hyperIMG file size:  height x width x 4	(for non-retina devices)
//											height x width x 16 (for retina devices)
//  - If you profile HyperImageView with Insturments for memory allocations; You will see that Insruments  shows some memory allocations for HyperImageView, though HyperImageView never allocate memory. It directly accesses video memory and copies the pixel data from hyperIMG files there but Instruments perceive it as memory allocation; HyperImageView does not allocate any additional memory for rendering the image other than the UIView's itself.
//	- HyperImageView does not use any private API calls.
//	- HyperImageView is compatible with retina and non-retina devices.
//	- HyperImageView is compatible and tested with UIView block animations.
//	- HyperImageView is tested with iOS 7.
//
//
//	Please don't hesitate to mail me your feedbacks and suggestions or any bug report.
//
//
//	Regards,
//	Hamidreza Vakilian (xerxes235@yahoo.com)
//***********************************************************************************************************


#import <UIKit/UIKit.h>

enum _hyperIMGCachePriority : NSInteger {
	hyperIMGCachePriority_High,
	hyperIMGCachePriority_Default,
	hyperIMGCachePriority_Low,
	hyperIMGCachePriority_Background
};
typedef enum _hyperIMGCachePriority hyperIMGCachePriority;

@interface HyperImageView : UIView <NSStreamDelegate>


//*********************************************************************
///Use this function to initialize an instance of HyperImageView with desired size and instantly load an image. Calling this function is equivalent to calling initWithFrame: and loadImageWithPath:: sequentially.
//	(CGRect)frame:				frame to render the image
//	(NSString*)pathToFile:		full path to an image with UIImage-readable format (e.g. jpg, png, etc.).
//	(hyperIMGCachePriority)prio:defines the priority level of the background thread for rendering
-(id) initWithFrame:(CGRect)frame andImageFile:(NSString*)pathToFile priority:(hyperIMGCachePriority)prio;
//----------------------------------------------------------------------
///Loads an Image into the HyperImageView control. First checks the default cache DIR, generates a hyperIMG file if one doesn't exist otherwise it reads the hyperIMG file directly into the video buffer. Must be called from the main thread, nevertheless, HyperImageView will render the image in a background thread.
//	(NSString*)pathToFile:		full path to an image with UIImage-readable format (e.g. jpg, png, etc.).
//	(hyperIMGCachePriority)prio:defines the priority level of the background thread for rendering
-(void)	loadImageWithPath: (NSString*)pathToFile priority:(hyperIMGCachePriority)prio;
//----------------------------------------------------------------------
///Sets location for saving hyperIMG files. Default directory for saving hyperIMG files is the directory which you are loding the image from. (if the source image is in app's bundle, you must set default DIR to a writable location (e.g. documents), since app's bundle is read-only)
// (NSString*)path:				full path to a writable directory to save hyperIMG files
//	NOTE:						You are responsible for creating the directory. This method does not create the directory if it doesn't exist.
-(void)	setHyperImageViewDefaultDIR:(NSString*)path;
//----------------------------------------------------------------------
///Caches images in a background thread with chosen priority and size. Announces any progress through progressInvo invocation. When complete it invokes finishInvo invocation. Set verboseMode to true to log details.
//	(NSArray*)arrayOfPaths:		an array of NSStrings holding full path of images.
//	(CGSize)size:				size to render images.
//	(NSInvocation*)finishInvo:	an invocation of a funcation with no arguments
//	(NSInvocation*)progressInvo:an invocation of a function with an argument of type NSNumber*
//	(NSString*)cacheDIR:		path to a directory to store .hyperIMG files
//	(hyperIMGCachePriority)prio:defines the priority level of the background thread for rendering
//	(BOOL)verboseMode:			set to true to log events.
+(void) cacheImagesWithPaths:(NSArray*)arrayOfPaths forSize:(CGSize)size finishCallBack:(NSInvocation*)finishInvo progressInvocation:(NSInvocation*)progressInvo cacheDIR:(NSString*)cacheDIR priority:(hyperIMGCachePriority)prio verboseMode:(BOOL)verboseMode;
//----------------------------------------------------------------------

///Holds the full path to the original image file which is being displayed.
@property (retain, readonly) NSString* originalFilePath;
///Set to true to log events.
@property (assign, nonatomic) BOOL verboseMode;
///Holds the full path to the cached hyperIMG file of the image being displayed.
@property (retain, readonly) NSString* hyperIMGFilePath;

@end
