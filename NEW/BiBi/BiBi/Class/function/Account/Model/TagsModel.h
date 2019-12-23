//
//  TagsModel.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/25.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagsModel : NSObject

/**
 标签标题
 */
@property (nonatomic,strong)NSString *title;
/**
 标签颜色
 */
@property (nonatomic,strong)NSString *color;

-(instancetype )initWithTagsDict:(NSDictionary *)dict;
+(instancetype)tagsModelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
