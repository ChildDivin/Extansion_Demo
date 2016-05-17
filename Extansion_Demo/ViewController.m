//
//  ViewController.m
//  Extansion_Demo
//
//  Created by Tops on 7/27/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userdefault = [[NSUserDefaults standardUserDefaults] initWithSuiteName:@"group.shringData"];
    NSLog(@"%@",[userdefault objectForKey:@"KeyName"]);
    lblLable.text=[userdefault objectForKey:@"KeyName"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillhide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeGesture];
    
    
    UISwipeGestureRecognizer *swipeGesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeGesture2.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeGesture2];
    
}
-(void)handleSwipeGesture:(UISwipeGestureRecognizer *) sender
{
    if(sender.direction == UISwipeGestureRecognizerDirectionUp)
    {
        UIView *keyboardSuperview = textField.inputAccessoryView.superview;
        [self.transitionCoordinator animateAlongsideTransitionInView:keyboardSuperview
                                                           animation:
         ^(id<UIViewControllerTransitionCoordinatorContext> context) {
             CGRect keyboardFrame = keyboardSuperview.frame;
             keyboardFrame.origin.x = self.view.bounds.size.width;
             keyboardSuperview.frame = keyboardFrame;
         }
                                                          completion:nil];
        NSLog(@"Up");
        
    }
    else if(sender.direction == UISwipeGestureRecognizerDirectionDown)
    {
        [self.view endEditing:YES];
        NSLog(@"down");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Mycell"];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Mycell"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
    
}
- (void)keyboardWillhide:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue] << 16;
    
    [UIView animateWithDuration:animationDuration delay:0.5 options:curve animations:^{
        
    } completion:nil];
}
- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = aNotification.userInfo;
    
    //
    // Get keyboard size.
    
    NSValue *beginFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardBeginFrame = [self.view convertRect:beginFrameValue.CGRectValue fromView:nil];
    
    NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame = [self.view convertRect:endFrameValue.CGRectValue fromView:nil];
    
    //
    // Get keyboard animation.
    
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    //
    // Create animation.
    
    CGRect tableViewFrame = tableView.frame;
    tableViewFrame.size.height = (keyboardBeginFrame.origin.y - tableViewFrame.origin.y);
    tableView.frame = tableViewFrame;
    
    void (^animations)() = ^() {
        CGRect tableViewFrame = tableView.frame;
        tableViewFrame.size.height = (keyboardEndFrame.origin.y - tableViewFrame.origin.y);
        tableView.frame = tableViewFrame;
    };
    // Begin animation.
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:animations
                     completion:nil];
}
-(IBAction)btndoneClick:(id)sender{
    [self.view endEditing:YES];
}
@end
