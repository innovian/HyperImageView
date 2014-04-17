HyperImageView
===========
###### Fastest Image Drawing Control in iOS
by Hamidreza Vakilian

------

![Screenshot](http://www.infracyber.com/private/github/HyperImageView/screenshot.jpg)

###Summary
**HyperImageView** is an easy-to-use iOS user interface control and an alternative for UIImageView where the developer wants to display images with high performance. It converts an image into raw pixel data and saves it on the disk. Afterward, whenever the image needs to be rendered, HyperImageView reads the cached file from the disk and directly loads it into the video memory. Therefore, HyperImageView can render images up to 30 times faster than UIImageView while uses 10 times less RAM (at the expense of a reasonable disk space). Also the rendering task takes place in a background thread and it never blocks user interaction even for very large images.

Here I introduce this control:

1- HyperImageView is *thread safe* which means it can render the image in a background thread hence it does not block UI interaction, while UIImageView renders the image on the main thread, so it blocks the user interaction while it's rendering, and even gets worse if the image is a large one (e.g. > 500x500).

2- JPEG is the most popular format for saving images since it has high compression ratio thus developers choose it to get a smaller bundle size for their app. Suppose that we want to display a 1MB JPEG photo with UIImageView. First it loads it into RAM; Then decompresses it which is a heavy CPU bound process and stores the raw pixel bytes into RAM; Then it copies the raw pixel bytes into video memory. Sometimes the live bytes of this process gets over 50mb because it applies various RGBA format conversions on the raw pixel bytes. So UIImageView poorly manages memory. In comparison, HyperImageView decompresses the photo once and saves the raw bytes on the disk. Therefore later displays of the photo using HyperImageView would be extremely fast, since it read the bytes from disk and DIRECTLY loads it into the video memory.

3- Suppose we want to develop an app to introduce Elise restaurant. We are interested to put an image slider there and display various photos of the Elise restaurant and their foods. So we will have  e.g. 10 images that slide sequentially in 5 seconds intervals. UIImageView will render the photos on each slide: heavy CPU load, huge RAM usage and blocking the main thread, high latency in displaying images. If we use HyperImageView instead: you cache images only once, low RAM usage and no main thread blocking, super fast and light image display.

###Finally, use cases:
HyperImageView provides a huge performance improvement in displaying big enough images (e.g. >100x100) and in cases that an image should be displayed multiple times in one run-cycle of the app or constantly being displayed in the app in several runs. (The good example is Elise restaurant intro app). HyperImageView caches an image into a hyperIMG file for a specific width and height. You may resize the image with animation and you will be fine. Also note that sometimes resizing the HyperImageView control may cause regeneration of the hyperIMG file for a new size.

###Embedding HyperImageView in your project:

Just add HyperImageView.h and libHyperImageView.a files to your Xcode project. (add to your target)

###Simple usage example:

		HyperImageView*	hyper = [[HyperImageView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
		[[NSFileManager defaultManager] createDirectoryAtPath:[@"~/Documents/HyperImageViewCache/" stringByExpandingTildeInPath] withIntermediateDirectories:NO attributes:nil error:nil];
		[hyper setHyperImageViewDefaultDIR:[@"~/Documents/hyperImageViewCache/" stringByExpandingTildeInPath]];
		[hyper loadImageWithPath:[[NSBundle mainBundle] pathForResource:@"001" ofType:@"jpg"] priority:hyperIMGCachePriority_Default];
		[self.view addSubview:hyper];


**IMPORTANT NOTES**
	
- As said earlier, HyperImageView caches the images on to the disk. You have to be careful about your application bundle size.
- To calculate the hyperIMG file size:  height x width x 4	(for non-retina devices)
											height x width x 16 (for retina devices)
  - If you profile HyperImageView with Insturments for memory allocations; You will see that Insruments  shows some memory allocations for HyperImageView, though HyperImageView never allocate memory. It directly accesses video memory and copies the pixel data from hyperIMG files there but Instruments perceive it as memory allocation; HyperImageView does not allocate any additional memory for rendering the image other than the UIView's itself.

	- HyperImageView does not use any private API calls.
	- HyperImageView is compatible with retina and non-retina devices.
	- HyperImageView is compatible and tested with UIView block animations.
	- HyperImageView is tested with iOS 7.


*Please don't hesitate to mail me your feedbacks and suggestions or any bug report.*


Hamidreza,


License
=========

*HyperImageView 1.0 - Lite Version
Copyright (C) Hamidreza Vakilian - All Rights Reserved*

*This work is licensed under a binpress commercial License. To view a copy of this license, visit [http://www.binpress.com/license/view/l/ef565e5081020812550502852790e079
](http://www.binpress.com/license/view/l/ef565e5081020812550502852790e079)*

**License Summary**

- License does not expire.
- Can be distributed in 99 projects
- Can be distributed and / or packaged as a code or binary product (sublicensed)
- Non-commercial use only
- Cannot modify source-code for any purpose (cannot create derivative works)
- Attribution to software creator must be made as specified:
	- Please include a link to hyperimageview.com in your distributions.

*Permissions beyond the scope of this license may be available at [http://www.hyperimageview.com/contact.php](http://www.hyperimageview.com/contact.php) by sending your proposal.*

