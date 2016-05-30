//
//  ViewController.m
//  TrabalhoRedesSociais
//
//  Created by João Pedro Souza on 30/05/16.
//  Copyright © 2016 JoaoWilker. All rights reserved.
//

#import "ViewController.h"
#import "GooglePlusDataViewController.h"
#import "TwitterDataViewController.h"
#import "MBProgressHUD.h"

@interface ViewController ()

#pragma mark - Members

@property (strong, nonatomic) GIDGoogleUser *googleProfile;
@property (strong, nonatomic) TWTRUser *twitterProfile;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    [[GIDSignIn sharedInstance] signInSilently];
    

    
    _twitterLoginButton.logInCompletion = ^(TWTRSession* session, NSError* error) {
        if (session) {
            NSLog(@"signed in as %@", [session userName]);
            
            NSString *userID = [Twitter sharedInstance].sessionStore.session.userID;
            TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:userID];
            [client loadUserWithID:userID completion:^(TWTRUser *user, NSError *error) {
                _twitterProfile = user;
                _twitterLoginButton.hidden = YES;
                _signOutTwitterButton.hidden = NO;
            }];
            
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"willDispatch");
}


- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _signInButton.hidden = YES;
    _signOutButton.hidden = NO;
    _googleProfile = user;
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"disconnected");
    
    _signInButton.hidden = NO;
    _signOutButton.hidden = YES;
    _googleProfile = nil;
}

- (IBAction)actionSignOutGoogle:(id)sender {
    [[GIDSignIn sharedInstance] disconnect];
}

- (IBAction)actionSignOutTwitter:(id)sender {
    [[[Twitter sharedInstance] sessionStore] logOutUserID:_twitterProfile.userID];
    _twitterLoginButton.hidden = NO;
    _signOutTwitterButton.hidden = YES;
    _twitterProfile = nil;
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"segueGooglePlus"]) {
        if (_googleProfile == nil) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Google Profile" message:@"Você ainda não tem um profile google para ver os dados. Tente logar no Google" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            return NO;
        }
    } else {
        if ([identifier isEqualToString:@"segueTwitter"]) {
            if (_twitterProfile == nil) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Twitter User" message:@"Você ainda não tem um usuário Twitter para ver os dados. Tente logar no Twitter" preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                return NO;
            } 
        }
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueGooglePlus"]) {
        GooglePlusDataViewController *googlePlusVC = [segue destinationViewController];
        googlePlusVC.googleProfile = _googleProfile;
    } else {
        if ([segue.identifier isEqualToString:@"segueTwitter"]) {
            TwitterDataViewController *twitterDataVC = [segue destinationViewController];
            twitterDataVC.twitterProfile = _twitterProfile;
        }
    }
}

@end
