//
//  ViewController.h
//  TrabalhoRedesSociais
//
//  Created by João Pedro Souza on 30/05/16.
//  Copyright © 2016 JoaoWilker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import <TwitterKit/TwitterKit.h>

@interface ViewController : UIViewController <GIDSignInDelegate, GIDSignInUIDelegate >

@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;

@property (weak, nonatomic) IBOutlet TWTRLogInButton *twitterLoginButton;

@property (weak, nonatomic) IBOutlet UIButton *signOutTwitterButton;

@end

