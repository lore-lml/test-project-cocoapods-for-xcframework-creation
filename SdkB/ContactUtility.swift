//
//  ContactUtility.swift
//  SdkB
//
//  Created by Lorenzo Limoli on 04/11/22.
//

import Contacts
import libPhoneNumber_iOS


public class ContactUtility: NSObject
{
    private let contactStore = CNContactStore()
//    private var contacts: [CNContact]?
    
    public static let shared: ContactUtility = ContactUtility()
    
    public var contactAuthorizatinStatus: CNAuthorizationStatus{
        CNContactStore.authorizationStatus(for: CNEntityType.contacts)
    }
    
    public func requestedForAccess(completion: @escaping ( _ accessGranted: Bool)->Void)
    {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        switch authorizationStatus
        {
            case .authorized:
                completion(true)
            case .notDetermined,.denied:
                self.contactStore.requestAccess(for: CNEntityType.contacts  ) { access, accessError in
                    if access {
                        completion(access)
                    }else if authorizationStatus == .denied{
                        completion(false)
                    }
            }
            default:
            completion(false)
        }
    }
}

