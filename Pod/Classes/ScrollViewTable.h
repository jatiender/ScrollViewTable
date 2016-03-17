//
//  ScrollViewTable.h
//  Pods
//
//  Created by Zakoopi on 17/03/16.
//
//

#import <UIKit/UIKit.h>
@protocol JKScrollDataSource;
@interface ScrollViewTable : UIScrollView{
    UIView*       contentView;
    NSRange       renderedRange;
    NSMutableSet* reusableCells;
}

@property (nonatomic, assign) id <JKScrollDataSource>dataSource;
@property (nonatomic, assign) CGSize itemSize;

- (id)dequeueReusableCell;

@end


@protocol JKScrollDataSource <NSObject>

- (NSInteger)numberOfItemsInRecyclingScrollView:(ScrollViewTable *)scrollView;
- (UIView *)recyclingScrollView:(ScrollViewTable *)scrollView
             cellForItemAtIndex:(NSInteger)index;

@end
