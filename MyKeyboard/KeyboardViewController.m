//
//  KeyboardViewController.m
//  MyKeyboard
//
//  Created by Tops on 7/30/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()
{
    UIKeyCommand *textKey;
}
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
     NSArray *arr =[[NSBundle mainBundle] loadNibNamed:@"KeyboardViewController" owner:self options:nil];
    self.view = (UIView *)arr[0];
    
    // Perform custom UI setup here
//    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    
//    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
//    [self.nextKeyboardButton sizeToFit];
//    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:self.nextKeyboardButton];
//    
//    NSLayoutConstraint *nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
//    NSLayoutConstraint *nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
//    [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint]];
    
    NSArray * allSubviews = [self.view subviews];
    for(UIView * view in allSubviews)
    {
        if([view isMemberOfClass:[UIButton class]])
        {
            UIButton * btn = (UIButton *)view ;
            btn.layer.cornerRadius=btn.frame.size.width/2.5;
            btn.layer.borderWidth=1.0;
            btn.layer.borderColor=[UIColor whiteColor].CGColor;
            btn.layer.masksToBounds=YES;
            btn.transform = CGAffineTransformMakeRotation(M_PI_2/-3);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}
-(IBAction)btnPress:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self.textDocumentProxy insertText:btn.titleLabel.text];
}
@end
