//
//  imoyaoViewController.m
//  imoyao
//
//  Created by xuyazhong on 01/07/2019.
//  Copyright (c) 2019 xuyazhong. All rights reserved.
//

#import "imoyaoViewController.h"
#import <imoyao/imoyao.h>

@interface imoyaoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ssidLbl;
@property (weak, nonatomic) IBOutlet UITextField *passwdTF;

@end

@implementation imoyaoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *ssid = [[imoyao sharedMoyao] getSSID];
    NSString *bssid = [[imoyao sharedMoyao] getBSSID];
    self.ssidLbl.text = [NSString stringWithFormat:@"ssid: [%@]\nbssid: [%@]", ssid, bssid];
    
    NSLog(@"ABCD => [%@]", [[imoyao sharedMoyao] crc:@"ABCD"]);
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)actionClick:(id)sender {
    
    if (self.passwdTF.text.length == 0) {
        NSLog(@"请输入无线密码");
        return;
    }
    
    [[imoyao sharedMoyao] Connect:self.passwdTF.text block:^(BOOL isSucc, NSString *result) {
        if (isSucc) {
            NSString *ipAdd = [NSString stringWithFormat:@"ip =>[%@]", result];
            [self alert:@"Execute Result success" message:ipAdd];
        } else {
            [self alert:@"Execute Result failure" message:result];
        }
    }];
}

- (void)alert:(NSString *)title message:(NSString *)msg {
    [[[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil]show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
