//
//  SyncRefreshCenter.swift
//  SyncRefreshCenter
//
//  Created by YLCHUN on 16/11/4.
//  Copyright © 2016年 ylchun. All rights reserved.
//

import Foundation

class SyncRefreshCenter {
    
    static let kSyncRefreshNotificationName = NSNotification.Name(rawValue: "kSyncRefreshNotificationName")
    
    static private var center = SyncRefreshCenter()
    
    static var shared : SyncRefreshCenter {
        return SyncRefreshCenter.center
    }
    
    private lazy var mountDict : Dictionary<String, SyncRefreshMount> = Dictionary()
    
    private init() {}
    
    private lazy var mountArray : Array<SyncRefreshMount> = Array()
    
    
    func mount(syncRefreshMount : SyncRefreshMount) -> Bool{
        mountDict[syncRefreshMount.id] = syncRefreshMount
        return mountDict[syncRefreshMount.id] != nil
    }
    
    func unMount(syncRefreshMount : SyncRefreshMount) -> Bool {
        mountDict.removeValue(forKey: syncRefreshMount.id)
        return mountDict[syncRefreshMount.id] == nil
    }
    
    func mount(id : String) -> SyncRefreshMount? {
        return mountDict[id];
    }
    
    private func postEvent(cls: AnyClass? = nil, key: String? = nil, name: String? = nil, object: AnyObject? = nil) {
        let event = SyncRefreshEvent(cls: cls, key: key, name: name, object: object)
        NotificationCenter.default.post(name: SyncRefreshCenter.kSyncRefreshNotificationName, object: event, userInfo: nil)
    }
    
    static func postEvent(cls: AnyClass? = nil, key: String? = nil, name: String? = nil, object: AnyObject? = nil) {
        SyncRefreshCenter.shared.postEvent(cls: cls, key: key, name: name, object: object)
    }
    
    static func postUnMountEvent(cls: AnyClass?, key: String?) {
        SyncRefreshCenter.shared.postEvent(cls: cls, key: key, name: SyncRefreshEvent.kName_unMount)
    }
    
}

