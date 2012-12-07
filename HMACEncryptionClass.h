//
//  HMACEncryptionClass.h
//  HMACEncryption
//
//  Created by Suraj Mirajkar on 07/12/12.
//  Copyright (c) 2012 suraj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMACEncryptionClass : NSObject {
    
}
-(NSString *)encryptKeyValues: (NSString *) stringToEncrypt;
- (NSString *)stringWithHexFromData:(NSData *)data;
+ (NSString*)base64forData:(NSData*)theData;

@end
