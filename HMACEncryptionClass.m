//
//  HMACEncryptionClass.m
//  HMACEncryption
//
//  Created by Suraj Mirajkar on 07/12/12.
//  Copyright (c) 2012 suraj. All rights reserved.
//

#import "HMACEncryptionClass.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation HMACEncryptionClass

//  Method to Encrypt parameters - Take string as parameter and returns Encrypted data
-(NSString *)encryptKeyValues: (NSString *) stringToEncrypt {
    NSString *encryptedData = @"";
    
    NSLog(@"stringToEncrypt: %@",stringToEncrypt);
    
    NSString *key=@"PassKey123";
    
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [stringToEncrypt cStringUsingEncoding:NSASCIIStringEncoding];
    char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    encryptedData = [self stringWithHexFromData:HMAC];
    //NSLog(@"encryptedData :- %@",encryptedData);
    return encryptedData;
}

// Romoves empty spaces from data
- (NSString *)stringWithHexFromData:(NSData *)data
{
    NSString *result = [[data description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result substringWithRange:NSMakeRange(1, [result length] - 2)];
    return result;
}

// Method to convert NSData to Base64 - it takes NSData as input and returns Base64 encoded NSString
+ (NSString*)base64forData:(NSData*)theData {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

@end
