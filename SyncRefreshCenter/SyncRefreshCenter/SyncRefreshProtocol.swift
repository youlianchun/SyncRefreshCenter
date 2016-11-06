//
//  SyncRefreshProtocol.swift
//  SyncRefreshCenter
//
//  Created by YLCHUN on 16/11/5.
//  Copyright © 2016年 ylchun. All rights reserved.
//

import Foundation
import UIKit

public protocol SyncRefreshProtocol {
    @discardableResult func syncRefreshMount(obj: AnyObject, key: String) -> Bool;
    @discardableResult func syncRefreshMount(obj: AnyObject) -> Bool;
    
    @discardableResult func syncRefreshUnMount(obj: AnyObject) -> Bool;
    
    func syncRefreshEvent(name: String?, object:AnyObject?);
}

extension SyncRefreshProtocol {
    @discardableResult func syncRefreshMount(obj: AnyObject, key: String) -> Bool {
        return SyncRefreshMount.Mount(obj: obj, key: key)
    }
    
    @discardableResult func syncRefreshMount(obj: AnyObject) -> Bool {
        return SyncRefreshMount.Mount(obj: obj)
    }
    
    @discardableResult func syncRefreshUnMount(obj: AnyObject) -> Bool {
        return SyncRefreshMount.unMount(obj: obj)
    }
    
}
