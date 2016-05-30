//
//  TwitterDataViewController.h
//  TrabalhoRedesSociais
//
//  Created by João Pedro Souza on 30/05/16.
//  Copyright © 2016 JoaoWilker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TwitterKit/TwitterKit.h>

@interface TwitterDataViewController : UIViewController

@property (strong, nonatomic) TWTRUser *twitterProfile;
@property (weak, nonatomic) IBOutlet UILabel *labelUserId;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelScreenName;
@property (weak, nonatomic) IBOutlet UILabel *labelToken;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwitter;

@end
