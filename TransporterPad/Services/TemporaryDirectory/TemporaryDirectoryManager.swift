//
//  TemporaryDirectoryManager.swift
//  TransporterPad
//
//  Created by Nobuhiro Ito on 2017/09/22.
//  Copyright © 2017年 Nobuhiro Ito. All rights reserved.
//

import Cocoa

class TemporaryDirectoryManager {

    let baseURL: URL
    
    init?() {
        let fm = FileManager.default
        let cacheURL = fm.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        guard let url = try? fm.url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: cacheURL, create: true) else { return nil }
        baseURL = url
    }
    
    func create() -> TemporaryDirectory? {
        let fm = FileManager.default
        let target = fm.createTemporaryName(inDirectoryURL: baseURL)
        if ((try? fm.createDirectory(at: target, withIntermediateDirectories: true, attributes: nil)) != nil) {
            return TemporaryDirectory(url: target)
        }
        else {
            return nil
        }
    }
    
    func cleunup() {
        try? FileManager.default.removeItem(at: baseURL)
    }
}