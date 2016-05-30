//
//  GooglePlusDataViewController.h
//  TrabalhoRedesSociais
//
//  Created by João Pedro Souza on 30/05/16.
//  Copyright © 2016 JoaoWilker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>

@interface GooglePlusDataViewController : UIViewController

@property (strong, nonatomic) GIDGoogleUser *googleProfile;

@end
