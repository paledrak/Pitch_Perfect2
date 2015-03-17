//
//  RecordedAudio.swift
//  Pitch_Perfect2
//
//  Created by robjohn on 3/13/15.
//  Copyright (c) 2015 Robert Johnston. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject{
    var filePathUrl: NSURL
    var title: String
    
   init(filePathUrl: NSURL, title: String) {
    self.filePathUrl = filePathUrl
    self.title = title
    

    }
    
    
//    recordedAudio.filePathUrl = recorder.url
//    recordedAudio.title = recorder.url.lastPathComponent
  


}
