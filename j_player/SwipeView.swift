//
//  SwipeView.swift
//  j_player
//
//  Created by Byunggil Min on 2020/08/19.
//  Copyright © 2020 Byungkil Min. All rights reserved.
//

import SwiftUI
import SQLite3

struct SwipeView: View {
    @State private var offset: CGFloat = 0
    @State private var index = 0
    /*
    var users_ori = [UserMode(name:"민병길",hobby:"독서",image:Image("kitty"),age:42),
    UserMode(name:"민병현",hobby:"낚시",image:Image("flower"),age:40)]
    */
    var users = [UserMode]()
    
    init() {
        
        copyDatabase("test")
        populatePickerView(um: &users)
        /*
        for ele in users_ori {
        
        users.append(ele)
        }*/
    }
    
    
    let spacing: CGFloat = 10

    var body: some View {
        
        GeometryReader { geometry in
            return ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: self.spacing) {
                    ForEach(self.users, id: \.id) { user in
                        UserView(userMode: user)
                            .frame(width: geometry.size.width)
                    }
                }
            }
            .content.offset(x: self.offset)
            .frame(width: geometry.size.width, alignment: .leading)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
                    })
                    .onEnded({ value in
                        if -value.predictedEndTranslation.width > geometry.size.width / 2, self.index < self.users.count - 1 {
                            self.index += 1
                        }
                        if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
                            self.index -= 1
                        }
                        withAnimation { self.offset = -(geometry.size.width + self.spacing) * CGFloat(self.index) }
                    })
            )
        }
    }
    
    
}

func populatePickerView(um: inout [UserMode]) {
    
    print("ESf")
    
     let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
               .appendingPathComponent("test.db")
    var db: OpaquePointer?
    if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
                print("error opening database")
            }
    else
    {
        print("Successfully opened connection to database")
        
    }
    
    let queryStatementString = "SELECT * FROM word1;"
    var queryStatement: OpaquePointer? = nil

    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        print("ds")

        while sqlite3_step(queryStatement) == SQLITE_ROW {

            let id = sqlite3_column_int(queryStatement, 0)

            let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
            let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
            let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
            
            let qRC1 = String(cString: queryResultCol1!)
            let qRC2 = String(cString: queryResultCol2!)
            let qRC3 = String(cString: queryResultCol3!)

            print("\(id) | \(qRC1) | \(qRC2) | \(qRC3) ")
            
            let user_ele :UserMode = UserMode(name:qRC1,hobby:qRC2,image:Image("kitty"),age:qRC3)
            um.append(user_ele)
            

        }
    } else {
        print("fail")
        // Fail
    }

    sqlite3_finalize(queryStatement)
    
}


func copyDatabaseIfNeeded(_ database: String) {

    let fileManager = FileManager.default

    let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)

    guard documentsUrl.count != 0 else {
        return
    }

    let finalDatabaseURL = documentsUrl.first!.appendingPathComponent("\(database).db")

    if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
        print("DB does not exist in documents folder")

        let databaseInMainBundleURL = Bundle.main.resourceURL?.appendingPathComponent("\(database).db")

        do {
            try fileManager.copyItem(atPath: (databaseInMainBundleURL?.path)!, toPath: finalDatabaseURL.path)
        } catch let error as NSError {
            print("Couldn't copy file to final location! Error:\(error.description)")
        }

    } else {
        print("Database file found at path: \(finalDatabaseURL.path)")
    }
}

func copyDatabase(_ database: String) {

    let fileManager = FileManager.default

    let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)

    guard documentsUrl.count != 0 else {
        return
    }

    let finalDatabaseURL = documentsUrl.first!.appendingPathComponent("\(database).db")
    do {
        try fileManager.removeItem(at: finalDatabaseURL)
    } catch let error as NSError {
        print("Couldn't remove file \(error.description)")
    }
    
    let databaseInMainBundleURL = Bundle.main.resourceURL?.appendingPathComponent("\(database).db")

    do {
        try fileManager.copyItem(atPath: (databaseInMainBundleURL?.path)!, toPath: finalDatabaseURL.path)
    } catch let error as NSError {
        print("Couldn't copy file to final location! Error:\(error.description)")
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}
