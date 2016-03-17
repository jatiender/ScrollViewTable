//
//  ScrollViewTable.m
//  Pods
//
//  Created by Zakoopi on 17/03/16.
//
//

#import "ScrollViewTable.h"
#import <objc/runtime.h>
static char RecyclingScrollViewIndexKey;
@implementation ScrollViewTable
@synthesize dataSource, itemSize;

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
        contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        
        reusableCells = [NSMutableSet set];
    }
    return self;
}

- (void)setItemSize:(CGSize)newSize {
    
    if (!CGSizeEqualToSize(itemSize, newSize)) {
        
        itemSize = newSize;
        NSInteger totalItems = [dataSource numberOfItemsInRecyclingScrollView:self];
        CGRect contentFrame = [contentView frame];
        contentFrame.size.height =  totalItems * itemSize.height;
        contentFrame.size.width = self.frame.size.width;
        [contentView setFrame:contentFrame];
        [self setContentSize:contentFrame.size];
    }
}

- (NSRange)computeVisibleRange {
    
    CGRect bounds = [self bounds];
    NSInteger location = MAX(0, (int)(bounds.origin.x / itemSize.width));
    NSInteger length = MAX(0, ceil((bounds.size.width + fmodf(bounds.origin.x, itemSize.width)) / itemSize.width));
    NSInteger totalItems = [dataSource numberOfItemsInRecyclingScrollView:self];
    if ((location + length) > totalItems) {
        length = MAX(0, totalItems - location);
    }
    
    return NSMakeRange(0, itemSize.width+totalItems);
}

- (id)dequeueReusableCell {
    
    UIView *cell = [reusableCells anyObject];
    if (cell) {
        [reusableCells removeObject:cell];
    }
    return cell;
}

- (void)recycleCellAtIndex:(NSInteger)index {
    
    for (UIView *cell in [contentView subviews]) {
        NSNumber *num = objc_getAssociatedObject(cell, &RecyclingScrollViewIndexKey);
        if (index == [num integerValue]) {
            [reusableCells addObject:cell];
            [cell removeFromSuperview];
        }
    }
}

- (void)renderCellAtIndex:(NSInteger)index {
    
    UIView *cell = [dataSource recyclingScrollView:self cellForItemAtIndex:index];
    NSAssert(cell != nil, @"dataSource returned nil cell for index %zd", index);
    
    objc_setAssociatedObject(cell, &RecyclingScrollViewIndexKey, @(index), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    CGRect rect = CGRectZero;
    rect.size = itemSize;
    rect.origin = CGPointMake(0,index * itemSize.height);
    [cell setFrame:rect];
    
    [contentView addSubview:cell];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // Figure out what range of cells should be visible right now
    // and check it against our current rendered range.
    NSRange visibleRange = [self computeVisibleRange];
    
    if (!NSEqualRanges(visibleRange, renderedRange)) {
        
        // The visible range differs from what we've currently rendered.
        // First, recycle any cells that are not in the visible range.
        for (NSInteger i = renderedRange.location; i < NSMaxRange(renderedRange); i++) {
            if (!NSLocationInRange(i, visibleRange)) {
                [self recycleCellAtIndex:i];
            }
        }
        
        // Next, render any cells that are in the visible range that
        // we haven't rendered already.
        for (NSInteger i = visibleRange.location; i < NSMaxRange(visibleRange); i++) {
            if (!NSLocationInRange(i, renderedRange)) {
                [self renderCellAtIndex:i];
            }
        }
        
        // And we're done. Update our current rendered range.
        renderedRange = visibleRange;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
