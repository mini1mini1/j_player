//
//  TestView2.swift
//  j_player
//
//  Created by Byunggil Min on 2020/09/02.
//  Copyright © 2020 Byungkil Min. All rights reserved.
//

import SwiftUI

struct TestView2: View {
    


    
    @State private var offset: CGFloat = 0
    @State private var index = 0
    
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    .appendingPathComponent("HeroesDatabase.sqlite")
    
    var users_ori = [UserMode(name:"민병길",hobby:"독서",image:Image("kitty"),age:"jj"),
    UserMode(name:"민병현",hobby:"낚시",image:Image("flower"),age:"jj")]
    
    var users = [UserMode]()
    
    init() {
        print("sfd")
        
        print("ds")
        testDB()
        
        populatePickerView(um: &users)
        
        for ele in users_ori {
        
        users.append(ele)
        }
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
    
    var db:DBHelper = DBHelper()
    
    var persons:[Person] = []
    
    mutating func testDB() {
        
        db.insert(id: 1, name: "Bilal", age: 24)
        db.insert(id: 2, name: "Bosh", age: 25)
        db.insert(id: 3, name: "Thor", age: 23)
        db.insert(id: 4, name: "Edward", age: 44)
        db.insert(id: 5, name: "Ronaldo", age: 34)
        
        persons = db.read()
        
        print(persons)
    }
}

struct TestView2_Previews: PreviewProvider {
    static var previews: some View {
        TestView2()
    }
}
