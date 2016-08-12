//
//  LPNewsCommentCellNode.m
//  LovePlayNews
//
//  Created by tany on 16/8/12.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "LPNewsCommentCellNode.h"

@interface LPNewsCommentCellNode ()

// Data
@property (nonatomic,strong) LPNewsCommonItem *item;

// UI
@property (nonatomic, strong) ASTextNode *nameNode;
@property (nonatomic, strong) ASTextNode *locationNode;
@property (nonatomic, strong) ASTextNode *contentNode;
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *voteNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;

@end

@implementation LPNewsCommentCellNode

- (instancetype)initWithCommentItem:(LPNewsCommonItem *)item
{
    if (self = [super init]) {
        _item = item;
        
        [self addImageNode];
        
        [self addNameNode];
        
        [self addLocationNode];
        
        [self addContentNode];
        
        [self addVoteNode];
        
        [self addUnderLineNode];
    }
    return self;
}
- (void)addImageNode
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc]init];
    imageNode.layerBacked = YES;
    imageNode.cornerRadius = 2;
    imageNode.defaultImage = [UIImage imageNamed:@"defult_pho"];
    imageNode.URL = [NSURL URLWithString:_item.user.avatar];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
}

- (void)addNameNode
{
    ASTextNode *nameNode = [[ASTextNode alloc]init];
    nameNode.layerBacked = YES;
    nameNode.maximumNumberOfLines = 1;
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15.0f] ,NSForegroundColorAttributeName: RGB_255(186, 177, 161)};
    nameNode.attributedText = [[NSAttributedString alloc]initWithString:_item.user.nickname?_item.user.nickname : @"火星网友" attributes:attrs];
    [self addSubnode:nameNode];
    _nameNode = nameNode;
}

- (void)addLocationNode
{
    ASTextNode *locationNode = [[ASTextNode alloc]init];
    locationNode.layerBacked = YES;
    locationNode.maximumNumberOfLines = 1;
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:11.0f] ,NSForegroundColorAttributeName: RGB_255(163, 163, 163)};
    locationNode.attributedText = [[NSAttributedString alloc]initWithString:_item.user.location?_item.user.location : @"火星" attributes:attrs];
    [self addSubnode:locationNode];
    _locationNode = locationNode;
}

- (void)addContentNode
{
    ASTextNode *contentNode = [[ASTextNode alloc]init];
    contentNode.layerBacked = YES;
    contentNode.maximumNumberOfLines = 0;
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15.0f] ,NSForegroundColorAttributeName: RGB_255(34, 34, 34)};
    contentNode.attributedText = [[NSAttributedString alloc]initWithString:_item.content attributes:attrs];
    [self addSubnode:contentNode];
    _contentNode = contentNode;
}

- (void)addVoteNode
{
    ASTextNode *voteNode = [[ASTextNode alloc]init];
    voteNode.layerBacked = YES;
    voteNode.maximumNumberOfLines = 1;
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12.0f] ,NSForegroundColorAttributeName: RGB_255(163, 163, 163)};
    voteNode.attributedText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld顶",_item.vote] attributes:attrs];
    [self addSubnode:voteNode];
    _voteNode = voteNode;
}

- (void)addUnderLineNode
{
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc]init];
    underLineNode.layerBacked = YES;
    underLineNode.backgroundColor = RGB_255(231, 231, 231);
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    ASStackLayoutSpec *verTopStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:2 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[_nameNode,_locationNode]];
    
    ASStackLayoutSpec *horTopStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:0 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[verTopStackLayout,_voteNode]];
    horTopStackLayout.flexGrow = YES;
    horTopStackLayout.spacingBefore = -3;
    
    _contentNode.flexShrink = YES;
    ASStackLayoutSpec *verLeftStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:12 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[horTopStackLayout,_contentNode]];
    verLeftStackLayout.flexGrow = YES;
    verLeftStackLayout.flexShrink  = YES;
    
    _imageNode.preferredFrameSize = CGSizeMake(34, 34);
    ASStackLayoutSpec *horStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:6 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[_imageNode,verLeftStackLayout]];
    
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(15, 12, 15, 12) child:horStackLayout];
    _underLineNode.preferredFrameSize = CGSizeMake(constrainedSize.max.width, 0.5);
    ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[insetLayout,_underLineNode]];
    return verStackLayout;
    
}

@end
