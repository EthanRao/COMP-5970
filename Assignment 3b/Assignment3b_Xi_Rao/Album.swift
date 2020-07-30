//
//  Album.swift
//  Assignment3b_Xi_Rao
//
//  Created by Xi Rao on 7/29/20.
//  Copyright © 2020 Xi Rao. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Album: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(cover, forKey: PropertyKey.cover)
        aCoder.encode(artist, forKey: PropertyKey.artist)
        aCoder.encode(releasedYear, forKey: PropertyKey.releasedYear)
        aCoder.encode(recordLabel, forKey: PropertyKey.recordLabel)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The title and artist are required. If we cannot decode a name string, the initializer should fail.
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Unable to decode the name for a Album object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let artist = aDecoder.decodeObject(forKey: PropertyKey.artist) as? String else {
            os_log("Unable to decode the name for a Album object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because cover is an optional property of Album, just use conditional cast.
        let cover = aDecoder.decodeObject(forKey: PropertyKey.cover) as? UIImage
        let releasedYear = aDecoder.decodeObject(forKey: PropertyKey.releasedYear) as? String
        let recordLabel = aDecoder.decodeObject(forKey: PropertyKey.recordLabel) as? String

        self.init(title: title, cover: cover, artist: artist, releasedYear: releasedYear!, recordLabel: recordLabel!)
    }
    
    
    //MARK: properties
    var title: String
    var cover: UIImage?
    var artist: String
    var releasedYear: String
    var recordLabel: String
    
    //Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("albums")

    //MARK: Types
    struct PropertyKey {
        static let title = "title"
        static let artist = "artist"
        static let cover = "cover"
        static let releasedYear = "releasedYear"
        static let recordLabel = "recordLabel"
    }
    
    //MARK: Initializer
    init?(title: String, cover: UIImage?, artist: String, releasedYear: String, recordLabel: String) {
        
        if title.isEmpty || artist.isEmpty {
            return nil
        }
        
        self.title = title
        self.cover = cover
        self.artist = artist
        self.releasedYear = releasedYear
        self.recordLabel = recordLabel
        
    }
}
