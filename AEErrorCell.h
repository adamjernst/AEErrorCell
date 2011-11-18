//
//  AEErrorCell.h
//
//  Created by Adam Ernst on 11/1/11.
//  Copyright (c) 2011 cosmicsoft. BSD Licensed.
//

#import <UIKit/UIKit.h>

typedef enum {
    AEErrorCellStyleSimple,
    AEErrorCellStyleRetryButton,
} AEErrorCellStyle;

@interface AEErrorCell : UITableViewCell {
    UILabel *_descriptionLabel;
    UILabel *_recoverySuggestionLabel;
}

+ (AEErrorCell *)errorCellWithStyle:(AEErrorCellStyle)style error:(NSError *)error;

+ (CGFloat)rowHeightForStyle:(AEErrorCellStyle)style;

- (id)initWithErrorCellStyle:(AEErrorCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, retain) NSError *error;
@property (nonatomic, retain, readonly) UIButton *retryButton;

@end
