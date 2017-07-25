//
//  ViewController.h
//  PageViewController
//
//  Created by Tom Fewster on 11/01/2012.
//

#import <UIKit/UIKit.h>

@interface PagerViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)nextbutton:(id)sender;
- (IBAction)previousbutton:(id)sender;

@property (strong, nonatomic) IBOutlet UIPageControl *changepages;

- (IBAction)changepages:(id)sender;

- (void)previousPage;
- (void)nextPage;


@end
