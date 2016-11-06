//
//  SyncRefreshMount.swift
//  SyncRefreshCenter
//
//  Created by YLCHUN on 16/11/5.
//  Copyright © 2016年 ylchun. All rights reserved.
//

import Foundation
import UIKit

class SyncRefreshMount {
    private(set) weak var obj : AnyObject?
    private(set) var cls : AnyClass
    private(set) var key : String?
    private(set) var id : String
    private(set) var didMount : Bool = false
    
    private init(id: String? = nil, obj: AnyObject, key: String = "") {
        self.obj = obj
        self.key = key
        if let id = id {
            self.id = id
        }else {
            self.id = SyncRefreshMount.mountId(obj: obj)
        }
        self.cls = obj.classForCoder
    }
    
    class func mountId(obj: AnyObject) -> String {
        let id = "\(obj)".components(separatedBy: ": ")[1].components(separatedBy: ">")[0]
        return id
    }
    
    class func Mount(obj: AnyObject, key: String = "") -> Bool {
        if let _ = obj as? SyncRefreshProtocol {
            let id = mountId(obj: obj)
            if let mount = SyncRefreshCenter.shared.mount(id: id) {
                mount.key = key
                mount.obj = obj
                mount.cls = obj.classForCoder
                mount.id = id
            }else {
                let syncRefreshMount = SyncRefreshMount(id: id, obj: obj, key: key)
                syncRefreshMount.mount()
            }
            return true
        }else {
            return false
        }
    }
    
    class func unMount(obj: AnyObject) -> Bool {
        if let _ = obj as? SyncRefreshProtocol {
            let id = mountId(obj: obj)
            if let mount = SyncRefreshCenter.shared.mount(id: id) {
                mount.unMount()
            }
            return true
        }else {
            return false
        }
    }

    
    private func mount() {
        if SyncRefreshCenter.shared.mount(syncRefreshMount: self) {
            syncRefresh(toMount: true)
        }
    }
    
    private func unMount() {
        if SyncRefreshCenter.shared.unMount(syncRefreshMount: self) {
            syncRefresh(toMount: false)
        }
    }
    
    private func syncRefresh(toMount: Bool) {
        if toMount {
            if !didMount {
                NotificationCenter.default.addObserver(self, selector: #selector(syncRefreshEvent(notification:)), name: SyncRefreshCenter.kSyncRefreshNotificationName, object: nil)
                didMount = true
            }
        }else {
            if didMount {
                NotificationCenter.default.removeObserver(self, name: SyncRefreshCenter.kSyncRefreshNotificationName, object: nil)
                didMount = false
            }
        }
    }
    
    @objc private func syncRefreshEvent(notification: Notification) {
        if let syncRefreshEvent = notification.object as? SyncRefreshEvent {
            if syncRefreshEventInspection(event: syncRefreshEvent) {
                let sObj = self.obj as? SyncRefreshProtocol
                sObj?.syncRefreshEvent(name: syncRefreshEvent.name, object: syncRefreshEvent.object)
            }
        }
    }
    
    private func syncRefreshEventInspection(event: SyncRefreshEvent) -> Bool {
        if self.obj != nil {
            if (event.cls == nil) || (event.cls == self.cls && event.key == self.key) {
                if event.name == SyncRefreshEvent.kName_unMount {
                    unMount()
                    return false
                }else {
                    return true
                }
            }else {
                return false
            }
        }else {
            unMount()
            return false
        }
    }
    
    deinit {
        syncRefresh(toMount: false)
    }
}
