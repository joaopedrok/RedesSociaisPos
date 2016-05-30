//
//  TwitterDataViewController.m
//  TrabalhoRedesSociais
//
//  Created by João Pedro Souza on 30/05/16.
//  Copyright © 2016 JoaoWilker. All rights reserved.
//

#import "TwitterDataViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TwitterDataViewController ()

@end

@implementation TwitterDataViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imageViewTwitter.layer.cornerRadius = 40;
    NSURL *url = [NSURL URLWithString:_twitterProfile.profileImageURL];
    [_imageViewTwitter sd_setImageWithURL:url placeholderImage:nil];
    
    _labelScreenName.text = [NSString stringWithFormat:@"Screen Name: %@" , _twitterProfile.screenName];
    _labelUserId.text = [NSString stringWithFormat:@"UserId: %@",_twitterProfile.userID];
    _labelName.text = [NSString stringWithFormat:@"Token: %@",_twitterProfile.name];
    NSString *token = [Twitter sharedInstance].sessionStore.session.authToken;
    _labelToken.text = [NSString stringWithFormat:@"Token: %@", token];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)actionComposeTweet:(id)sender {
    TWTRComposer *composer = [[TWTRComposer alloc] init];
    [composer showFromViewController:self completion:^(TWTRComposerResult result) {
        if (result == TWTRComposerResultCancelled) {
            NSLog(@"Tweet composition cancelled");
        }
        else {
            if (result == TWTRComposerResultDone) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Twitter" message:@"Tweet Postado com Sucesso!" preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                NSLog(@"Sending Tweet!");
            }
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
