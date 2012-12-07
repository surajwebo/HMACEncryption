//
//  ViewController.m
//  HMACEncryption
//
//  Created by Suraj Mirajkar on 07/12/12.
//  Copyright (c) 2012 suraj. All rights reserved.
//

#import "ViewController.h"
#import "HMACEncryptionClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *values=@"";
    values = [values stringByAppendingString:@"Parameter 1"];
    values = [values stringByAppendingString:@"Parameter 2"];
    NSLog(@"Values: %@",values);
    
    HMACEncryptionClass *encryptParameters = [[HMACEncryptionClass alloc] init];
    NSString *encryptedSignedValue = [encryptParameters encryptKeyValues: values];
    NSLog(@"Encrypted String: %@",encryptedSignedValue);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
