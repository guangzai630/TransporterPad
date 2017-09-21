//
//  Device.swift
//  TransporterPad
//
//  Created by Nobuhiro Ito on 2017/09/18.
//  Copyright © 2017年 Nobuhiro Ito. All rights reserved.
//

import Foundation
import EBIMobileDeviceWatcher

class Device: NSObject {

    /// プラットフォーム
    let platform: Platform
    
    let formfactorName: String

    /// 端末名
    var name: String {
        willSet {
            self.willChangeValue(forKey: "name")
        }
        didSet {
            self.didChangeValue(forKey: "name")
        }
    }

    /// シリアルナンバー
    let serialNumber: String

    /// 端末の認識状態
    var status: DeviceStatus = .Initializing

    /// 最終の転送ログ
    var log: String = ""

    /// 対応するモバイルデバイスインスタンス
    weak var mobileDevice: EBIMobileDevice?
    
    init(device: EBIMobileDevice) {
        mobileDevice = device
        
        serialNumber = device.serialNumber
        if (device.type == EBIMobileDeviceTypeAndroid) {
            platform = .Android
            formfactorName = "Android"
            name = device.deviceName
        }
        else {
            platform = .iOS
            formfactorName = device.deviceName
            name = ""
        }
    }
}

extension Device {

    func equals(mobileDevice: EBIMobileDevice) -> Bool {
        if (self.platform == .iOS) && (mobileDevice.type == EBIMobileDeviceTypeIOS) {
        }
        else if (self.platform == .Android) && (mobileDevice.type == EBIMobileDeviceTypeAndroid) {
        }
        else {
            return false
        }
        
        if self.name.caseInsensitiveCompare(mobileDevice.deviceName) != .orderedSame {
            return false
        }
        if self.serialNumber.caseInsensitiveCompare(mobileDevice.serialNumber) != .orderedSame {
            return false
        }
        
        return true
    }
}
