//
//  SwipeView.swift
//  j_player
//
//  Created by Byunggil Min on 2020/08/19.
//  Copyright © 2020 Byungkil Min. All rights reserved.
//

import SwiftUI
import SQLite3
import AVFoundation

struct SwipeView: View {
    @State private var offset: CGFloat = 0
    @State private var index = 0
    
    var users = [UserMode]()
    
    let synth = AVSpeechSynthesizer()
    
    init() {
        
        copyDatabase("test")
        populatePickerView(um: &users)
        
    }
    
    
    let spacing: CGFloat = 10

    var body: some View {
        
        ZStack{
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
                            
                            readText(users[self.index].name)
                            
                            readText(users[self.index].age)
                        })
                )
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button(action: {
                        
                        
                        readText(users[self.index].name)
                        
                        readText(users[self.index].age)
                        
                        
                        print(users[self.index].name)
                    }) {
                        HStack {
                            Image(systemName: "speaker")
                                .font(.title)
                            /*Text("Sound")
                                .fontWeight(.semibold)
                                .font(.title)*/
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(40)
                    }
                }
                           
            }
            
        }
        
        
    }
    
    private func readText(_ text:String) {
        if let language = NSLinguisticTagger.dominantLanguage(for: text) {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: language)

            //control speed and pitch
            utterance.pitchMultiplier = 1
            utterance.rate = 0.4
            utterance.preUtteranceDelay = 0.6
            //utterance.postUtteranceDelay = 0.2
            synth.speak(utterance)
            
        } else {
            
            print("Unknown language")
            
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
    
    let queryStatementString = "SELECT * FROM word2;"
    var queryStatement: OpaquePointer? = nil

    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        print("ds")

        while sqlite3_step(queryStatement) == SQLITE_ROW {

            _ = sqlite3_column_int(queryStatement, 0)

            let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
            let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
            let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
            
            let qRC1 = String(cString: queryResultCol1!)
            let qRC2 = String(cString: queryResultCol2!)
            let qRC3 = String(cString: queryResultCol3!)

            print(" \(qRC1) | \(qRC2) | \(qRC3) ")
            
            let user_ele :UserMode = UserMode(name:qRC1,hobby:qRC2,image:Image("kitty"),age:qRC3)
            um.append(user_ele)
            

        }
    } else {
        print("fail")
        // Fail
    }

    sqlite3_finalize(queryStatement)
    
}

/*
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
 */

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
