//
//  GooglePlusDataViewController.m
//  TrabalhoRedesSociais
//
//  Created by João Pedro Souza on 30/05/16.
//  Copyright © 2016 JoaoWilker. All rights reserved.
//

#import "GooglePlusDataViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GooglePlusDataViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *labelUserId;
@property (weak, nonatomic) IBOutlet UILabel *labelToken;
@property (weak, nonatomic) IBOutlet UILabel *labelFullName;
@property (weak, nonatomic) IBOutlet UILabel *labelGivenName;
@property (weak, nonatomic) IBOutlet UILabel *labelFamilyName;
@property (weak, nonatomic) IBOutlet UILabel *labelEmail;

@end

@implementation GooglePlusDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imageView.layer.cornerRadius = 40;
    
    NSURL *url = [_googleProfile.profile imageURLWithDimension:80];
    
    [_imageView sd_setImageWithURL:url placeholderImage:nil];
    _labelUserId.text = [NSString stringWithFormat:@"UserId: %@", _googleProfile.userID];
    _labelToken.text = [NSString stringWithFormat:@"Token: %@", _googleProfile.authentication.idToken];
    _labelFullName.text = [NSString stringWithFormat:@"Name: %@", _googleProfile.profile.name];
    _labelGivenName.text = [NSString stringWithFormat:@"Given Name: %@", _googleProfile.profile.givenName];
    _labelFamilyName.text = [NSString stringWithFormat:@"Family Name: %@", _googleProfile.profile.familyName];
    _labelEmail.text = [NSString stringWithFormat:@"Email: %@", _googleProfile.profile.email];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
