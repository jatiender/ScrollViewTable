<<<<<<< HEAD
# ScrollViewTable

[![CI Status](http://img.shields.io/travis/JKTableView/ScrollViewTable.svg?style=flat)](https://travis-ci.org/JKTableView/ScrollViewTable)
[![Version](https://img.shields.io/cocoapods/v/ScrollViewTable.svg?style=flat)](http://cocoapods.org/pods/ScrollViewTable)
[![License](https://img.shields.io/cocoapods/l/ScrollViewTable.svg?style=flat)](http://cocoapods.org/pods/ScrollViewTable)
[![Platform](https://img.shields.io/cocoapods/p/ScrollViewTable.svg?style=flat)](http://cocoapods.org/pods/ScrollViewTable)



## Installation

ScrollViewTable is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ScrollViewTable"
```
## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## How To Using
#### import both data sources for used this control 
- (NSInteger)numberOfItemsInRecyclingScrollView:(JKScrollCell *)scrollView {

return 200;
}


- (UIView *)recyclingScrollView:(JKScrollCell *)scrollView
cellForItemAtIndex:(NSInteger)index {

UIImageView *cell = [scrollView dequeueReusableCell];
if (!cell) {
cell = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 235)];
}
return cell;
}


## Author

JKTableView, jitu94186@gmail.com

## License

ScrollViewTable is available under the MIT license. See the LICENSE file for more info.
=======
# ScrollViewTable
>>>>>>> ScrollViewTable is Just like UitableView. You can used instead of uitableview This is Used simply like UitableView. This is manulaly deque every cell like uitable view.just import pod or library in your project and write Delegate or data source method and design your custom cell So its essay to used ....Happy coding...enjoy to use this
