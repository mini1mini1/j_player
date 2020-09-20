
import SwiftUI

struct TestView: View {
    
    init() {
        print("ds")
        testDB()
    }
    
    
    var body: some View {
        Text("Hello, World!gg")
        
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

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
        
    }
}

