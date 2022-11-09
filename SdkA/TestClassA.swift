//
//  TestClassA.swift
//  SdkA
//
//  Created by Lorenzo Limoli on 04/11/22.
//

@_implementationOnly import SdkBStatic
@_implementationOnly import SwiftDate

public final class TestClassA{
    
    public init() {}
    
    public func foo(){
        print(DateInRegion())
    }
    
    public func requestedForAccess(completion: @escaping ( _ accessGranted: Bool)->Void){
        
        ContactUtility.shared.requestedForAccess(completion: completion)
    }
}
