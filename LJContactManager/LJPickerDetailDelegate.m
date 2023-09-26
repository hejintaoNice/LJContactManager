//
//  LJPickerDetailDelegate.m
//  Demo
//
//  Created by LeeJay on 2017/4/24.
//  Copyright © 2017年 LeeJay. All rights reserved.
//

#import "LJPickerDetailDelegate.h"

@implementation LJPickerDetailDelegate 

#pragma mark - CNContactPickerDelegate

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    CNContact *contact = contactProperty.contact;
    
    NSString *name = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
    CNPhoneNumber *phoneValue= contactProperty.value;
    if ([phoneValue isKindOfClass:[CNPhoneNumber class]])
    {
        if (self.handler)
        {
            self.handler(name, phoneValue.stringValue);
        }
    }
    else
    {
        // 邮箱
        if (self.handler)
        {
            self.handler(name, (NSString *)phoneValue);
        }
    }
}

@end
