//
//  RootController.h
//  Fall2014IOSApp
//
//  Created by Barry on 10/12/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootController : UIViewController<UITableViewDataSource, UITableViewDelegate> // (1)

- (id)initWithViewControllers:(NSArray *)viewControllers andMenuTitles:(NSArray *)titles; // (2)

@end
