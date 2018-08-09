//
//  Item.swift
//  FirebaseWithSwift
//
//  Created by chetumacmini on 07/08/18.
//  Copyright © 2018 StrataGLyricalConcepts. All rights reserved.
//

import Foundation
import FirebaseDatabase
class Item {
    
    var ref: DatabaseReference?
    var title: String?
    
    init (snapshot: DataSnapshot) {
        ref = snapshot.ref
        
        let data = snapshot.value as! Dictionary<String, String>
        title = data["title"]! as String
    }
    
}
