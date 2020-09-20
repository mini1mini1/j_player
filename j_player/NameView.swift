import SwiftUI

struct NameView: View {
    let name: String
    let age: String
    let hobby: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("\(name), \(age)")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white).opacity(0.6)
            Text(hobby)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .foregroundColor(.white).opacity(0.6)
        }
        .padding()
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView(name: "민병길",age: "tt",hobby: "독서")
    }
}
