//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Zohaib Maqsood on 4/4/15.
//  Copyright (c) 2015 Xeb. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    override init() {}
    init(filePathUrl: NSURL){
        self.filePathUrl = filePathUrl;
        self.title = filePathUrl.lastPathComponent;
    }
}