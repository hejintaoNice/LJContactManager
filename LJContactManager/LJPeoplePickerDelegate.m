//
//  LJPeoplePickerDelegate.m
//  LJContactManager
//
//  Created by LeeJay on 2017/3/22.
//  Copyright © 2017年 LeeJay. All rights reserved.
//

#import "LJPeoplePickerDelegate.h"

@implementation LJPeoplePickerDelegate

#pragma mark - CNContactViewControllerDelegate

- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(CNContact *)contact
{
    if (self.completcion)
    {
        self.completcion(YES);
    }
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
    if (self.completcion)
    {
        self.completcion(NO);
    }
}

#pragma mark - Private

/**
 将号码添加某人的通讯录 (iOS 9 以上)

 @param phoneNum 号码
 @param contact 联系人
 @param controller 控制器
 */
- (void)_addToExistingContactsWithPhoneNum:(NSString *)phoneNum
                                   contact:(CNContact *)contact
                                controller:(UIViewController *)controller
{
    CNMutableContact *mutableContact = [contact mutableCopy];
    
    CNLabeledValue *phoneNumber = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile
                                                                  value:[CNPhoneNumber phoneNumberWithStringValue:phoneNum]];
    
    if (mutableContact.phoneNumbers.count > 0)
    {
        NSMutableArray *phoneNumbers = [mutableContact.phoneNumbers mutableCopy];
        [phoneNumbers addObject:phoneNumber];
        mutableContact.phoneNumbers = phoneNumbers;
    }
    else
    {
        mutableContact.phoneNumbers = @[phoneNumber];
    }

    CNContactViewController *contactController = [CNContactViewController viewControllerForNewContact:mutableContact];
    contactController.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:contactController];
    [controller presentViewController:nav animated:YES completion:nil];
}

@end
