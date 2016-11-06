//
//  SyncRefreshEvent.swift
//  SyncRefreshCenter
//
//  Created by YLCHUN on 16/11/5.
//  Copyright © 2016年 ylchun. All rights reserved.
//

import Foundation

class SyncRefreshEvent {
    static let kName_unMount = "kSyncRefresh_unMount"

    private(set) var cls : AnyClass?
    private(set) var key : String?
    private(set) var name : String?
    private(set) var object : AnyObject?
    
    init(cls: AnyClass? = nil, key: String? = nil, name: String? = nil, object: AnyObject? = nil) {
        self.cls = cls
        self.key = key
        self.name = name
        self.object = object
    }
}
