//
//  ShareViewController.m
//  SharingExtantion
//
//  Created by Tops on 7/29/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import "ShareViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ShareViewController ()
{
    UIImage *imgTemp;
    NSString * urlString;
    IBOutlet UIImageView *imageDisplay;
}
@end

@implementation ShareViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    NSExtensionItem *item = self.extensionContext.inputItems.firstObject;
    NSItemProvider *itemProvider = item.attachments.firstObject;
    if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeURL]) {
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeURL options:nil completionHandler:^(NSURL *url, NSError *error) {
            urlString = url.absoluteString;
        }];
    }
    else if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]){
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil
                              completionHandler:^(UIImage * image, NSError *error) {
                                  if (!error) {
                                      imgTemp=image;
                                  }
        }];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    imageDisplay.image=imgTemp;
}
/*
 //- (void)beginRequestWithExtensionContext:(NSExtensionContext *)context
 //{
 //
 //}
 - (BOOL)isContentValid {
 
 NSExtensionItem *imageItem = [self.extensionContext.inputItems firstObject];
 if(!imageItem){
 return NO;
 }
 NSItemProvider *imageItemProvider = [[imageItem attachments] firstObject];
 if(!imageItemProvider){
 return NO;
 }
 if([imageItemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]){
 [imageItemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(UIImage *image, NSError *error) {
 if(image){
 NSLog(@"image %@", image);
 
 }
 }];
 }
 else  if ([imageItemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeURL]) {
 [imageItemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeURL options:nil completionHandler:^(NSURL *url, NSError *error) {
 urlString = url.absoluteString;
 }];
 }
 // this line should not be here. Cos it's called before the block finishes.
 // and this is why the console log or any other task won't work inside the block
 [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
 return YES;
 }
 
 
 //- (UIView *)loadPreviewView
 //{
 //    return self.view;
 //}
 - (void)didSelectPost {
 
 NSUserDefaults *userdefault = [[NSUserDefaults standardUserDefaults] initWithSuiteName:@"group.shringData"];
 [userdefault setObject:@"iOS and MAC Development " forKey:@"KeyName"];
 [userdefault setInteger:2 forKey:@"KeyValues"];
 [userdefault synchronize];
 
 [UIView animateWithDuration:0.20 animations:^{
 self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
 } completion:^(BOOL finished) {
 [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
 }];
 
 }
 
 - (NSArray *)configurationItems {
 return @[];
 }
 
 */
#pragma mark -Custom Button Action

- (IBAction)btnCancelClick:(id)sender {
    [UIView animateWithDuration:0.20 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
    }];
}
- (IBAction)btnDoneClick:(id)sender {
    

}
@end
