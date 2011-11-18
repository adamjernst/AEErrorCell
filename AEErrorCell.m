//
//  AEErrorCell.m
//
//  Created by Adam Ernst on 11/1/11.
//  Copyright (c) 2011 cosmicsoft. BSD Licensed.
//

#import "AEErrorCell.h"

@implementation AEErrorCell

+ (AEErrorCell *)errorCellWithStyle:(AEErrorCellStyle)style error:(NSError *)error {
    AEErrorCell *cell = [[[AEErrorCell alloc] initWithErrorCellStyle:style reuseIdentifier:nil] autorelease];
    [cell setError:error];
    return cell;
}

+ (CGFloat)rowHeightForStyle:(AEErrorCellStyle)style {
    if (style == AEErrorCellStyleRetryButton) return 260.0f;
    return 176.0f;
}

@synthesize error=_error;
@synthesize retryButton=_retryButton;

- (id)initWithErrorCellStyle:(AEErrorCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 280, 36)];
        [_descriptionLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
        [_descriptionLabel setTextColor:[UIColor grayColor]];
        [_descriptionLabel setNumberOfLines:2];
        [_descriptionLabel setTextAlignment:UITextAlignmentCenter];
        [[self contentView] addSubview:_descriptionLabel];
        
        _recoverySuggestionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 280, 48)];
        [_recoverySuggestionLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_recoverySuggestionLabel setTextColor:[UIColor grayColor]];
        [_recoverySuggestionLabel setNumberOfLines:3];
        [_recoverySuggestionLabel setTextAlignment:UITextAlignmentCenter];
        [[self contentView] addSubview:_recoverySuggestionLabel];
        
        if (style == AEErrorCellStyleRetryButton) {
            _retryButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
            [_retryButton setFrame:CGRectMake(40, 176, 240, 44)];
            [_retryButton setTitle:NSLocalizedString(@"Retry", @"") forState:UIControlStateNormal];
            [[self contentView] addSubview:_retryButton];
        }
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)dealloc {
    [_error release];
    [_descriptionLabel release];
    [_recoverySuggestionLabel release];
    [_retryButton release];
    [super dealloc];
}

- (void)setError:(NSError *)error {
    [_error autorelease], _error = [error retain];
    
    if ([[error domain] isEqualToString:NSURLErrorDomain] && [error code] == NSURLErrorNotConnectedToInternet) {
        // Special case this error since it is common and the error text ends up
        // with a window ("offline" on its own line).
        [_descriptionLabel setText:NSLocalizedString(@"The Internet connection\nappears to be offline.", @"")];
        [_recoverySuggestionLabel setText:NSLocalizedString(@"Try connecting to a Wi-Fi network or moving to an area with better coverage.", @"")]; 
    } else {
        [_descriptionLabel setText:[error localizedDescription]];
        [_recoverySuggestionLabel setText:[error localizedRecoverySuggestion]];
    }
}

@end
